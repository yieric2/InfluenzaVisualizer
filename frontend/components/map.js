let map = null;
const markers = [];

export async function initMap() {
  const position = { lat: 40.098432, lng: -100.189222 };
  const { Map } = await google.maps.importLibrary("maps");
  const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");
  map = new Map(
    document.getElementById('map'),
    {
      zoom: 4,
      center: position,
      mapId: 'GmapID',
      mapTypeControl: false,
      fullscreenControl: false,
      streetViewControl: false,
      zoomControl: true,
      zoomControlOptions: {
        position: google.maps.ControlPosition.LEFT_CENTER
      },
      scaleControl: true,
      rotateControl: true,
      rotateControlOptions: {
        position: google.maps.ControlPosition.LEFT_CENTER
      },
      gestureHandling: "greedy"
    }
  );

  function create_marker(provider) {
    const marker = new AdvancedMarkerElement({
      map: map,
      position: provider.coords
    });
    const infoWindow = new google.maps.InfoWindow({
      content: `<h5> ${provider.city} </h5>` + `<p><b>Store number: ${provider.number}</b></p>`
    });
    marker.addListener("click", () => {
      infoWindow.open(map, marker);
      setInterval (() => {
        infoWindow.close(map, marker);
      }
      , 5000);
    });
    markers.push(marker);
  }

  // /Application/api/locationsAPI.cfm"
  // /Application/api/JsonExample.json
  fetch("/Application/api/locationsAPI.cfm")
    .then((response) => response.json())
    .then((json) => {
      const { COLUMNS, DATA } = json;
      const latIndex = COLUMNS.indexOf("LAT");
      const lngIndex = COLUMNS.indexOf("LNG");
      const numberIndex = COLUMNS.indexOf("PHONENUM");
      const cityIndex = COLUMNS.indexOf("CITY");
      DATA.forEach((item) => {
        const latitude = item[latIndex];
        const longitude = item[lngIndex];
        const city = item[cityIndex];
        const number = item[numberIndex] 
        create_marker({ coords: { lat: latitude, lng: longitude }, city: city, number: number});
      });
      const markerCluster = new markerClusterer.MarkerClusterer({ markers, map });
    })
    .catch((error) => {
      console.error("Error:", error);
    });
}

initMap();

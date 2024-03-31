let map = null;
const markers = [];
async function initMap() {
  const position = { lat: 44.098432, lng: -105.189222 };
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
      content: provider.city
    });
    marker.addListener("click", () => {
      infoWindow.open(map, marker);
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
      const cityIndex = COLUMNS.indexOf("CITY");
      DATA.forEach((item) => {
        const latitude = item[latIndex];
        const longitude = item[lngIndex];
        const city = item[cityIndex];
        console.log(latitude, longitude, city)
        create_marker({ coords: { lat: latitude, lng: longitude }, city: city });
      });

      const markerCluster = new markerClusterer.MarkerClusterer({ markers, map });
    })
    .catch((error) => {
      console.error("Error:", error);
    });
}

initMap();

let map = null;
let markers = [];
let position = { lat: 41.098432, lng: -99.189222 };
let zoom = 4;
const clustStyle = [
  {
    textColor: "white",
    url: "images/BlueCircle.png",
    height: 50,
    width: 50,
  },
  {
    textColor: "white",
    url: "images/BlueCircle.png",
    height: 50,
    width: 50,
  },
  {
    textColor: "white",
    url: "images/RedCircle.png",
    height: 50,
    width: 50,
  },
]

const mcOptions = {
  styles: clustStyle,
  maxZoom: 10,
  gridSize: 50
  // averageCenter: true,
  // minimumClusterSize: 2,
  // zoomOnClick: true,
  // imagePath: "./images/m",
  // imageExtension: "png",
}

async function initMap() {
  const { Map } = await google.maps.importLibrary("maps");
  const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");
  map = new Map(
    document.getElementById('map'),
    {
      zoom: zoom,
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
  function formatPhoneNumber(input) {
    let stringInput = input.toString().split('.')[0];  
    return stringInput.replace(/(\d{3})(\d{3})(\d{4})/, '($1) $2-$3');
    };


  function create_marker(provider) {
    const marker = new AdvancedMarkerElement({
      map: map,
      position: provider.coords
    });
    const infoWindow = new google.maps.InfoWindow({
      content: `<h5> ${provider.city} </h5>` + `<p><b>Store number: ${formatPhoneNumber(provider.number)}</b></p>`
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
  fetch("/Projects/backend/api/Page1Apis/locationsAPI.cfm")
    .then((response) => response.json())
    .then((json) => {
      const { COLUMNS, DATA } = json;
      const latIndex = COLUMNS.indexOf("LAT");
      const lngIndex = COLUMNS.indexOf("LNG");
      const numberIndex = COLUMNS.indexOf("PHONENUM");
      const cityIndex = COLUMNS.indexOf("CITY");
      DATA.forEach((item) => {
        const latitude =  item[lngIndex];
        const longitude = item[latIndex];
        const city = item[cityIndex];
        const number = item[numberIndex] 
        create_marker({ coords: { lat: latitude, lng: longitude }, city: city, number: number});
      });
      const markerCluster = new markerClusterer.MarkerClusterer({ markers, map,renderer: {
        render : ({markers, _position: position}) => {
          return new google.maps.Marker({
            position,
            icon: {
              url: "images/Perfected_BlueCircle.png",
              scaledSize: new google.maps.Size(50, 50),
            },
            label: {
              text: markers.length.toString(),
              color: "white",
              fontSize: "16px",
            },

          });
        }
      }});
    })
    .catch((error) => {
      console.error("Error:", error);
    });
	const googleFont = document.querySelector('link[rel="stylesheet"][href*="fonts.googleapis.com"]');
    if (googleFont) {
      googleFont.remove();
    }
}

initMap();
export { initMap };
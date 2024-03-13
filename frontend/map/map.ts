let map;
async function initMap(): Promise<void> {
  const position = { lat: 44.098432, lng: -103.189222};
  const { Map } = await google.maps.importLibrary("maps") as google.maps.MapsLibrary;
  const { AdvancedMarkerElement } = await google.maps.importLibrary("marker") as google.maps.MarkerLibrary;

  map = new Map(
    document.getElementById('map') as HTMLElement,
    {
      zoom: 4,
      center: position,
      mapId: 'GmapID', 
      //Will be configuring the map to remove the extra features
    }
  );


  function create_marker(props) {
    const marker = new google.maps.Marker({
      map: map,
      position: props.coords, 
    });
    const infoWindow = new google.maps.InfoWindow({
      content: props.loc, 
      maxWidth: 100,
    });
    marker.addListener("click", () => {
      infoWindow.open(map, marker);
    });
  }
  

  ///FrontEnd_App/frontend/APIScript/FluProviderLocations.cfm
  fetch("/FrontEnd_App/frontend/APIScript/JsonExample.json")
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
      create_marker({coords: { lat: latitude, lng: longitude }, loc: `<h1>${city}</h1>`});
    });
  })
  .catch((error) => {
    console.error("Error:", error);
  });
}

initMap();

let map : google.maps.Map | null = null;
import {Location} from "./types/Locations.ts"
//import { MarkerClusterer } from "@googlemaps/markerclusterer";

export default async function initMap(): Promise<void> {
  const position = { lat: 44.098432, lng: -103.189222};
  const { Map } = await google.maps.importLibrary("maps") as google.maps.MapsLibrary;
  const { AdvancedMarkerElement } = await google.maps.importLibrary("marker") as google.maps.MarkerLibrary;
  const markers : google.maps.marker.AdvancedMarkerElement[] = [];

  map = new Map(
    document.getElementById('map') as HTMLElement,
    {
      zoom: 3,
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
      panControl: true,
      panControlOptions: {
        position: google.maps.ControlPosition.LEFT_CENTER
      },
      gestureHandling: "greedy"
    }
  );

  function create_marker(provider : Location) : void {
    //const pin =  new google.maps.marker.PinElement({ glyph: provider.city, glyphColor: "black"})
    const marker = new AdvancedMarkerElement({
      map: map,
      position: provider.coords,
      //content : pin.element
    });
    const infoWindow = new google.maps.InfoWindow({
      content: provider.city
    });
    marker.addListener("click", () => {
      infoWindow.open(map, marker);
    });
    markers.push(marker);
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
      create_marker({ coords: { lat: latitude, lng: longitude }, city: city });
    });
  })
  .catch((error) => {
    console.error("Error:", error);
  });
  //const clusters = new MarkerClusterer({ map: map, markers : markers, algorithmOptions: { maxZoom: 15 }});

}

initMap();

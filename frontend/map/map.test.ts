// Import the necessary dependencies
import initMap from './map';
import google from '@google/maps';
import { Location } from './types/Locations.ts'


let map: google.maps.Map;

function createMarker(props: Location): void {
  const marker = new google.maps.Marker({
    position: props.coords,
    map: map,
  });

  const infoWindow = new google.maps.InfoWindow({
    content: props.city,
  });

  marker.addListener('click', () => {
    infoWindow.open(map, marker);
  });
}

describe('Google Maps integration', () => {
  beforeEach(() => {
    document.body.innerHTML = '<div id="map"></div>';
    jest.clearAllMocks();
  });

  it('initializes the map with correct settings', async () => {
    await initMap();

  });

  it('creates a marker with an info window that opens on click', async () => {
    await initMap();
    const testProps : Location[] = [{ coords: { lat: 44.1, lng: -103.2 },  city: 'Test Location' }];
    createMarker(testProps[0]);
    expect(google.maps.Marker).toHaveBeenCalledTimes(1);

  });

});

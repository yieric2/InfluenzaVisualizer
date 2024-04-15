import ProviderLocationModel from './ProviderLocationModel.js';
// import { map } from './map.js';


/** 
 * @Constants and @global variables
 *
 */
const APIKEY = 'AIzaSyB3BLIavj4RdlAB92JmXQfJMJiJ9BAGJ4k';
let providerLocationArr = [];
const form = document.querySelector('form');
const providerListElement = document.getElementById('provider-list');
const addressInput = document.getElementById('location');
const providers = document.getElementById('providers');
const queryResult = document.getElementById('queryResult');
const searchButton = document.getElementById('search-btn');
let selectedMiles = ''
let address = ''


// Main function to handle form submission
document.addEventListener('DOMContentLoaded', function() {
  setupDropdownHandlers(); 
  addressInput.addEventListener('input', updateFormState); 
  form.addEventListener('submit', function(event) {
      event.preventDefault();
      providerListElement.classList.add('hidden');
      if (validateFormState()) {
          geocodeAddressandPopulate(address);
      }
  });
});

// Dropdown menu handler for selecting range of miles
function setupDropdownHandlers() {
  const dropdownItems = document.querySelectorAll('.dropdown-item');
  dropdownItems.forEach(item => {
      item.addEventListener('click', function(event) {
          event.preventDefault();
          selectedMiles = this.textContent.trim();
          updateFormState();
      });
  });
}

// Update form state based on user input and dropdown selection
function updateFormState() {
  address = addressInput.value.trim();
  if (!address) {
    selectedMiles = '';
    providerListElement.classList.add('hidden');
  }
  updateQueryResult();
}

// Update query result based on user input and dropdown selection
function updateQueryResult() {
  if (address && selectedMiles) {
      queryResult.innerHTML = `<li class="list-group-item" style="font-weight: bold; font-family: Roboto;">Searching for providers within ${selectedMiles} miles of ${address}</li>`;
      searchButton.classList.remove('hidden');
  }  else {
      console.log('Address:', address, 'Miles:', selectedMiles);
      queryResult.innerHTML = ''; 
      searchButton.classList.add('hidden');
  }
}

// Validate form state before submission
function validateFormState() {
  queryResult.classList.remove('hidden');

  if (!address) {
      queryResult.innerHTML = '<li class="list-group-item">Please enter an address. 🥲</li>';
      console.error('Address is required');
      return false;
  } else if (!selectedMiles) {
      queryResult.innerHTML = '<li class="list-group-item">Please select a range. 🥲</li>';
      console.error('Range selection is required');
      return false;
  }
  return true; 
}



/**
 * Geocodes the given address, fetches nearby locations, and populates the provider list.
 * @param {string} address - The address to geocode.
 * @returns {Promise<void>} - A promise that resolves when the geocoding, fetching, and population is complete.
 */
async function geocodeAddressandPopulate(address) {
  if (!address) {
    console.error('Invalid Address');
    return;
  }
  console.log('Entered Address:', address);
  const url = `https://maps.googleapis.com/maps/api/geocode/json?address=${encodeURIComponent(address)}&key=${APIKEY}`;
  try {
    console.log(url)
    const response = await fetch(url);
    const location = await handleGeocodeResponse(response);
    const nearbyLocations = await fetchNearbyLocations(location);
    const providerData = await handleNearbyLocationsResponse(nearbyLocations);
    console.log("Reached")
    populateProviderList();
  } catch (error) {
    handleError(error);
  }
}

/**
 * Handles the response from a geocoding request.
 *
 * @param {Response} response - The response object from the geocoding request.
 * @returns {Promise<Object>} - A promise that resolves to the location object.
 * @throws {Error} - If the geocoding request fails or no results are found.
 */
function handleGeocodeResponse(response) {
  if (!response.ok) {
    providerListElement.innerHTML = '<li class="list-group-item">Geocoding request failed.<br>Try Providing a more precise location.🥲</li>';
    providerListElement.classList.remove('hidden')
    throw new Error('Geocoding request failed');
  }
  return response.json()
    .then(data => {
      if (data.status === "ZERO_RESULTS" || data.results.length === 0) {
        console.log("No results found");
        providerListElement.innerHTML = '<li class="list-group-item"><strong>Location Not Found:</strong> Your entry was not precise enough to determine a specific location. Please provide a more specific city, address, and/or ZIP code. 🤓</li>';
        providerListElement.classList.remove('hidden')
        console.log(providerListElement.innerHTML);
        throw new Error("No results found");
        r
      }
      return data.results[0].geometry.location;
    });
}

/**
 * Fetches nearby locations based on the provided location coordinates and miles with respect to the location.
 *
 * @param {Object} location - The location object containing latitude and longitude.
 * @param {number} location.lat - The latitude of the location.
 * @param {number} location.lng - The longitude of the location.
 * @param {number} selectedMiles - The selected range in miles.
 * @returns {Promise} A promise that resolves to the JSON response of the nearby locations.
 * @throws {Error} If the network response is not ok.
 */
function fetchNearbyLocations(location) {
  const { lat, lng } = location;
  validateRange(lat,lng);
  const nearbyLocationsUrl = `/Application/api/nearByLocations.cfm?lat=${encodeURIComponent(lat)}&lng=${encodeURIComponent(lng)}&miles=${encodeURIComponent(selectedMiles)}`;
  console.log('Nearby Locations URL:', nearbyLocationsUrl)
  return fetch(nearbyLocationsUrl)
    .then(response => {
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      return response.json();
    });
}

// Handles nearby locations by creating ProviderLocationModel instances for each location and populating the provider list
function handleNearbyLocationsResponse(data) {
  console.log('Nearby Locations:', data);
  providerLocationArr = data.DATA.map(loc => new ProviderLocationModel({
    longitude: loc[0],
    latitude: loc[1],
    walkinsAccepted: loc[2],
    insuranceAccepted: loc[3],
    locAdminZip: loc[4],
    locAdminCity: loc[5],
    locAdminState: loc[6],
    locAdminStreet1: loc[7],
    locPhone: loc[8],
    webAddress: loc[9],
    mondayHours: loc[10],
    tuesdayHours: loc[11],
    wednesdayHours: loc[12],
    thursdayHours: loc[13],
    fridayHours: loc[14],
    saturdayHours: loc[15],
    sundayHours: loc[16],
    distance: loc[17]
  }));
}

function handleError(error) {
  console.error('Error:', error);
}
// Populate provider list dom element with provider locations data
function populateProviderList() {
  providerListElement.innerHTML = '<h2 style="font-family: Roboto;">Nearby Provider Locations</h2>';
  console.log(providerLocationArr.length)
  providers.innerHTML = '';
  if (providerLocationArr.length === 0) {
    providerListElement.innerHTML = '<li class="list-group-item">No nearby locations found.🧐</li>';
  } else {
    providerLocationArr.forEach(providerLocation => {
      const a = document.createElement('a');
      a.href = '#';
      a.classList.add('list-group-item', 'list-group-item-action', 'flex-column', 'align-items-start');
      a.style = 'border: 5px solid #ccc; border-radius: 5px; padding: 10px; margin-bottom: 10px; font-family: Roboto;';
      a.innerHTML = providerLocation.displayInfo(); 
      providers.appendChild(a);
    });
    providerListElement.appendChild(providers);
  }
  providerListElement.classList.remove('hidden'); 
}


// Validate location is within US territory
function validateRange(lat, long) {
  const MAX_LAT = 64.856438;
  const MIN_LAT = 17.964888;
  const MAX_LNG = -64.888926;
  const MIN_LNG = -159.585452;
  if (lat > MAX_LAT || lat < MIN_LAT || long > MAX_LNG || long < MIN_LNG) {
    providerListElement.innerHTML = '<li class="list-group-item"><strong>The location is out of range:</strong> Please enter an address within US territory</li>';
    providerListElement.classList.remove('hidden');
    throw new Error('Location out of bounds');
  }
}

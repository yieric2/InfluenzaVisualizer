import ProviderLocationModel from './ProviderLocationModel.js';
const APIKEY = 'YOUR_API_KEY';


document.addEventListener('DOMContentLoaded', function() {
  const form = document.querySelector('form');
  form.addEventListener('submit', function(event) {
    event.preventDefault(); 
    const addressInput = document.getElementById('location');
    const address = addressInput.value.trim(); 

    
    if (address) { 
      console.log('Entered Address:', address);
      fetch(`https://maps.googleapis.com/maps/api/geocode/json?address=${encodeURIComponent(address)}&key=${APIKEY}`)
        .then(response => {
          if (!response.ok) {
            throw new Error('Geocoding request failed');
          }
          return response.text(); 
        })
        .then(text => {
          try {
            return JSON.parse(text); 
          } catch (error) {
            console.error("Error parsing geocoding JSON:", error);
            throw error; 
          }
        })
        .then(data => {
          const location = data.results[0].geometry.location;
          const { lat, lng } = location;
          const nearbyLocationsUrl = `/Application/api/nearByLocations.cfm?lat=${encodeURIComponent(lat)}&lng=${encodeURIComponent(lng)}`;
          return fetch(nearbyLocationsUrl);
        })
        .then(response => {
          if (!response.ok) {
            throw new Error('Network response was not ok');
          }
          return response.text(); 
        })
        .then(text => {
          try {
            return JSON.parse(text); 
          } catch (error) {
            console.error("Error parsing nearby locations JSON:", error);
            throw error; 
          }
        })
        .then(data => {
          console.log('Nearby Locations:', data);
          // Look at map.js for reference on parsing
          const locations = data.DATA.map(locationArray => {
            const [ longitude, latitude, walkinsAccepted,insuranceAccepted, zip, city, state, streetAddr, phoneNumber, webAddr, MonHrs, TueHrs, WedHrs, thurHrs, friHrs, satHrs, sunHrs, distance ] = locationArray;
            return new ProviderLocationModel({
                longitude, 
                latitude, 
                walkinsAccepted,
                insuranceAccepted,
                zip, 
                city, 
                state,
                streetAddr,
                phoneNumber,
                webAddr,
                MonHrs,
                TueHrs,
                WedHrs,
                thurHrs,
                friHrs,
                satHrs,
                sunHrs,
                distance
            });
        });
          console.log('Provider Locations:', locations[0].WeekHours());
        })
        .catch(error => {
          console.error('Error:', error);
        });
    } else {
      console.error('Invalid Address');
    }
    addressInput.value = '';
  }
  
  );
});


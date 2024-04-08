import ProviderLocationModel from './ProviderLocationModel.js';
const APIKEY = 'AIzaSyBv9HLYP-CUVWfHm8ttGYubsZ3gpWLQp-A';
let locations;
let providerLocationArr = [];
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
          data.DATA.forEach((loc) =>{
            const latitude = loc[0];
            const longitude = loc[1];
            const walkinsAccepted = loc[2];
            const insuranceAccepted = loc[3];
            const zip = loc[4];
            const city = loc[5];
            const state = loc[6];
            const streetAddr = loc[7];
            const phoneNumber = loc[8];
            const webAddr = loc[9];
            const MonHrs = loc[10];
            const TueHrs = loc[11];
            const WedHrs = loc[12];
            const ThurHrs = loc[13];
            const FriHrs = loc[14];
            const SatHrs = loc[15];
            const SunHrs = loc[16];
            const distance = loc[17];
            console.log('Location:', loc);
            providerLocationArr.push(new ProviderLocationModel({
              longitude : longitude,
              longitude : latitude,
              walkinsAccepted : walkinsAccepted,
              insuranceAccepted : insuranceAccepted,
              locAdminZip : zip,
              locAdminCity : city,
              locAdminState : state,
              locAdminStreet1 : streetAddr,
              locPhone : phoneNumber,
              webAddress : webAddr,
              mondayHours : MonHrs,
              tuesdayHours : TueHrs,
              wednesdayHours : WedHrs,
              thursdayHours : ThurHrs,
              fridayHours : FriHrs,
              saturdayHours : SatHrs,
              sundayHours : SunHrs,
              distance : distance
            }));
          })
          console.log('Provider Locations:', providerLocationArr[0].WeekHours());
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


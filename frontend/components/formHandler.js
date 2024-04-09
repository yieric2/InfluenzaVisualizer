import ProviderLocationModel from './ProviderLocationModel.js';
const APIKEY = '{YOUR_API_KEY}';
let providerLocationArr = [];
document.addEventListener('DOMContentLoaded', function() {
  const form = document.querySelector('form');
  form.addEventListener('submit', function(event) {
    event.preventDefault(); 
    const addressInput = document.getElementById('location');
    const providerListElement = document.getElementById('providers'); 
    providerListElement.innerHTML = ''; 
    const address = addressInput.value.trim(); 
    addressInput.value = '';
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
            providerLocationArr.push(new ProviderLocationModel({
              longitude : longitude,
              latitude : latitude,
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
          populateProviderList();
        })
        .catch(error => {
          console.error('Error:', error);
        });
    } else {
      console.error('Invalid Address');
    }

    function populateProviderList() {
      console.log("Content",providerListElement.innerHTML)
      console.log("Content: a",a.innerHTML)
      providerLocationArr.forEach(providerLocation => {
        const a = document.createElement('a');
        a.href = '#';
        a.classList.add('list-group-item', 'list-group-item-action', 'flex-column', 'align-items-start');
        a.innerHTML = `
          <div class="d-flex w-100 justify-content-between">
            <h5 class="mb-1">${providerLocation.getFullAddress()}</h5>
            <small>${providerLocation.distance} km</small>
          </div>
          <p class="mb-1">Phone: ${providerLocation.locPhone}</p>
          <p class="mb-1">Web: ${providerLocation.webAddress}</p>
          <p class="mb-1">Hours: ${providerLocation.WeekHours()}</p>
          <small>Walk-ins: ${providerLocation.acceptsWalkIns()} Insurance: ${providerLocation.acceptsInsurance()}</small>
        `;
        providerListElement.appendChild(a); 
      });
    }    
  }
  
  );
});


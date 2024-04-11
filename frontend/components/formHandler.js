import ProviderLocationModel from './ProviderLocationModel.js';
const APIKEY = 'YOUR_API_KEY';
document.addEventListener('DOMContentLoaded', function() {
  const form = document.querySelector('form');
  const providerListElement = document.getElementById('provider-list');
  const addressInput = document.getElementById('location');
  const providers = document.getElementById('providers');
  form.addEventListener('submit', function(event) {
    event.preventDefault(); 
    const address = addressInput.value.trim();
    let providerLocationArr = [];
    providerListElement.classList.add('hidden');
    addressInput.value = '';
    if (address) { 
      console.log('Entered Address:', address);
      fetch(`https://maps.googleapis.com/maps/api/geocode/json?address=${encodeURIComponent(address)}&key=${APIKEY}`)
        .then(response => {
          if (!response.ok) {
            providerListElement.innerHTML = '<li class="list-group-item">Geocoding request failed.<br>Try Providing a more precise location.</li>';
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
            providerLocationArr.push(new ProviderLocationModel({
              longitude : loc[0],
              latitude : loc[1],
              walkinsAccepted : loc[2],
              insuranceAccepted : loc[3],
              locAdminZip : loc[4],
              locAdminCity : loc[5],
              locAdminState : loc[6],
              locAdminStreet1 : loc[7],
              locPhone :  loc[8],
              webAddress : loc[9],
              mondayHours : loc[10],
              tuesdayHours : loc[11],
              wednesdayHours : loc[12],
              thursdayHours : loc[13],
              fridayHours :  loc[14],
              saturdayHours : loc[15],
              sundayHours : loc[16],
              distance : loc[17]
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
      providers.innerHTML = '';
      if (providerLocationArr.length === 0) {
        providers.innerHTML = '<li class="list-group-item">No nearby locations found. 🥲</li>';
      } else {
        providerLocationArr.forEach(providerLocation => {
          const a = document.createElement('a');
          a.href = '#';
          a.classList.add('list-group-item', 'list-group-item-action', 'flex-column', 'align-items-start');
          a.innerHTML = providerLocation.displayInfo(); 
          providers.appendChild(a);
        });
      }
    
      providerListElement.classList.remove('hidden'); 
    }
        
  }
  
  );
});


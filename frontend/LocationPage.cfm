<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Locations</title>
    <script src="https://unpkg.com/@googlemaps/markerclusterer/dist/index.min.js"></script>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    <style>
        #map-container {
          display: flex;
          justify-content: center;
          align-items: center;
          height: 75vh;
          width: 100vw;
        }
  
        #map {
          height: 100%;
          width: 70%;
        }
      </style>
</head>

<body>
    <header id="navbar"></header>
    <p style="font-weight: bold; font-size: 20px; margin-left: 400px; margin-top: 50px;">Flu Vaccination Provider Locations</p>
    <div id="map-container">
        <div id="map"></div>
      </div>

    <script>
        fetch('navbar.html')
            .then(response => response.text())
            .then(data => {
                document.getElementById('navbar').innerHTML = data;
                const currentPage = window.location.pathname;
                let activeLink = null;
                if (currentPage.includes('LocationPage.html')) {
                    activeLink = document.getElementById('page1-link');
                } else if (currentPage.includes('page2.html')) {
                    activeLink = document.getElementById('page2-link');
                } else if (currentPage.includes('page3.html')) {
                    activeLink = document.getElementById('page3-link');
                } else if (currentPage.includes('page4.html')) {
                    activeLink = document.getElementById('page4-link');
                }

                if (activeLink) {
                    activeLink.classList.add('active');
                }
            })
            .catch(error => {
                console.error('Error loading navigation bar:', error);
            });
    </script>
        <script async defer src="https://maps.googleapis.com/maps/api/js?key={YOUR_GMAP_KEY}&callback=initMap"></script>
    <script src="./components/map.js"></script>
</body>
</html>
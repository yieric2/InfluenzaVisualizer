<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Locations</title>
    <script src="https://unpkg.com/@googlemaps/markerclusterer/dist/index.min.js"></script>
    <link 
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
        crossorigin="anonymous">
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
            height: 70%;
            width: 95%;
            border-radius: 20px;
        }
        

        #TitlePage {
            font-family: Roboto;
            font-size: 20px;
            margin-top: 50px;
        }


        .container-lg {
            text-align: center;
            font-family: Roboto;
            height: 100vh;
            width: 100vw;
        }
        


        .search-container button {
            background-color: black;
            border-radius: 20px;
            color: white;
            padding: 10px 80px;
            font-size: 16px;
            border: none;
            cursor: pointer;
            margin-top: 10px;
            margin-bottom: 50px;
            font-family: Roboto;

        }

        .search-container button:hover {
            background-color: #0d6efd;
        }

        .hidden {
            display: none;
        }

        .dropdown-center {
            display: flex;
            justify-content: center;
            margin-bottom: 0px;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            margin: 5px 0 22px 0;
            display: inline-block;
            border: none;
            background: #f1f1f1;
            width: 50%; 
        }

        #provider-list {
        max-height: 300px; 
        overflow-y: auto; 
        }
        #dropdownCustom {
            margin-bottom: 20px;
        }

        
        .dropdown-item {
            text-align: center;
            width: 100%;
            padding: 10px 80px;
            background-color: #f1f1f1
        }

        
        .dropdown-item:hover, .dropdown-item:focus {
            color: #ffffff; 
            background-color: #007bff; 
            text-decoration: none; 
        }
        
        .dropdown-item.active, .dropdown-item:active {
            color: #fff;
            background-color: #0056b3; 
            outline: none;
        }

        
        .dropdown-item.disabled, .dropdown-item:disabled {
            color: #6c757d; 
            background-color: transparent;
            pointer-events: none; 
        }

        #queryResult {
            margin-bottom: 50px;
        }

    </style>
</head>
<body>
<header id="navbar"></header>
<div id="top-half-page" style="text-align:center;">
<p id="TitlePage">Flu Vaccination Provider Locations</p>
<div id="map-container">
    <div id="map"></div>
</div>
</div>
<div id="bottom-half-page">
<div class="container-lg border">
    <div class="row">
        <div class="search-container">
            <h2>Search for Nearest Providers (US Only)</h2>
            <form>
                <div class="form-group">
                    <input type="text" class="form-control" id="location" placeholder="Enter your city, address, and/or zipcode">
                </div>
                <div class="dropdown-center">
                <button id="dropdownCustom" class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                    Desired radius (miles)
                </button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="#">5</a></li>
                        <li><a class="dropdown-item" href="#">10</a></li>
                        <li><a class="dropdown-item" href="#">15</a></li>
                        <li><a class="dropdown-item" href="#">20</a></li>
                    </ul>
                </div>
                <button type="submit" id="search-btn"class="btn btn-primary hidden">Search</button>
            </form>
        </div>
        <div id="queryResult"></div>
    </div>
    <div class="row">
        <div class="hidden" id="provider-list">
            <h2>Nearby Provider Locations</h2>
            <ul class="list-group" id="providers"></ul>
        </div>
    </div>
</div>
</div>
<script type="module" src="./components/formHandler.js"></script>
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
<script 
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
    crossorigin="anonymous">
</script>
<script>
  (g=>{var h,a,k,p="The Google Maps JavaScript API",c="google",l="importLibrary",q="__ib__",m=document,b=window;b=b[c]||(b[c]={});var d=b.maps||(b.maps={}),r=new Set,e=new URLSearchParams,u=()=>h||(h=new Promise(async(f,n)=>{await (a=m.createElement("script"));e.set("libraries",[...r]+"");for(k in g)e.set(k.replace(/[A-Z]/g,t=>"_"+t[0].toLowerCase()),g[k]);e.set("callback",c+".maps."+q);a.src=`https://maps.${c}apis.com/maps/api/js?`+e;d[q]=f;a.onerror=()=>h=n(Error(p+" could not load."));a.nonce=m.querySelector("script[nonce]")?.nonce||"";m.head.append(a)}));d[l]?console.warn(p+" only loads once. Ignoring:",g):d[l]=(f,...n)=>r.add(f)&&u().then(()=>d[l](f,...n))})({
    key: "{API_KEY}",
    v: "weekly",
  });
</script>

<script src="./components/map.js"></script>
</body>
</html>

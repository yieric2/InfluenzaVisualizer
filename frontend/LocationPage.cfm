<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Locations</title>
    <script src="https://unpkg.com/@googlemaps/markerclusterer/dist/index.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
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
            font-weight: bold;
            font-size: 20px;
            margin-left: 400px;
            margin-top: 50px;
        }

        .container-fluid {
            text-align: center;
            max-width: 100%;
            margin: 0 auto;
        }

        #provider-list {
            display: none;
            margin-top: 50px;
        }

        .col-sm-6 button {
            background-color: black;
            border-radius: 20px;
            color: white;
            padding: 10px 80px;
            font-size: 16px;
            border: none;
            cursor: pointer;
            margin-top: 10px;
        }

        .col-sm-6 button:hover {
            background-color: gray;
        }
    </style>
</head>
<body>
<header id="navbar"></header>
<p id="TitlePage">Flu Vaccination Provider Locations</p>
<div id="map-container">
    <div id="map"></div>
</div>
<div class="container-fluid border">
    <div class="row">
        <div class="col-sm-6">
            <h2>Search for Providers</h2>
            <form>
                <div class="form-group">
                    <label for="name">Location</label>
                    <input type="text" class="form-control" id="location" placeholder="Enter your Zipcode">
                </div>
                <button type="submit" class="btn btn-primary">Submit</button>
            </form>
        </div>
        <div class="col-sm-6" id="provider-list">
            <h2>Provider List</h2>
            <ul class="list-group">
                <li class="list-group-item">Provider 1</li>
            </ul>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
<script>
  (g=>{var h,a,k,p="The Google Maps JavaScript API",c="google",l="importLibrary",q="__ib__",m=document,b=window;b=b[c]||(b[c]={});var d=b.maps||(b.maps={}),r=new Set,e=new URLSearchParams,u=()=>h||(h=new Promise(async(f,n)=>{await (a=m.createElement("script"));e.set("libraries",[...r]+"");for(k in g)e.set(k.replace(/[A-Z]/g,t=>"_"+t[0].toLowerCase()),g[k]);e.set("callback",c+".maps."+q);a.src=`https://maps.${c}apis.com/maps/api/js?`+e;d[q]=f;a.onerror=()=>h=n(Error(p+" could not load."));a.nonce=m.querySelector("script[nonce]")?.nonce||"";m.head.append(a)}));d[l]?console.warn(p+" only loads once. Ignoring:",g):d[l]=(f,...n)=>r.add(f)&&u().then(()=>d[l](f,...n))})({
    key: "{YOUR_API_KEY}",
    v: "weekly",
  });
</script>

<script src="./components/map.js"></script>
</body>
</html>

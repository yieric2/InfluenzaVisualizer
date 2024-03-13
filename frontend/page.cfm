<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <cfset Env =createObject("java","java.lang.System")>
    <cfset GMapToken = Env.getProperty("APP_TOKEN")>
    <title>Document</title>
</head>
<body>
    <h1>My Google Map</h1>
    <div id="map"></div>
    <link rel="stylesheet" type="text/css" href="./style.css" />
    <script src="./map/map.js"></script>
    <script async defer src="https://maps.googleapis.com/maps/api/js?key={YOU_GOOGLE_MA}&callback=initMap"></script>
</body>
</html>
```
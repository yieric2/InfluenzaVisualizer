<html>
<head>
<link rel = "stylesheet" href = "doses.css">

<title>
Influenza's vaccine doses in millions
</title>
</head>
<body>
<div class = "navbar">
Nav Bar ( to be implemented)
</div>

<h1 class = "graph-title">
This is my graph 
</h1>

<div class = "graph">
Graph Div 
</div>

<div class = "graph-bottom">
<div class = "graph-stats">
Some stats here and there
</div>

<div class = "graph-description">
Lorem ipsum dolor sit amet, consectetur adipiscing elit,
    sed do eiusmod tempor incididunt ut labore et dolore magna
    aliqua. Ut enim ad minim veniam, quis nostrud exercitation
    ullamco laboris nisi ut aliquip ex ea commodo consequat.
    Duis aute irure dolor in reprehenderit in voluptate velit
    esse cillum dolore eu fugiat nulla pariatur. Excepteur sint
    occaecat cupidatat non proident, sunt in culpa qui officia
    deserunt mollit anim id est laborum.
</div>
</div>
<div id = "dataContainer">
</div>
<script>
// JavaScript code to retrieve data from ColdFusion REST API
    const endpointUrl = "../back-end/api.cfm/doses";
    function fetchData() {
    fetch(endpointUrl)
    .then(response => {
    if (!response.ok) {
    throw new Error(`HTTP error! status: ${response.status}`);
    }
    return response.json();
    })
    .then(data => {
    // Output data to console
    console.log(data);
    data.forEach(item => {
    // Assuming you have some DOM element to append data to
    const container = document.getElementById("dataContainer");
    // Create a new paragraph element
    const paragraph = document.createElement("p");
    // Set the text content of the paragraph to display the data
    paragraph.textContent = `WEEK START DATE: ${item['WeekStartDate'.toUpperCase()]}, WEEK END DATE:
    ${item['WeekEndDate'.toUpperCase()]}, SEASON: ${item['Season'.toUpperCase()]}, CUMULATIVE DOSES:
    ${item['CumulativeDoses'.toUpperCase()]}, WEEK SEASON ORDER:
    ${item['WeekSeasonOrder'.toUpperCase()]}`;
    //structure
    // Append the paragraph to the container
    container.appendChild(paragraph);
    
    });
    })
    .catch(error => {
    console.error("Fetch error:", error);
    });
    }
    // Call fetchData function
    fetchData();
</script>
</body>
</html>
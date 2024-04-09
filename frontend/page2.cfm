<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Influenza Demographics</title>
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <meta name="description" content="" />
  <script src="
  https://cdn.jsdelivr.net/npm/chart.js@4.4.2/dist/chart.umd.min.js
  "></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
    <cfquery datasource="MySQL_test" name="getAllGeography">
        use influenza_database
    </cfquery>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

    <header id="navbar"></header>
    <script>
        fetch('navbar.html')
            .then(response => response.text())
            .then(data => {
                document.getElementById('navbar').innerHTML = data;
            })
            .catch(error => {
                console.error('Error loading navigation bar:', error);
            });
    </script>
    <div class="container mt-3">
        <h1>Demographics for Influenza Vaccination Coverage</h1>
        <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>
        <!-- Button trigger modal -->
        <cfoutput >
                <button type="button" class="btn btn-primary d-block my-3" data-bs-toggle="modal" data-bs-target="##coverageModal">
                    Graph Setting
                </button>    
        </cfoutput>
        <canvas id="myChart"></canvas>
    </div>
    <!-- Modal -->
    <div class="modal fade" id="coverageModal" tabindex="-1" aria-labelledby="coverageModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
        <div class="modal-header">
            <h1 class="modal-title fs-5" id="coverageModalLabel">Graph Setting</h1>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body bg-light">
            <div class="coverage_form_container">
            <div id="liveAlertPlaceholder"></div>
            <form id="coverage_form">
                <label class="text-uppercase my-2">Vaccine Type</label>
                <cfquery datasource="MySQL_test" name="getAllVaccineType">
                    SELECT * 
                    FROM VaccineType
                </cfquery>
                <select class="form-select" name="influenza_type" id="influenza_type">
                    <cfoutput query="getAllVaccineType">
                        <option value="#getAllVaccineType.ID#">#getAllVaccineType.CATEGORY#</option>
                    </cfoutput>
                </select>
                <label class="text-uppercase my-2">Season</label>
                <cfquery datasource="MySQL_test" name="getAllSeasons">
                    SELECT distinct startyear, endyear
                    FROM Season
                    ORDER BY startyear
                </cfquery>
                <select class="form-select" name="season" id="season">
                    <cfoutput query="getAllSeasons">
                        <cfif year(getAllSeasons.STARTYEAR) EQ 2022>
                            <option value="#year(getAllSeasons.STARTYEAR)#" selected>#year(getAllSeasons.STARTYEAR)# - #year(getAllSeasons.ENDYEAR)#</option>
                        <cfelse>
                            <option value="#year(getAllSeasons.STARTYEAR)#" >#year(getAllSeasons.STARTYEAR)# - #year(getAllSeasons.ENDYEAR)#</option>
                        </cfif>
                    </cfoutput>
                </select>
                <label class="text-uppercase my-2">Geography</label>
                <select class="form-select" name="geography_type" id="geography_type" onchange="updateGeography()">
                    <option selected value="1">States/Local Areas</option>
                    <option value="2">HHS Regions/National</option>
                </select>
                <cfquery datasource="MySQL_test" name="getAllGeography">
                    SELECT * 
                    FROM Geography
                    WHERE geographyTypeID = 1
                    ORDER BY Name
                </cfquery>
                <select class="form-select my-2" name="geography" id="geography">
                    <cfoutput query="getAllGeography">
                        <cfif getAllGeography.ID EQ 4>
                            <option value="#getAllGeography.ID#" selected>#getAllGeography.NAME#</option>
                        <cfelse>
                            <option value="#getAllGeography.ID#">#getAllGeography.NAME#</option>
                        </cfif>
                    </cfoutput>
                </select>
                <cfquery datasource="MySQL_test" name="getAllAgeGroup">
                    SELECT * 
                    FROM Dimension
                    WHERE DimensionTypeID = 1
                    ORDER BY Name    
                </cfquery>
                <div>
                    <label class="d-block text-uppercase my-3">Age Group</label>
                    <div class="mb-1" style="border: rgba(0,0,0,0.1) solid 1px;"></div>
                    <div class="row">
                        <cfoutput query="getAllAgeGroup">
                            <cfif getAllAgeGroup.ID EQ 1>
                                <div class="d-flex flex-column justify-content-center align-items-center col-6 col-lg-3 py-2">
                                    <label class="form-check-label mb-1" for="age_group#getAllAgeGroup.ID#">#getAllAgeGroup.NAME#</label>
                                    <input class="form-check-input" type="checkbox" id="age_group#getAllAgeGroup.ID#" name="age_group" value="#getAllAgeGroup.ID#" checked style="width:1rem; height: 1rem; outline: 1px solid ##696969 !important;">
                                </div>
                            <cfelse>
                                <div class="d-flex flex-column justify-content-center align-items-center col-6 col-lg-3 py-2">
                                    <label class="form-check-label mb-1" for="age_group#getAllAgeGroup.ID#">#getAllAgeGroup.NAME#</label>
                                    <input class="form-check-input" type="checkbox" id="age_group#getAllAgeGroup.ID#" name="age_group" value="#getAllAgeGroup.ID#" style="width:1rem; height: 1rem; outline: 1px solid black !important;">
                                </div>
                            </cfif>
                        </cfoutput>
                    </div>
                </div>
                <cfquery datasource="MySQL_test" name="getAllRace_ethn">
                    SELECT * 
                    FROM Dimension
                    WHERE DimensionTypeID = 2  
                    ORDER BY Name  
                </cfquery>
                <div>
                    <label class="d-block text-uppercase my-3">Race/Ethnicity</label>
                    <div class="mb-1" style="border: rgba(0,0,0,0.1) solid 1px;"></div>
                    <div class="row">
                        <cfoutput query="getAllRace_ethn">
                            <cfif getAllRace_ethn.ID EQ 4 || getAllRace_ethn.ID EQ 11>
                                <div class="d-flex flex-column justify-content-center align-items-center col-6 col-lg-3 py-2">
                                    <label class="form-check-label mb-1" for="race_ethn#getAllRace_ethn.ID#">#getAllRace_ethn.NAME#</label>
                                    <input class="form-check-input" type="checkbox" id="race_ethn#getAllRace_ethn.ID#" name="race_ethn" value="#getAllRace_ethn.ID#" checked style="width:1rem; height: 1rem; outline: 1px solid ##696969 !important;">
                                </div>
                            <cfelse>
                                <div class="d-flex flex-column justify-content-center align-items-center col-6 col-lg-3 py-2">
                                    <label class="form-check-label mb-1" for="race_ethn#getAllRace_ethn.ID#">#getAllRace_ethn.NAME#</label>
                                    <input class="form-check-input" type="checkbox" id="race_ethn#getAllRace_ethn.ID#" name="race_ethn" value="#getAllRace_ethn.ID#" style="width:1rem; height: 1rem; outline: 1px solid ##696969 !important;">
                                </div>
                            </cfif>
                        </cfoutput>
                    </div>
                    
                </div>
            </form>
        </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            <input type="button" class="btn btn-primary" onclick="getCoverage()" value="Apply"/>
        </div>
        </div>
    </div>
    </div>
</body>
<script>
    const coverage_form = document.getElementById("coverage_form");
    // const formData = new FormData(coverage_form);
    // const LIMIT = 5;
    
    // Initial dataset
    const initialData = {
      labels: ['January', 'February', 'March', 'April', 'May', "June", 'July', 'August', 'September', 'October', 'November', 'December'],
      datasets: [{
            label: 'White',
            data: [39.6, 41.4, 42.2, 42.3, 43.4, 0, 0, 1.4, 8.8, 28, 34.7, 37],
            borderWidth: 1,
            borderRadius : 5
            },{
            label: 'Hispanic',
            data: [39.6, 42.6, 42.6, 44, 44, 0, 0, 0, 13, 30.4, 35.9, 39.4],
            borderWidth: 1,
            borderRadius : 5
            },
            {
            label: '18-49 Years at High Risk',
            data: [24.8, 28.4, 28.4, 28.4, 28.4, 0, 0, 0, 0, 12.9, 17.1, 21.],
            borderWidth: 1,
            borderRadius : 5
            }]
    };
    
    const plugin = {
    id: 'customCanvasBackgroundColor',
    beforeDraw: (chart, args, options) => {
        const {ctx} = chart;
        ctx.save();
        ctx.globalCompositeOperation = 'destination-over';
        ctx.fillStyle = options.color || '#99ffff';
        ctx.fillRect(0, 0, chart.width, chart.height);
        ctx.restore();
    }
    };

    // Create chart
    var ctx = document.getElementById('myChart').getContext('2d');
    var myChart = new Chart(ctx, {
      type: 'bar',
      data: initialData,
      options: {
            responseive: true,
            // maintainAspectRatio : false,
            plugins: {
                customCanvasBackgroundColor: {
                    color: '#FCFCFC',
                },
                title: {
                    display: true,
                    text: 'Seasonal Influenza Coverage For Alabama : 2022 - 2023',
                    font : {
                        size : 18
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: true
                },
                x: {
                    ticks : {
                        maxRotation : 45,
                        minRotation : 45
                    }
                },
            },
        },
        plugins: [plugin]
    });

    const updateGeography = async () => {
        try {
            
            // Get the geography type element
            const geographyTypeDropdown = document.getElementById("geography_type");

            // Get the selected option
            const selectedOption = geographyTypeDropdown.options[geographyTypeDropdown.selectedIndex];

            // Get the value of the selected option
            const selectedValue = selectedOption.value;

            const response = await fetch(`/Projects/api/getAllGeography.cfm?id=${selectedValue}`);
            if (!response.ok) {
                throw new Error('Bad status code from server');
            }
            const data = await response.json();

            // Get the geography element
            var geographyDropdown = document.getElementById("geography");

            // Clear the Options
            geographyDropdown.innerHTML = '';

            // Insert new options
            data.forEach(function(newOption) {
                var optionElement = document.createElement("option");
                optionElement.value = newOption.ID;
                optionElement.text = newOption.NAME;
                geographyDropdown.appendChild(optionElement);
            })

        } catch (error) {
            console.error('Error fetching data:', error);
        }
    }

    const alertTrigger = (message, type) => {
        const alertPlaceholder = document.getElementById('liveAlertPlaceholder')
        const wrapper = document.createElement('div')
        wrapper.innerHTML = [
            `<div class="alert alert-${type} alert-dismissible" role="alert">`,
            `   <div>${message}</div>`,
            '   <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>',
            '</div>'
        ].join('')

        alertPlaceholder.append(wrapper);
    }

    const getCoverage = async() => {
        try{
            // Build body for coldfusion call
            const body = {
                influenza_type : null,
                season : null,
                geography_type : null,
                geography : null,
                age_group : [],
                race_ethn : []
            }
            let checkboxCount = 0;

            const coverage_form = document.getElementById("coverage_form");
            const newFormData = new FormData(coverage_form);
            // Extract the correct values and append to body
            for(var pair of newFormData.entries()) 
            {
                let k = pair[0];
                let v = pair[1];
                if(k === 'age_group' || k === 'race_ethn'){
                    body[`${k}`].push(v);
                    checkboxCount += 1;
                }
                else{
                    body[`${k}`] = v;
                }
            }

            if(checkboxCount < 1){
                alertTrigger("Must Have At Least One Age Group or Race/Ethnicity Marked", "danger");
                throw new Error("Sorry, Must Have At Least One Age Group or Race/Ethnicity Marked");
            }

            // Get data
            const response = await fetch("/ProjectS/api/getAllCoverage.cfm", {
                method : "POST",
                headers : {
                    'Content-Type' : 'application/json'
                },
                body : JSON.stringify(body)
            });

            if (!response.ok) {
                throw new Error('Bad status code from server');
            }

            const data = await response.json();
            // Update graph 
            const monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
            var columns = data.COLUMNS;
            var rowData = data.DATA;

            // If no data then do not update
            if(rowData.length === 0){
                alertTrigger("Sorry No Data Available", "danger");
                throw new Error("Sorry No Data");
            }

            var months = rowData.map(row => row[8]);
            var rates = rowData.map(row => row[1]);
            var dimensions = rowData.map(row => row[4]);

            const labels = [1,2,3,4,5,6,7,8,9,10,11,12]
            const datasets = [];

            const uniqueDimensions = Array.from(new Set(dimensions));

            uniqueDimensions.forEach(dimension => {
            const dataset = {
                label: dimension,
                data: [],
                borderWidth: 1,
                borderRadius : 5
            };

            labels.forEach(month => {
                const index = dimensions.findIndex((dim, i) => dim === dimension && months[i] === month);
                if (index !== -1) {
                    dataset.data.push(rates[index]);
                } else {
                    dataset.data.push(0);
                }
                });

                datasets.push(dataset);
            });
            const formattedLabels = labels.map(label => monthNames[label - 1]); // Adjust month index
            const ctx = document.getElementById('myChart').getContext('2d');
            myChart.data.datasets = datasets;

            // Update Title
            // Get the geography element
            const geographyDropdown = document.getElementById("geography");

            // Get the selected option
            const selectedGeographyOption = geographyDropdown.options[geographyDropdown.selectedIndex];

            // Get the value of the selected option
            const geographyName = selectedGeographyOption.text;

            // Get the influenza type type element
            const influenzaTypeDropdown = document.getElementById("influenza_type");

            // Get the selected option
            const selectedInfluenzaTypeOption = influenzaTypeDropdown.options[influenzaTypeDropdown.selectedIndex];

            // Get the value of the selected option
            const influenzaType = selectedInfluenzaTypeOption.text;

            // Get the season element
            const seasonDropdown = document.getElementById("season");

            // Get the selected option
            const selectedSeasonOption = seasonDropdown.options[seasonDropdown.selectedIndex];

            // Get the value of the selected option
            const season = selectedSeasonOption.text;

            myChart.options.plugins.title.text = `${influenzaType} Coverage For ${geographyName} : ${season}`
            myChart.update();

            //Finally hide modal if everything is successful
            var myModalEl = document.getElementById('coverageModal');
            var modal = bootstrap.Modal.getInstance(myModalEl)
            modal.hide();
            
        }
        catch(error){
            console.error("Error fetching data", error)
        }
    }
</script>
</html>
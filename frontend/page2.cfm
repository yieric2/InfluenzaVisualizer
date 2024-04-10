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
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">
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
    <div class="container mt-3 d-flex flex-column" style='height: calc(100% - 150px); font-family: "Roboto", sans-serif;'>
        <h2>Demographics for Influenza Vaccination Coverage</h2>
        <p>On this webpage, we present CDC-sourced data illustrating Influenza vaccination coverage across various demographics, visualized through a multiple bar graph. You can customize the display by clicking on the graph settings button. <strong>Note</strong>, options like <strong>"Any influenza vaccination Seasonal or H1N1"</strong> and <strong>"Influenza A (H1N1) 2009 Monovalent"</strong> apply solely to the <strong>2009 - 2010 season</strong>. Also, there's a limit of <strong>five selections</strong> for age groups and race/ethnicity. This data offers insights into vaccination trends, aiding efforts to improve strategies, promote equity, and lessen influenza's public health impact.</p>
        <!-- Button trigger modal -->
        <cfoutput >
                <button type="button" class="btn btn-primary d-block my-1 w-25" data-bs-toggle="modal" data-bs-target="##coverageModal">
                    Graph Setting
                </button>    
        </cfoutput>
        <div class="flex-grow-1">
            <canvas id="myChart"></canvas>
        </div>
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
                                    <input class="form-check-input" type="checkbox" id="age_group#getAllAgeGroup.ID#" name="age_group" value="#getAllAgeGroup.ID#" checked onchange="checkLimit()" style="width:1rem; height: 1rem; outline: 1px solid ##696969 !important;">
                                </div>
                            <cfelse>
                                <div class="d-flex flex-column justify-content-center align-items-center col-6 col-lg-3 py-2">
                                    <label class="form-check-label mb-1" for="age_group#getAllAgeGroup.ID#">#getAllAgeGroup.NAME#</label>
                                    <input class="form-check-input" type="checkbox" id="age_group#getAllAgeGroup.ID#" name="age_group" value="#getAllAgeGroup.ID#" onchange="checkLimit()" style="width:1rem; height: 1rem; outline: 1px solid black !important;">
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
                                    <input class="form-check-input" type="checkbox" id="race_ethn#getAllRace_ethn.ID#" name="race_ethn" value="#getAllRace_ethn.ID#" checked onchange="checkLimit()" style="width:1rem; height: 1rem; outline: 1px solid ##696969 !important;">
                                </div>
                            <cfelse>
                                <div class="d-flex flex-column justify-content-center align-items-center col-6 col-lg-3 py-2">
                                    <label class="form-check-label mb-1" for="race_ethn#getAllRace_ethn.ID#">#getAllRace_ethn.NAME#</label>
                                    <input class="form-check-input" type="checkbox" id="race_ethn#getAllRace_ethn.ID#" name="race_ethn" value="#getAllRace_ethn.ID#" onchange="checkLimit()" style="width:1rem; height: 1rem; outline: 1px solid ##696969 !important;">
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
<script src="page2.js"></script>
</html>
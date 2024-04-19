const coverage_form = document.getElementById("coverage_form");
// const formData = new FormData(coverage_form);
const LIMIT = 5;

// Initial dataset
const initialData = {
    labels: ['January', 'February', 'March', 'April', 'May', "June", 'July', 'August', 'September', 'October', 'November', 'December'],
    datasets: [{
        label: 'White',
        data: [39.6, 41.4, 42.2, 42.3, 43.4, 0, 0, 1.4, 8.8, 28, 34.7, 37],
        borderWidth: 2,
        borderRadius : 5
        },{
        label: 'Hispanic',
        data: [39.6, 42.6, 42.6, 44, 44, 0, 0, 0, 13, 30.4, 35.9, 39.4],
        borderWidth: 2,
        borderRadius : 5
        },
        {
        label: '18-49 Years at High Risk',
        data: [24.8, 28.4, 28.4, 28.4, 28.4, 0, 0, 0, 0, 12.9, 17.1, 21.],
        borderWidth: 2,
        borderRadius : 5,
        }]
};

let initialFontSize;

if (window.innerWidth >= 992){
    initialFontSize = 16;
}
else if (window.innerWidth < 992 && window.innerWidth >= 576){
    initialFontSize = 12;
}
else {
    initialFontSize = 9;
}

// Create chart
var ctx = document.getElementById('myChart').getContext('2d');
var myChart = new Chart(ctx, {
    type: 'bar',
    data: initialData,
    options: {
        responsiveness: true,
        maintainAspectRatio : false,
        plugins: {
            customCanvasBackgroundColor: {
                color: '#FCFCFC',
            },
            title: {
                display: true,
                text: 'Seasonal Influenza Coverage For Alabama : 2022 - 2023',
                font : {
                    size : initialFontSize + 2
                }
            },
            legend: {
                onHover : (event, chartElement) => {
                    event.native.target.style.cursor = 'pointer'
                },
                onLeave : (event, chartElement) => {
                    event.native.target.style.cursor = 'default'
                }
            }
        },
        scales: {
            y: {
                beginAtZero: true,
                ticks : {
                    font : {
                        size : initialFontSize
                    }
                }
            },
            x: {
                ticks : {
                    maxRotation : 45,
                    minRotation : 45,
                    font : {
                        size : initialFontSize
                    }
                }
            },
        },
    }
});

const updateGeography = async () => {
    try {
        
        // Get the geography type element
        const geographyTypeDropdown = document.getElementById("geography_type");

        // Get the selected option
        const selectedOption = geographyTypeDropdown.options[geographyTypeDropdown.selectedIndex];

        // Get the value of the selected option
        const selectedValue = selectedOption.value;

        const response = await fetch(`/Projects/backend/api/Page2Apis/getAllGeography.cfm?id=${selectedValue}`);
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

    alertPlaceholder.scrollIntoView({behavior : 'smooth'});
}

const getCoverage = async() => {
    try{
        //disable apply button
        applyButton = document.getElementById('applyBtn');

        applyButton.disabled = true;


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
        const response = await fetch("/Projects/backend/api/Page2Apis/getAllCoverage.cfm", {
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
            alertTrigger("Sorry, No Data Available For The Selected Demographic", "danger");
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
            borderWidth: 2,
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
    finally {
        //enable the apply button
        applyButton = document.getElementById('applyBtn');

        applyButton.disabled = false;
    }
}

const checkLimit = () => {
    const checkBoxes = document.querySelectorAll('input[type="checkbox"]');
    let limitCount = 0;

    // Get the count for all checkBoxes
    for(let i = 0; i < checkBoxes.length; i++){
        if(checkBoxes[i].checked){
            limitCount++;
        }
    }

    if(limitCount >= LIMIT){
        for(let i = 0; i < checkBoxes.length; i++){
            if(!checkBoxes[i].checked){
                checkBoxes[i].disabled = true;
            }
        }
    }
    else {
        for(let i = 0; i < checkBoxes.length; i++){
            if(!checkBoxes[i].checked){
                checkBoxes[i].disabled = false;
            }
        }
    }
}
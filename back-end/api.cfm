<cfscript>
// Include the CFC
include "dosesRetrieve.cfc";

// Create an instance of the CFC
dosesRetrieve = new dosesRetrieve();

// Check the request method
switch (cgi.request_method) {
    case "GET":
        // Handle GETequest
        if (cgi.path_info EQ "/doses") {
            // Retrieve all records from the table
            data = dosesRetrieve.getDosesTable();
            // Convert the data to JSON
            response = serializeJSON(data);
            // Set response content type
            cfcontent(type="application/json") {
                writeOutput(response);
            }
        } else {
            // Handle other GET requests
            // Return error or handle accordingly
        }
        break;
    default:
        // Handle other HTTP methods
        // Return error or handle accordingly
        break;
}
</cfscript>

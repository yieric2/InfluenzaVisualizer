<!DOCTYPE html>
<html>
<head>
    <title>Basic ColdFusion Page</title>
</head>
<body>
    <cfoutput>
    </cfoutput>
    <cfoutput>
        <cfset Env =createObject("java","java.lang.System")>
        <cfset db_name="CDC_DataSource">
        <cfset db_user= Env.getProperty("db_user")>
        <cfset db_table = Env.getProperty("table_name")>
        <cfset db_password = Env.getProperty("db_pass")>
        <cftry>
        <cfscript>
        csvFile = fileRead("C:\Users\AlexP\cfusion\wwwroot\App\CSVFile\Original_data.csv"); // might have to hide this data
        lines =  listToArray(csvFile, chr(10));
        myData = [];
        batchSize = 1065;
        currentBatch = []; 
        uniq_id = {};
        function csv_split(required string line ) {
            var columns = [];
            var currentColumn = "";
            var inQuote = false;
            var i = 1;
            for (i = 1; i <= len(line); i++) {
                var char = mid(line, i, 1);
                if (char == ",") {
                    if (inQuote) {
                        currentColumn &= char;
                    } else {
                        arrayAppend(columns, currentColumn);
                        currentColumn = "";
                    }
                } else if (char == '"') {
                    inQuote = !inQuote;
                } else {
                    currentColumn &= char;
                }
            }
            arrayAppend(columns, currentColumn);
            return columns;
        }
        function create_point(required float lat, required float log) {
            point = "POINT(" & log & ' ' & lat & ")";
            return 'ST_PointFromText("' & point & '")';
            }

        for(i = 2; i <= arrayLen(lines); i++) {
            row = csv_split(lines[i]);
            if( structKeyExists(uniq_id, row[1]) ) {
                continue;
            } else {
                uniq_id[row[1]] = true;
            }

            bool_indices = [19, 20, 23];

            for(index in bool_indices) {
                row[index] = (row[index] eq 'true') ? 'TRUE' : 'FALSE';
            }
            
            if(len(row[26]) eq 0){
                row[26] = 0;
                row[27] = 0;
            }

           arrayAppend(myData, '("' & row[1] & '","' & row[2] & '","' & row[3] & '","' & row[4] & '","' & row[5] & '","' & row[6] & '","' & row[7] & '","' & row[8] & '","' & row[9] & '","' & row[10] & '","' & row[11] & '","' & row[12] & '","' & row[13] & '","' & row[14] & '","' & row[15] & '","' & row[16] & '","' & row[17] & '","' & row[18] & '",' & row[19] & ',' & row[20] & ',"' & row[21] & '","' & row[22] & '",' & row[23] & ',' & row[24] & ',"' & row[25] & '",' & create_point(row[26],row[27]) & ',"' & row[28] & '")');

        }

        values = [];
        for(i = 1; i <= arrayLen(myData); i++){
                arrayAppend(currentBatch, myData[i]);
                if(arrayLen(currentBatch) eq batchSize){
                    arrayAppend(values,arrayToList(currentBatch, ","));
                    currentBatch = [];
                }
            }

        </cfscript>
            <cfcatch type="Any">
                <p>Error: #cfcatch.message#</p>
            </cfcatch>
        </cftry>
    </cfoutput>
    <cfoutput >
    <cftry>
    <cfquery datasource="#db_name#">
        TRUNCATE TABLE #db_table#
    </cfquery>
        <cfloop from="1" to="#arrayLen(values)#" index="i">
            <cfquery datasource="#db_name#">
                INSERT INTO #db_table# (
                    provider_location_guid, loc_store_no, loc_phone, loc_name, loc_admin_street1, 
                    loc_admin_street2, loc_admin_city, loc_admin_state, loc_admin_zip, sunday_hours, 
                    monday_hours, tuesday_hours, wednesday_hours, thursday_hours, friday_hours, 
                    saturday_hours, web_address, pre_screen, insurance_accepted, walkins_accepted, 
                    provider_notes, searchable_name, in_stock, supply_level, quantity_last_updated, 
                    geopoint, category
                ) VALUES #values[i]#
            </cfquery>
        </cfloop>
    <cfcatch type="Any">
        <cfoutput>
            Error: #cfcatch.message#<br>
            Detail: #cfcatch.detail#<br>
            SQLState: #cfcatch.SqlState#<br>
            ErrorCode: #cfcatch.ErrorCode#
        </cfoutput>
    </cfcatch>
    </cftry>     
    </cfoutput>
</body>
</html>
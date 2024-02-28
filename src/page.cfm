<!DOCTYPE html>
<html>
<head>
    <title>Basic ColdFusion Page</title>
</head>
<body>
    <cfoutput>
        <h1>Welcome to ColdFusion!</h1>
        <p>Current Server Time: #Now()#</p>
    </cfoutput>
    <cfoutput>
        <cfset Env =createObject("java","java.lang.System")>
        <cfset api_key = Env.getProperty("APP_TOKEN")>
        <cfset api_endpoint = Env.getProperty("API_EP")>
        <cfset db_name="CDC_DataSource">
        <cfset db_user= Env.getProperty("db_user")>
        <cfset db_table = Env.getProperty("table_name")>
        <cfset db_password = Env.getProperty("db_pass")>
        <cftry>
            <cfhttp url="#api_endpoint#" method="GET" result="httpResponse">
                <cfhttpparam type="header" name="X-App-Token" value=#api_key#>
            </cfhttp>
            <cfif httpResponse.statusCode eq "200 OK">
                <cfset fluProviderData = deserializeJSON(httpResponse.filecontent)>
            <cfelse>
                <p>Error retrieving data. HTTP Status Code: #httpResponse.statusCode#</p>
            </cfif>

            <cfcatch type="Any">
                <p>Error: #cfcatch.message#</p>
            </cfcatch>
        </cftry>
        <cftry>
        <cfscript>
        myData = [];
        for (i = 1; i <= arrayLen(fluProviderData); i++) {
            currentItem = fluProviderData[i];
            addressArray = [];
            openHoursArray = [];
            insuranceAccept = [];
            walkinAccept = [];
            notesArr = [];
            valuesArray = [];


    
            addressArray.append(currentItem.loc_admin_street1);
            addressArray.append(currentItem.loc_admin_city);
            addressArray.append(currentItem.loc_admin_state);
            addressArray.append(currentItem.loc_admin_zip);
            address = arrayToList(addressArray, " ");

    
            if (structKeyExists(currentItem, "monday_hours")) {
                openHoursArray.append("M: #currentItem.monday_hours#, ");
            }
            if (structKeyExists(currentItem, "tuesday_hours")) {
                openHoursArray.append("T: #currentItem.tuesday_hours#, ");
            }
            if (structKeyExists(currentItem, "wednesday_hours")) {
                openHoursArray.append("W: #currentItem.wednesday_hours#, ");
            }
            if (structKeyExists(currentItem, "thursday_hours")) {
                openHoursArray.append("Th: #currentItem.thursday_hours#, ");
            }
            if (structKeyExists(currentItem, "friday_hours")) {
                openHoursArray.append("F: #currentItem.friday_hours#, ");
            }
            if (structKeyExists(currentItem, "saturday_hours")) {
                openHoursArray.append("S: #currentItem.saturday_hours#");
            }    
            open_hours = Len(arrayToList(openHoursArray, " ")) ? arrayToList(openHoursArray, " ") : "NULL";

            if(structKeyExists(currentItem, "insurance_accepted")) {
                insuranceAcceptance = Len(Trim(currentItem.insurance_accepted)) ? "TRUE" : "FALSE"
                insuranceAccept.append(insuranceAcceptance);
            }
            else {
                insuranceAccept.append("NULL");
            }
            if(structKeyExists(currentItem, "walkins_accepted")) {
                walkinAcceptance = Len(Trim(currentItem.walkins_accepted)) ? "TRUE" : "FALSE"
                walkinAccept.append(walkinAcceptance);
            } else {
                walkinAccept.append("NULL");
            }
            if(structKeyExists(currentItem,"provider_notes")) {
                notesArr.append(currentItem.provider_notes);
            } else {
                notesArr.append("NULL");
            }
            POINT = "POINT("&currentItem.latitude & " " & currentItem.longitude&")";
            valuesArray.append( '"' & currentItem.loc_name & '"');
            valuesArray.append( '"' & currentItem.loc_phone & '"');
            valuesArray.append('"' & address & '"');
            valuesArray.append( '"' & open_hours & '"');
            valuesArray.append(arrayToList(insuranceAccept, ","));
            valuesArray.append(arrayToLIst(walkinAccept, ","));
            if (notesArr.contains("NULL")){
                valuesArray.append(arrayToList(notesArr, ","));
            } else {valuesArray.append('"' & arrayToList(notesArr, ",") & '"');}
            valuesArray.append('ST_PointFromText("' & POINT & '")');
            values = arrayToList(valuesArray, ",");  
            myData.append("(" & values & ")");

    }
        writeOutput(myData[3])
        </cfscript>
        <cfquery name="insertData" datasource="#db_name#">
            INSERT INTO #db_table# (loc_name, loc_phone, loc_admin_address, Open_hours, insurance_accepted, walkins_accepted, provider_notes, geopoint)
            VALUES #arrayToList(myData,",")#
            </cfquery>
            <cfcatch type="Any">
                <p>Error: #cfcatch.message#</p>
            </cfcatch>
        </cftry>

    </cfoutput>
</body>
</html>

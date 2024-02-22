<cfset limit = 10000>
<cfset apiKey = createObject("java", "java.lang.System").getenv("API_KEY")>

<cfhttp url = "https://data.cdc.gov/resource/kvib-3txy.json?surveillance_network=FluSurv-NET&$limit=#limit#" method = "GET" result = "httpResponse">
    <cfhttpparam type = "header" name = "X-App-Token" value = "#apiKey#">
</cfhttp>

<cfset fluData = deserializeJSON(httpResponse.fileContent)>

<cfquery datasource = "TestMySql">
    DELETE FROM flu_hospitalizations.hospitalization_info
</cfquery>

<cfset formattedData = ''>

<cfloop array = "#fluData#" index = "user">
    <cfif structKeyExists(user, "cumulative_rate")>
        <cfset formattedData &= '("#user._weekenddate#", "#user.age_group#", #user.cumulative_rate#, #user.mmwr_week#, #user.mmwr_year#, 
        "#user.race_ethnicity#", "#user.season#", "#user.sex#", "#user.site#", "#user.surveillance_network#", #user.weekly_rate#), '>
    </cfif>
</cfloop>

<cfset formattedData = left(formattedData, len(formattedData) - 2)>

<cfquery datasource = "TestMySql" result = "insertResult">
    INSERT INTO flu_hospitalizations.hospitalization_info (weekenddate, age_group, cumulative_rate, 
    mmwr_week, mmwr_year, race_ethnicity, season, sex, site, surveillance_network, weekly_rate)
    VALUES #formattedData#
</cfquery>

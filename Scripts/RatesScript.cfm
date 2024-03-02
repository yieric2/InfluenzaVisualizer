<cffile action="read" file="C:\ColdFusion\cfusion\wwwroot\Projects\CSVFiles\Rates_of_Laboratory-Confirmed_RSV__COVID-19__and_Flu_Hospitalizations_from_the_RESP-NET_Surveillance_Systems_20240302.csv" variable="csvContent">

<cfset formattedData = []>

<cfset lines = listToArray(csvContent, chr(10) & chr(13))>

<cfloop index="i" from="2" to="#arrayLen(lines)#">

    <cfset row = csvSplit(lines[i])>
    
    <cfif arrayLen(row) gte 11>
        <cfset weekEndDate = row[11]>
        <cfset ageGroup = row[5]>
        <cfset cumulativeRate = row[10]>
        <cfset mmwrWeek = row[4]>
        <cfset mmwrYear = row[3]>
        <cfset raceEthnicity = row[7]>
        <cfset season = row[2]>
        <cfset sex = row[6]>
        <cfset site = row[8]>
        <cfset surveillanceNetwork = row[1]>
        <cfset weeklyRate = row[9]>
        <cfif surveillanceNetwork eq "FluSurv-NET" and len(trim(cumulativeRate))>
            <cfset formattedData.append('("#weekEndDate#", "#ageGroup#", #cumulativeRate#, #mmwrWeek#, #mmwrYear#, "#raceEthnicity#", "#season#", "#sex#", "#site#", "#surveillanceNetwork#", #weeklyRate#)')>
        </cfif>
    </cfif>
</cfloop>

<cfquery datasource="TestMySql">
    DELETE FROM flu_hospitalizations.hospitalization_info
</cfquery>

<cfset formattedQueryString = arrayToList(formattedData, ', ')>

<cfquery datasource="TestMySql" result="insertResult">
    INSERT INTO flu_hospitalizations.hospitalization_info (weekenddate, age_group, cumulative_rate, 
    mmwr_week, mmwr_year, race_ethnicity, season, sex, site, surveillance_network, weekly_rate)
    VALUES #formattedQueryString#
</cfquery>

<cffunction name="csvSplit" returntype="array" output="false">
    <cfargument name="line" type="string" required="true">
    <cfset var fields = []>
    <cfset var inQuote = false>
    <cfset var field = "">

    <cfloop from="1" to="#len(line)#" index="i">
        <cfset char = mid(line, i, 1)>

        <cfif char eq '"'>
            <cfset inQuote = not inQuote>
        <cfelseif char eq "," and not inQuote>
            <cfset fields.append(field)>
            <cfset field = "">
        <cfelse>
            <cfset field &= char>
        </cfif>
    </cfloop>

    <cfset fields.append(field)>

    <cfreturn fields>
</cffunction>

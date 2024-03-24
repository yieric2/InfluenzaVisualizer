<cffile action="read" file="C:\ColdFusion\cfusion\wwwroot\Projects\CSVFiles\Influenza_Vaccination_Coverage_for_All_Ages__6__Months__20240304.csv" variable="csvContent" > 
<cfsetting requesttimeout="500">
<!--- non-hispanic text is not necessary --->
<cfset csvContent = csvContent.ReplaceAll(", Non-Hispanic", "")>
<!--- Remove the comma inside the qualifier--->
<cfset regexPattern = '("[^",]+),([^"]+")'>
<cfset csvContent = csvContent.ReplaceAll(regexPattern, "$1$2")>
<!--- Remove qualifier - For this csv file its "" --->
<cfset csvContent = csvContent.ReplaceAll('"', "")>

<cfset lines = listToArray(csvContent, chr(10) & chr(13))>
<cfset formattedData = []>

<!--- Vaccine, GeoType, Geo, Fips, season/year, month, dimType, dim, estimate, ci, sampleSize--->

<!--- Loop though every line --->
<cfloop from="2" to="#arrayLen(lines)#" index="i">
        <cfset row = listToArray(lines[i], ",")>

        <cfif arraylen(row) eq 11>
            <!--- we only want age and race/ethnicity--->
            <cfif row[7] !== "Age" AND row[7] !== "Race and Ethnicity" >
                    <cfcontinue>      
            </cfif>
            <!--- separate start and end year from season/year--->
            <cfset season = listToArray(row[5], "-")>
            <cfset startYear = season[1]>
            <cfset endYear = startYear + 1>
            <!--- Check if Estimate is available--->
            <cfif NOT isNumeric(row[9])>
                <cfset row[9] = 0.0>        
            </cfif>
            <!--- Check if CI is available--->
            <!--- Separate CI first to extract the first value--->
            <cfset ciSplit = listToArray(row[10], " ")>
            <cfif NOT isNumeric(ciSplit[1])>
                <cfset row[10] = 0>        
            </cfif>
            <!--- Check if Sample size is available--->
            <cfif NOT isNumeric(row[11])>
                <cfset row[11] = 0>     
            </cfif>
            <cfset formattedData.append('("#row[1]#", "#row[2]#", "#row[3]#", #row[4]#, #row[6]#, "#row[7]#", "#row[8]#", "#row[9]#", "#row[10]#", #Int(row[11])#, "#startYear#", #endYear#)')>
        </cfif>
</cfloop>

<cfoutput >
    <p>Array Length = #arrayLen(formattedData)#</p>
</cfoutput>

<cfquery datasource="TestMySql">
    USE influenza_demographics
</cfquery>

<cfquery datasource="TestMySql" >
    TRUNCATE TABLE temp;
</cfquery>

<cfset formattedQueryString = arrayToList(formattedData, ', ')>

<cfquery datasource="TestMySql">
    INSERT INTO TEMP (Vaccine, GeoType, Geo, 
    Fips, monthValue, dimType, dim, CoverageEstimate, CI, PopulationSampleSize, startYear, endYear)
    VALUES #formattedQueryString#
</cfquery>

<cfquery datasource="TestMySql">
    INSERT INTO DimensionType (Category)
    SELECT DISTINCT dimType 
    FROM temp
</cfquery>

<cfquery datasource="TestMySql">
    INSERT INTO Dimension (Name, DimensionTypeID)
    SELECT DISTINCT dim, DimensionType.ID
    FROM TEMP
    INNER JOIN DimensionType on DimensionType.Category = dimType
</cfquery>

<cfquery datasource="TestMySql">
    INSERT INTO GeographyType (Category)
    SELECT DISTINCT GeoType
    FROM temp
</cfquery>

<cfquery datasource="TestMySql">
    INSERT INTO Geography (Name, GeographyTypeID)
    SELECT DISTINCT geo, GeographyType.ID
    FROM TEMP
    INNER JOIN GeographyType on GeographyType.Category = geoType
</cfquery>

<cfquery datasource="TestMySql">
    INSERT INTO Fips (Code)
    SELECT DISTINCT Fips 
    FROM temp
</cfquery>

<cfquery datasource="TestMySql">
    INSERT INTO Vaccinetype (Category)
    SELECT DISTINCT Vaccine 
    FROM temp
</cfquery>

<cfquery datasource="TestMySql">
    INSERT INTO Season (StartYear, EndYear, Month)
    SELECT DISTINCT startYear, endYear, monthValue 
    FROM temp
</cfquery>

<cfquery datasource="TestMySql">
    INSERT INTO Vaccine (VaccineID, GeographyId, FipsID, SeasonID, DimensionID, CoverageEstimate, CI, PopulationSampleSize)
    select VaccineType.ID, Geography.ID, Fips.ID, Season.ID, Dimension.ID, CoverageEstimate, CI, PopulationSampleSize from temp
    INNER JOIN VaccineType ON VaccineType.Category = Vaccine
    INNER JOIN Geography ON Geography.Name = geo
    INNER JOIN Fips ON Fips.Code = Fips
    INNER JOIN Dimension ON Dimension.Name = dim
    INNER JOIN Season ON Season.StartYear = temp.startYear and Season.EndYear = temp.endYear and Season.Month = monthValue
    order by temp.ID
</cfquery>

<cfquery datasource="TestMySql">
    TRUNCATE TABLE temp
</cfquery>

<cfoutput >
    <h1>done</h1>
</cfoutput>
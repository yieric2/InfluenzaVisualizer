<cfsetting enablecfoutputonly="true">
<cfset x = getHTTPRequestData()>
<cfset body = deserializeJSON(x.content)>
<cfset vaccineType = body.influenza_type>
<cfset season = body.season>
<cfset geography = body.geography>
<cfset age_group = body.age_group>
<cfset race_ethn = body.race_ethn>

<cfset dimensions = []>

<cfloop  index="i" from="1" to=#arrayLen(age_group)#>
    <cfset ArrayAppend(dimensions, "dimensionID = " & age_group[i])>
</cfloop>

<cfloop  index="i" from="1" to=#arrayLen(race_ethn)#>
    <cfset ArrayAppend(dimensions, "dimensionID = " & race_ethn[i])>
</cfloop>

<cfquery datasource="MySQL_test" name="getAll">
    use influenza_database
</cfquery>

<cfquery datasource="MySQL_test" name="getAll">
        SELECT Vaccine.ID, CoverageEstimate, CI, PopulationSampleSize, Dimension.Name as "Dimension" , Geography.Name as "Geography", Season.StartYear, Season.EndYear, Season.month, VaccineType.category from Vaccine
        INNER JOIN Season on Season.Id = Vaccine.SeasonID
        INNER JOIN Dimension ON dimension.ID = DimensionId
        INNER JOIN Geography ON Geography.ID = GeographyID
        INNER JOIN VaccineType ON VaccineType.ID = VaccineId
        WHERE vaccineID = #vaccineType# and geographyId = #geography# and (#arrayToList(dimensions, " or ")#) and season.startYear = #season#
        ORDER BY Season.month
</cfquery>

<cfoutput>#serializeJSON(data=getAll)#</cfoutput>
<cfsetting enablecfoutputonly="true">

<cfquery name="getDemographics" datasource="TestMySql">
    SELECT Vaccine.ID, CoverageEstimate, CI, PopulationSampleSize, Dimension.Name as "Dimension" , Geography.Name as "Geography", Season.StartYear, Season.EndYear, Season.month, VaccineType.category from influenza_demographics.Vaccine
    INNER JOIN influenza_demographics.Season on influenza_demographics.Season.Id = Vaccine.SeasonID
    INNER JOIN influenza_demographics.Dimension ON influenza_demographics.dimension.ID = DimensionId
    INNER JOIN influenza_demographics.Geography ON influenza_demographics.Geography.ID = GeographyID
    INNER JOIN influenza_demographics.VaccineType ON influenza_demographics.VaccineType.ID = VaccineId
    WHERE season.startYear = 2022 and (DimensionId = 32 or DimensionId = 35 or DimensionId = 42) and geographyid=131
    ORDER BY Season.month
</cfquery>

<cfoutput>#serializeJSON(getDemographics)#</cfoutput>
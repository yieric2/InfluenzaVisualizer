<cfsetting enablecfoutputonly="true">

<cfquery name="getData" datasource="TestMySql">
    SELECT weekenddate, weekly_rate
    FROM flu_hospitalizations.hospitalization_info
    WHERE ((mmwr_year = 2022 and mmwr_week > 39) or (mmwr_year = 2023 and mmwr_week < 39)) and age_group = 'overall' and sex = 'overall' and race_ethnicity = 'overall' and site = 'overall'
</cfquery>

<cfoutput>#serializeJSON(getData)#</cfoutput>
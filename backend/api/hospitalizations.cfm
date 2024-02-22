<cfsetting enablecfoutputonly="true">

<cfquery name="getData" datasource="TestMySql">
    SELECT mmwr_week, cumulative_rate
    FROM flu_hospitalizations.hospitalization_info
    WHERE mmwr_year = 2024 and age_group = 'overall' and sex = 'overall' and race_ethnicity = 'overall' and site = 'overall'
</cfquery>

<cfoutput>#serializeJSON(getData)#</cfoutput>
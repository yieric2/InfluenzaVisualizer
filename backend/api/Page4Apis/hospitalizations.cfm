<cfparam name="url.year" default="2019">
<cfparam name="url.age" default="overall">
<cfparam name="url.race" default="overall">
<cfparam name="url.rate" default="cumulative_rate">
<cfparam name="url.sex" default="overall">
<cfparam name="url.site" default="overall">


<cfsetting enablecfoutputonly="true">

<cfquery name="getData" datasource="TestMySql">
    SELECT weekenddate, #url.rate# 
    FROM flu_hospitalizations.hospitalization_info
    WHERE ((mmwr_year = (#url.year#-1) and mmwr_week > 39) or (mmwr_year = #url.year# and mmwr_week < 39)) and age_group = "#url.age#" and sex = "#url.sex#" and race_ethnicity = "#url.race#" and site = "#url.site#"
</cfquery>

<cfoutput>#serializeJSON(getData)#</cfoutput>
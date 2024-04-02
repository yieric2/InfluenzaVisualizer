<cfsetting enablecfoutputonly="true">
<cfquery name="getData" datasource="TestMySql">
    SELECT distinct mmwr_year
    FROM flu_hospitalizations.hospitalization_info
</cfquery>

<cfoutput>#serializeJSON(getData)#</cfoutput>
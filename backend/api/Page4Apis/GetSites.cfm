<cfsetting enablecfoutputonly="true">
<cfquery name="getData" datasource="TestMySql">
    SELECT distinct site
    FROM flu_hospitalizations.hospitalization_info
</cfquery>
<cfoutput>#serializeJSON(getData)#</cfoutput>
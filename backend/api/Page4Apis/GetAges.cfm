<cfsetting enablecfoutputonly="true">
<cfquery name="getData" datasource="TestMySql">
    SELECT distinct age_group
    FROM flu_hospitalizations.hospitalization_info
    ORDER BY age_group asc
</cfquery>
<cfoutput>#serializeJSON(getData)#</cfoutput>
<cfsetting enablecfoutputonly="true">
<cfquery name="getData" datasource="TestMySql">
    SELECT distinct race_ethnicity
    FROM flu_hospitalizations.hospitalization_info
</cfquery>
<cfoutput>#serializeJSON(getData)#</cfoutput>
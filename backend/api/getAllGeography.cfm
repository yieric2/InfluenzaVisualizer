<cfsetting enablecfoutputonly="true">
<cfparam name="url.id" default="0">
<cfquery datasource="MySQL_test" name="getAll">
        SELECT * 
        FROM influenza_database.Geography
        WHERE geographyTypeID = #url.id#
        ORDER BY Name
</cfquery>


<cfoutput>#serializeJSON(data=getAll, queryformat="struct")#</cfoutput>
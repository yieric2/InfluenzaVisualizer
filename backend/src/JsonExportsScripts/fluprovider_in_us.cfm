<cfsetting enablecfoutputonly="true">
<cfset Env =createObject("java","java.lang.System")>
<cfset db_name="CDC_DataSource">
<cfset db_user= Env.getProperty("db_user")>
<cfset db_table = Env.getProperty("table_name")>
<cfquery name="getData" datasource="#db_name#">
    SELECT distinct ST_X(geopoint) as lat, ST_Y(geopoint) as log, loc_admin_state
    FROM #db_table#
</cfquery>
<cfoutput>#serializeJSON(getData)#</cfoutput>

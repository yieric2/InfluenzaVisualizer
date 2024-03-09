<cfsetting enablecfoutputonly="true">
<cfset Env =createObject("java","java.lang.System")>
<cfset db_name="CDC_DataSource">
<cfset db_user= Env.getProperty("db_user")>
<cfset db_table = Env.getProperty("table_name")>
<cfset db_password = Env.getProperty("db_pass")>
<!--- Perform the database query --->
<cfquery name="getData" datasource="#db_name#">
    SELECT loc_store_no, ST_X(geopoint) as lat, ST_Y(geopoint) as log
    FROM #db_table#
</cfquery>
<cfoutput>#serializeJSON(getData)#</cfoutput>

<cfsetting enablecfoutputonly="true">
<cfset Env =createObject("java","java.lang.System")>
<cfset db_name="CDC_DataSource">
<cfset db_user= Env.getProperty("db_user")>
<cfset db_table = Env.getProperty("table_name")>
<cfquery name="getData" datasource="#db_name#">
    SELECT  ST_X(geopoint) as lng, ST_Y(geopoint) as lat, upper(loc_admin_city) as city, loc_phone as phoneNum
    FROM #db_table#
    LIMIT 500
</cfquery>
<cfoutput>#serializeJSON(getData)#</cfoutput>
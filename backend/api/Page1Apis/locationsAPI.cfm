<cfsetting enablecfoutputonly="true">

<cfquery name="getData" datasource="TestMySql">
    SELECT  ST_X(geopoint) as lat, ST_Y(geopoint) as lng, upper(loc_admin_city) as city, loc_phone as phoneNum
    FROM cdc_db.provider_locations
    LIMIT 500
</cfquery>
<cfoutput>#serializeJSON(getData)#</cfoutput>


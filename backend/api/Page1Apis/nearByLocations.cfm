<cfsetting enablecfoutputonly="true">
<cftry>
    <cfparam name="URL.lat" default="">
    <cfparam name="URL.lng" default="">
    <cfset lat = URL.lat>
    <cfset lng = URL.lng>
    <cfset miles = URL.miles>
        <cfquery name="getLoc" datasource="TestMySql">
            SELECT 
                ST_X(geopoint) AS longitude, 
                ST_Y(geopoint) AS latitude, 
                walkins_accepted, 
                insurance_accepted, 
                loc_admin_zip, 
                loc_admin_city, 
                loc_admin_state, 
                loc_admin_street1, 
                loc_phone, 
                web_address, 
                monday_hours, 
                tuesday_hours, 
                wednesday_hours, 
                thursday_hours, 
                friday_hours, 
                saturday_hours, 
                sunday_hours,
                (6371 * acos(
                    cos(radians(#lat#)) 
                    * cos(radians(ST_Y(geopoint))) 
                    * cos(radians(ST_X(geopoint)) - radians(#lng#)) 
                    + sin(radians(#lat#)) 
                    * sin(radians(ST_Y(geopoint)))
                )) AS distance
            FROM cdc_db.provider_locations
            WHERE (
                6371 * acos(
                    cos(radians(#lat#)) 
                    * cos(radians(ST_Y(geopoint))) 
                    * cos(radians(ST_X(geopoint)) - radians(#lng#)) 
                    + sin(radians(#lat#)) 
                    * sin(radians(ST_Y(geopoint)))
                )
            ) <= 1.60934 * #miles#
            ORDER BY distance;
        </cfquery>
    <cfoutput>#serializeJSON(getLoc)#</cfoutput>
<cfcatch type="any">
            <cfoutput>#serializeJSON({ "error4": cfcatch.message })#</cfoutput>
</cfcatch>
</cftry>
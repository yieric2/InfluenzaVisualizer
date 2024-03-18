<cfcomponent rest="true" restPath="/APIroutes">
        <cfheader name="Access-Control-Allow-Origin" value="*">
        <cfheader name="Access-Control-Allow-Methods" value="GET, POST, OPTIONS">
        <cfheader name="Access-Control-Allow-Headers" value="Content-Type">
        <cfheader name="Access-Control-Allow-Credentials" value="true">

        <cffunction name="getAllDimension" restpath="getAllDimension" access="remote" returnType="query" httpMethod="GET">
                <cfset res="Hello World">
                <cfquery datasource="MySQL_test" name="getAll">
                        SELECT * 
                        FROM influenza_database.dimension
                </cfquery>

                <cfreturn getAll>
        </cffunction>

        <cffunction name="getAllDimensionType" restpath="getAllDimensionType" access="remote" returnType="any" httpMethod="GET">
                <cfset res="Hello World">
                <cfquery datasource="MySQL_test" name="getAll">
                        SELECT * 
                        FROM influenza_database.dimensionType
                </cfquery>

                <cfreturn serializeJSON(data=getAll, queryformat="struct")>
        </cffunction>

        <cffunction name="getAllVaccineType" restpath="getAllVaccineType" access="remote" returnType="any" httpMethod="GET">
                <cfset res="Hello World">
                <cfquery datasource="MySQL_test" name="getAll">
                        SELECT * 
                        FROM influenza_database.VaccineType
                </cfquery>

                <cfreturn serializeJSON(data=getAll, queryformat="struct")>
        </cffunction>    

        <cffunction name="getAllGeographyType" restpath="getAllGeographyType" access="remote" returnType="any" httpMethod="GET">
                <cfset res="Hello World">
                <cfquery datasource="MySQL_test" name="getAll">
                        SELECT * 
                        FROM influenza_database.GeographyType
                </cfquery>

                <cfreturn serializeJSON(data=getAll, queryformat="struct")>
        </cffunction>        

        <cffunction name="getAllGeography" restpath="getAllGeography" access="remote" returnType="any" httpMethod="GET">
                <cfargument name="geographyTypeID"> 
                <cfquery datasource="MySQL_test" name="getAll">
                        SELECT * 
                        FROM influenza_database.Geography
                        WHERE geographyTypeID = #geographyTypeID#
                </cfquery>

                <cfreturn serializeJSON(data=getAll, queryformat="struct")>
        </cffunction>      
</cfcomponent>
<cfcomponent output="false">
    
    <cfset this.name = "influenza_rest">
    <cfset this.restsetting.cfclocation = "./">
    <cfset this.restsetting.skipcfcwitherror = true>

    <cffunction name="onApplicationStart" returnType="boolean">
           <cfset restInitApplication(getDirectoryFromPath(getCurrentTemplatePath()), "controller")>
           <cfreturn true>
    </cffunction>

    <cffunction name="onRequestStart" returntype="void" output="true">
            <cfif isDefined("URL.reload") AND URL.reload EQ "r3l0ad">
                <cflock timeout="10"  throwontimeout="No" type="Exclusive" scope="Application">
                    <cfset onApplicationStart()>   
                </cflock>
                <cfhtmlhead text="<script language=""Javascript"">alert('Application was refreshed.');</script>">
            </cfif>
    </cffunction>
</cfcomponent>
<cfsetting enablecfoutputonly="true">
<cfset apiKey = createObject("java", "java.lang.System").getenv("API_KEY")>
<cfoutput>#serializeJSON(apiKey)#</cfoutput>
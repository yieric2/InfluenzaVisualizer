<html>
<head>
<title>
Thibault RDE
</title>
</head>
<body>
<p>
this is a test
</p>

<cfset apiKeyFilePath = "C:\ColdFusion2023\cfusion\wwwroot\Projects\key.txt">
<cffile action = "read" file = "#apiKeyFilePath#" variable = "apiKeyContent">
<cfset apiKey = trim(apiKeyContent)>

<cfset apiEndPoint = "https://data.cdc.gov/resource/k87d-gv3u.json">
<cfset limit = 50000>
<cfhttp method = "GET" url = "#apiEndPoint#?$limit=#limit#" result = "httpResponse">
    <cfhttpparam type = "header" name = "X-App-Token" value = #apiKey#>
</cfhttp>

<cfset FluDosesData = deserializeJSON(httpResponse.filecontent)>
<cfset rowCount = arrayLen(FluDosesData)>

<cfoutput>Number of rows returned: #rowCount#</cfoutput>
<cfdump var = "#FluDosesData#">
</body>
</html>
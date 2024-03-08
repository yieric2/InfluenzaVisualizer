<cffile action = "read" 
        file = "C:\ColdFusion2023\cfusion\wwwroot\Projects\csv\dataset-after-2018.csv" 
        variable = "csv2018after">
<cffile action = "read" 
        file = "C:\ColdFusion2023\cfusion\wwwroot\Projects\csv\dataset-before-2018.csv" 
        variable = "csv2018before">

<cfset dataset1 = []>

<cfset lines = listToArray(csv2018after, chr(10) & chr(13))>
<!--- 
Week start lines[2]
Week end lines[3]
Influenza Season : lines[1]
Week Season Order lines[6]
Cumulative doses lines[8]

--->
<cfloop index = "i" from = "2" to = "#arrayLen(lines)#">

    <cfset row = listToArray(lines[i], ",")>

    <cfset dataset1.append('#row[1]#, #row[2]#, #row[3]#, #row[6]#, #row[8]#')>

</cfloop>

<cfscript>
    writeDump(dataset1)
</cfscript>

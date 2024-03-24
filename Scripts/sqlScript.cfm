<cffile action = "read" 
        file = "C:\ColdFusion\cfusion\wwwroot\Projects\CSVFiles\dataset-after-2018.csv" 
        variable = "csv2018after">


<cfset dataset1 = []>

<cfset lines = listToArray(csv2018after, chr(10) & chr(13))>
<!--- 
Week start lines[2]
Week end lines[3]
Influenza Season : lines[1]
Week Season Order lines[6]
Cumulative doses lines[8]

--->
<cfquery datasource = "TestMySql">
    DELETE FROM doses.cumulative_influenza_vaccine_doses_millions
</cfquery>

<cfloop index = "i" from = "2" to = "#arrayLen(lines)#">

    <cfset row = listToArray(lines[i], ',')>
       
  



    <cfset weekStartDate = dateFormat(parseDateTime(row[2], "MM/dd/yyyy"), "yyyy-MM-dd")>
    <cfset weekEndDate = dateFormat(parseDateTime(row[3], "MM/dd/yyyy"), "yyyy-MM-dd")>




<cfquery datasource = "TestMySql">

    INSERT INTO doses.cumulative_influenza_vaccine_doses_millions
    VALUES ('#weekStartDate#', '#weekEndDate#', '#row[1]#', '#row[6]#', '#row[8]#')

</cfquery>


</cfloop>


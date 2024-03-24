
<cfsetting enablecfoutputonly="true">

<cfquery name="getDoses" datasource="TestMySql">
    SELECT WeekSeasonOrder, CumulativeDoses
    FROM doses.cumulative_influenza_vaccine_doses_millions
    WHERE Season = '2018-2019'
</cfquery>

<cfoutput>#serializeJSON(getDoses)#</cfoutput>
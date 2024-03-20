component
{

    remote any function getDosesTable()
    {
        return queryToArray(queryExecute("SELECT * 
        FROM doses.cumulative_influenza_vaccine_doses_millions
        WHERE Season = '2018-2019'
        ", [], {datasource = "RDE_Influenza"}));
    }
    
    function queryToArray(query)
    {
        return deserializeJSON(serializeJSON(query, 'struct'));
    }
    
}
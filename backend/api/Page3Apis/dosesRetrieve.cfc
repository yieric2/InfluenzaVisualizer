component
{

    remote any function getDosesTable()
    {
        return queryToArray(queryExecute("SELECT * 
        FROM doses.cumulative_influenza_vaccine_doses_millions", [], {datasource = "TestMySql"}));
    }
    
    function queryToArray(query)
    {
        return deserializeJSON(serializeJSON(query, 'struct'));
    }
    
}
SELECT 
    d.name AS DatabaseName,
    COALESCE(c.ActiveConnections, 0) AS ActiveConnections
FROM 
    sys.databases d
LEFT JOIN 
    (SELECT 
        DB_NAME(database_id) AS db_name,
        COUNT(session_id) AS ActiveConnections
     FROM 
        sys.dm_exec_sessions
     WHERE 
        database_id > 0
     GROUP BY 
        database_id
    ) c 
    ON d.name = c.db_name
ORDER BY 
    ActiveConnections DESC;

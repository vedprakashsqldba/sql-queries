SELECT 
    t.NAME AS TableName,
    s.Name AS SchemaName,
    p.rows AS RowCounts,
    CAST(ROUND(((SUM(a.total_pages) * 8.0) / 1024 / 1024), 2) AS DECIMAL(10, 2)) AS TotalSizeGB,
    CAST(ROUND(((SUM(a.used_pages) * 8.0) / 1024 / 1024), 2) AS DECIMAL(10, 2)) AS UsedSizeGB,
    CAST(ROUND(((SUM(a.data_pages) * 8.0) / 1024 / 1024), 2) AS DECIMAL(10, 2)) AS DataSizeGB,
    CAST(ROUND(((SUM(a.total_pages - a.used_pages) * 8.0) / 1024 / 1024), 2) AS DECIMAL(10, 2)) AS IndexSizeGB
FROM 
    sys.tables t
INNER JOIN      
    sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN 
    sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
INNER JOIN 
    sys.allocation_units a ON p.partition_id = a.container_id
LEFT OUTER JOIN 
    sys.schemas s ON t.schema_id = s.schema_id
GROUP BY 
    t.Name, s.Name, p.Rows
ORDER BY 
    TotalSizeGB DESC;

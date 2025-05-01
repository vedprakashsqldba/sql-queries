SELECT 
    t.name AS TableName,
    s.name AS SchemaName,
    ep.value AS TableClassification
FROM 
    sys.tables t
JOIN 
    sys.schemas s ON t.schema_id = s.schema_id
JOIN 
    sys.extended_properties ep ON ep.major_id = t.object_id
JOIN  sys.columns col
on t.object_id = col.object_id
	

WHERE 
    ep.name = 'TABLE_CLASSIFICATION' 
    AND ep.value = 'Transactional'
	and col.name='add_date_time';
	
	
-------------------------------------------------------------------------

SELECT db_name() as DB_Names,
    t.name  AS TableName,
    s.name AS SchemaName,
    ep.value AS TableClassification
FROM 
    sys.tables t
JOIN 
    sys.schemas s ON t.schema_id = s.schema_id
JOIN 
    sys.extended_properties ep ON ep.major_id = t.object_id
JOIN  sys.columns col
on t.object_id = col.object_id
	
WHERE 
    ep.name = 'TABLE_CLASSIFICATION' 
    AND ep.value = 'Transactional'
	AND t.name in (
					SELECT t.name AS TableName
					FROM sys.tables t
					WHERE t.is_ms_shipped = 0
					AND NOT EXISTS (
					SELECT 1
					FROM sys.columns c
					WHERE c.object_id = t.object_id
					AND c.name = 'add_date_time'
						)
					)
group by t.name,s.name,ep.value 

	
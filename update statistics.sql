DECLARE @table_name NVARCHAR(32);  
SET @table_name='Person.Person'  
SELECT sch.name + '.' + so.name AS table_name  
      , so.object_id  
      , ss.name  AS stat_name  
      , ds.stats_id  
      , ds.last_updated  
      , ds.rows  
      , ds.rows_sampled  
      , ds.rows_sampled*1.0/ds.rows *100 AS sample_rate  
      , ds.steps  
      , ds.unfiltered_rows  
      --, ds.persisted_sample_percent  
      , ds.modification_counter   
      , 'UPDATE STATISTICS ' + QUOTENAME(DB_NAME()) + '.' + QUOTENAME(sch.name) + '.' + QUOTENAME( so.name) + ' "' +  RTRIM(LTRIM(ss.name)) + '" WITH SAMPLE 80 PERCENT;'  
        AS update_stat_script  
FROM sys.stats ss  
JOIN sys.objects so ON ss.object_id = so.object_id  
JOIN sys.schemas sch ON so.schema_id = sch.schema_id  
CROSS APPLY sys.dm_db_stats_properties(ss.object_id,ss.stats_id) ds  
WHERE  so.is_ms_shipped = 0   
        AND so.object_id NOT IN (  
        SELECT  major_id  
        FROM    sys.extended_properties (NOLOCK)  
        WHERE   name = N'microsoft_database_tools_support' )  
       -- AND so.object_id =OBJECT_ID(@table_name)  
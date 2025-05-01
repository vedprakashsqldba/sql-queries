SELECT TOP(50) qs.execution_count AS [Execution Count],
(qs.total_logical_reads)*8/1024.0 AS [Total Logical Reads (MB)],
(qs.total_logical_reads/qs.execution_count)*8/1024.0 AS [Avg Logical Reads (MB)],
(qs.total_worker_time)/1000.0 AS [Total Worker Time (ms)],
(qs.total_worker_time/qs.execution_count)/1000.0 AS [Avg Worker Time (ms)],
(qs.total_elapsed_time)/1000.0 AS [Total Elapsed Time (ms)],
(qs.total_elapsed_time/qs.execution_count)/1000.0 AS [Avg Elapsed Time (ms)],
qs.creation_time AS [Creation Time]
,t.text AS [Complete Query Text], qp.query_plan AS [Query Plan]
FROM sys.dm_exec_query_stats AS qs WITH (NOLOCK)
CROSS APPLY sys.dm_exec_sql_text(plan_handle) AS t
CROSS APPLY sys.dm_exec_query_plan(plan_handle) AS qp
WHERE t.dbid = DB_ID()
 ORDER BY qs.execution_count DESC OPTION (RECOMPILE);-- frequently ran query
-- ORDER BY [Total Logical Reads (MB)] DESC OPTION (RECOMPILE);-- High Disk Reading query
-- ORDER BY [Avg Worker Time (ms)] DESC OPTION (RECOMPILE);-- High CPU query
-- ORDER BY [Avg Elapsed Time (ms)] DESC OPTION (RECOMPILE);-- Long Running query

--SELECT TOP 500 * 
--FROM
--(
--    SELECT  [Last Execution Time] = last_execution_time,
--            [Execution Count] = execution_count,
--    [SQL Statement] = (
--                    SELECT TOP 1 SUBSTRING (s2. TEXT,statement_start_offset / 2+ 1 ,
--    ( ( CASE WHEN statement_end_offset = -1
--    THEN ( LEN(CONVERT (NVARCHAR( MAX),s2 .TEXT)) * 2 )
--                    ELSE statement_end_offset END )- statement_start_offset) / 2 +1)
--                    ),
--            [Stored Procedure Name] = COALESCE( OBJECT_NAME(s2 .objectid), 'Ad-Hoc Query'),
--            [Last Elapsed Time] = s1.last_elapsed_time,
--            [Minimum Elapsed Time] = s1.min_elapsed_time,
--            [Maximum Elapsed Time] = s1.max_elapsed_time,
--			[execion plan] = qp.query_plan
--    FROM sys.dm_exec_query_stats AS s1
--    CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS s2 
--	CROSS APPLY sys.dm_exec_query_plan(plan_handle) AS qp
--) x
--WHERE [SQL Statement] NOT LIKE '%SELECT TOP 500%' /* Exclude this query */
--ORDER BY  [Execution Count] DESC


SELECT TOP 10 
    qs.query_id,
    qst.query_sql_text,
    ISNULL(OBJECT_NAME(qs.object_id), 'Ad-Hoc Query') AS QuerySource,
    SUM(rs.avg_cpu_time * rs.count_executions) AS total_cpu_time_ms,
    SUM(rs.count_executions) AS execution_count,
    MAX(rs.avg_cpu_time) AS max_cpu_time_per_execution_ms
FROM sys.query_store_runtime_stats rs
JOIN sys.query_store_runtime_stats_interval rsi ON rs.runtime_stats_interval_id = rsi.runtime_stats_interval_id
JOIN sys.query_store_plan qp ON rs.plan_id = qp.plan_id
JOIN sys.query_store_query qs ON qp.query_id = qs.query_id
JOIN sys.query_store_query_text qst ON qs.query_text_id = qst.query_text_id
WHERE rsi.end_time >= DATEADD(DAY, -1, GETUTCDATE())  -- Last 24 hours
GROUP BY qs.query_id, qst.query_sql_text, qs.object_id
ORDER BY total_cpu_time_ms DESC;

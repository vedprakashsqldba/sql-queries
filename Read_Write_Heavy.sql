SELECT object_name, counter_name, cntr_value
FROM sys.dm_os_performance_counters
WHERE [object_name] LIKE '%Buffer Manager%'
AND ([counter_name] = 'Page reads/sec' OR [counter_name] = 'Page writes/sec')
GO


-- Summary of read and write operations based on cached query stats
SELECT 
    SUM(total_logical_reads) AS TotalLogicalReads,
    SUM(total_logical_writes) AS TotalLogicalWrites,
    SUM(total_logical_reads) * 1.0 / NULLIF(SUM(total_logical_writes), 0) AS ReadWriteRatio,
    COUNT(*) AS QueryCount
FROM 
    sys.dm_exec_query_stats
WHERE 
    total_logical_reads > 0 OR total_logical_writes > 0;

SELECT 
    COUNT(*) AS ActiveRequests,
    SUM(CASE WHEN command IN ('SELECT') THEN 1 ELSE 0 END) AS ReadRequests,
    SUM(CASE WHEN command IN ('INSERT', 'UPDATE', 'DELETE') THEN 1 ELSE 0 END) AS WriteRequests
FROM 
    sys.dm_exec_requests;


	

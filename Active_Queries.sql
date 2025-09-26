SELECT
    s.session_id,
    r.request_id,
    s.login_name,
    r.start_time,
    r.status,
    r.command,
    t.text AS sql_text,
    r.wait_type,
    r.wait_time,
    r.last_wait_type,
    r.wait_resource,
    ws.wait_time_ms,
    ws.waiting_tasks_count
FROM sys.dm_exec_sessions AS s
JOIN sys.dm_exec_requests AS r ON s.session_id = r.session_id
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) AS t
LEFT JOIN sys.dm_os_wait_stats AS ws ON r.wait_type = ws.wait_type
ORDER BY r.start_time DESC;

-- User Specific 
SELECT 
    s.session_id,
    s.login_name,
    r.status,
    r.command,
    r.start_time,
    r.cpu_time,
    r.total_elapsed_time,
    t.text AS [sql_text],blocking_session_id
FROM sys.dm_exec_sessions s
JOIN sys.dm_exec_requests r ON s.session_id = r.session_id
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) t
WHERE s.login_name like  '%dep%';


SELECT TOP 10 s.session_id,
           r.status,
           r.cpu_time,
           r.logical_reads,
           r.reads,
           r.writes,
           r.total_elapsed_time / (1000 * 60) 'Elaps M',
           SUBSTRING(st.TEXT, (r.statement_start_offset / 2) + 1,
           ((CASE r.statement_end_offset
                WHEN -1 THEN DATALENGTH(st.TEXT)
                ELSE r.statement_end_offset
            END - r.statement_start_offset) / 2) + 1) AS statement_text,
           COALESCE(QUOTENAME(DB_NAME(st.dbid)) + N'.' + QUOTENAME(OBJECT_SCHEMA_NAME(st.objectid, st.dbid)) 
           + N'.' + QUOTENAME(OBJECT_NAME(st.objectid, st.dbid)), '') AS command_text,
           r.command,
           s.login_name,
           s.host_name,
           s.program_name,
           s.last_request_end_time,
           s.login_time,
           r.open_transaction_count
FROM sys.dm_exec_sessions AS s
JOIN sys.dm_exec_requests AS r ON r.session_id = s.session_id CROSS APPLY sys.Dm_exec_sql_text(r.sql_handle) AS st
WHERE r.session_id != @@SPID
ORDER BY r.cpu_time DESC
go

SELECT
    s.session_id,
    r.request_id,
    s.login_name,
    r.start_time,
    r.status,
    r.command,
    t.text AS sql_text,
    r.wait_type,
    r.wait_time,
    r.last_wait_type,
    r.wait_resource,
    ws.wait_time_ms,
    ws.waiting_tasks_count
FROM sys.dm_exec_sessions AS s
JOIN sys.dm_exec_requests AS r ON s.session_id = r.session_id
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) AS t
LEFT JOIN sys.dm_os_wait_stats AS ws ON r.wait_type = ws.wait_type
ORDER BY r.start_time DESC;




SELECT
    wait_type,
    wait_time_ms,
    waiting_tasks_count,
    wait_time_ms / waiting_tasks_count AS avg_wait_time_ms
FROM sys.dm_db_wait_stats
ORDER BY wait_time_ms DESC;

DBCC SQLPERF ('sys.dm_os_wait_stats', CLEAR);

/*
✅ 2. Investigate and Tune Problematic Wait Types
Below are examples of common waits and what to do about them:

Wait Type					Meaning	Common							Causes / Fix
CXPACKET, CXCONSUMER		Parallelism waits						Review max degree of parallelism (MAXDOP) and cost threshold for parallelism
SOS_SCHEDULER_YIELD			CPU pressure							Check CPU usage, parallel queries, thread waits
ASYNC_NETWORK_IO			App not consuming data					Check app/network bottlenecks
LATCH_ and PAGELATCH_		Contention on memory or pages			Optimize indexing, reduce hotspot pages
WRITELOG, LOGMGR_FLUSH		Log write waits							Consider faster storage or optimize logging
RESOURCE_SEMAPHORE			Memory waits for queries				Check query memory grants or reduce memory pressure
PAGEIOLATCH_*				Physical I/O waits						Check disk performance, consider caching or indexing
PREEMPTIVE_ waits			External calls (e.g., OS, CLR, OLEDB)	Look at external dependencies and calls
HT*, BMP*, WINDOW_*			Complex query processing				Review execution plans, consider indexing or rewriting queries
LCK_M_*						Lock waits								Investigate blocking, long transactions
*/

select * from sys.dm_os_wait_stats
ORDER BY  3 DESC;

sp_who2

lockable - 550 * 

cvv 247 

Ninja 300 - 340
Yamaha R3 - 360


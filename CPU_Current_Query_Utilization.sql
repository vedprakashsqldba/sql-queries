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
sp_who2

https://osjira.oneshield.com/jira/browse/AIMDEV-1618


--------------------------------------------------------------------------------------------------------------------------

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



select * from sys.event_log where database_name='omsdev1'
and start_time > '2024-05-29 00:00:00.0000000'
and end_time < '2024-05-29 01:00:00.0000000'

select * from sys.database_connection_stats where 
 database_name='omsdev1'
and start_time > '2024-05-29 00:00:00.0000000'
and end_time < '2024-05-29 01:00:00.0000000'

SELECT start_time, end_time, database_name, sku, avg_cpu_percent, max_worker_percent, max_session_percent 
FROM sys.resource_stats
where  database_name='omsdev1'
and start_time > '2024-05-29 00:00:00.0000000'
and end_time < '2024-05-29 01:00:00.0000000'


SELECT
    r.session_id, r.request_id, r.blocking_session_id, r.start_time, 
    r.status, r.command, DB_NAME(r.database_id) AS database_name,
    (SELECT COUNT(*) 
        FROM sys.dm_os_tasks AS t 
        WHERE t.session_id=r.session_id and t.request_id=r.request_id) AS worker_count,
    i.parameters, i.event_info AS input_buffer,
    r.last_wait_type, r.open_transaction_count, r.total_elapsed_time, r.cpu_time,
    r.logical_reads, r.writes, s.login_time, s.login_name, s.program_name, s.host_name
FROM sys.dm_exec_requests as r
JOIN sys.dm_exec_sessions as s on r.session_id=s.session_id
OUTER APPLY sys.dm_exec_input_buffer (r.session_id,r.request_id) AS i
WHERE s.is_user_process=1;
GO


SELECT
    r.start_time, DATEDIFF(ms,start_time, SYSDATETIME()) as duration_ms, 
    r.session_id, r.request_id, r.blocking_session_id,  
    r.status, r.command, DB_NAME(r.database_id) AS database_name,
    i.parameters, i.event_info AS input_buffer,
    r.last_wait_type, r.open_transaction_count, r.total_elapsed_time, r.cpu_time,
    r.logical_reads, r.writes, s.login_time, s.login_name, s.program_name, s.host_name
FROM sys.dm_exec_requests as r
JOIN sys.dm_exec_sessions as s on r.session_id=s.session_id
OUTER APPLY sys.dm_exec_input_buffer (r.session_id,r.request_id) AS i
WHERE s.is_user_process=1
ORDER BY start_time ASC;
GO
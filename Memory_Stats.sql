select * from sys.dm_os_process_memory order by 1 desc
select distinct wait_category_desc from sys.query_store_wait_stats ;


select schema_name(t.schema_id) + '.' + t.name as [table],
       c.column_id,
       c.name as column_name,
       type_name(user_type_id) as data_type,
       max_length 
from sys.columns c
join sys.tables t
     on t.object_id = c.object_id
where type_name(user_type_id) in ('char')
order by          c.max_length desc

select regional_district  from dbo.audit_organizations_people

select * from sys.dm_os_wait_stats order by wait_time_ms desc

SELECT
  t1.[last_wait_type] LastWait
  --, t2.[text] QueryText
FROM sys.dm_exec_requests t1
    CROSS APPLY sys.dm_exec_sql_text(t1.sql_handle) t2

	SELECT 
  ((t1.requested_memory_kb)/1024.00) MemoryRequestedMB
  , CASE WHEN t1.grant_time IS NULL THEN 'Waiting' ELSE 'Granted' END AS RequestStatus
  , t1.timeout_sec SecondsToTerminate
  --, t2.[text] QueryText
FROM sys.dm_exec_query_memory_grants t1
  CROSS APPLY sys.dm_exec_sql_text(t1.sql_handle) t2

SELECT *
FROM sys.dm_os_sys_info;

SELECT
owt.session_id,
owt.exec_context_id,
owt.wait_duration_ms,
owt.wait_type,
owt.blocking_session_id,
owt.resource_description,
est.text,
es.program_name,
eqp.query_plan,
es.cpu_time,
es.memory_usage
FROM
sys.dm_os_waiting_tasks owt
INNER JOIN sys.dm_exec_sessions es ON 
owt.session_id = es.session_id
INNER JOIN sys.dm_exec_requests er
ON es.session_id = er.session_id
OUTER APPLY sys.dm_exec_sql_text (er.sql_handle) est
OUTER APPLY sys.dm_exec_query_plan (er.plan_handle) eqp
WHERE es.is_user_process = 1
ORDER BY owt.session_id, owt.exec_context_id


SELECT cpu_rate / 100 as CPU_vCores,
CAST( (process_memory_limit_mb) /1024. as DECIMAL(9,1)) as TotalMemoryGB
FROM sys.dm_os_job_object;


select	v.object_name,
		bp_mem_gb = (l.cntr_value*8/1024)/1024, 
		ple = v.cntr_value, 
		min_ple = (((l.cntr_value*8/1024)/1024)/4)*300
from sys.dm_os_performance_counters v
join sys.dm_os_performance_counters l on v.object_name = l.object_name
where v.counter_name = 'Page Life Expectancy'
and l.counter_name = 'Database pages'
and l.object_name like '%Buffer Node%'

select * from sys.dm_os_sys_info
go 
select * from sys.dm_user_db_resource_governance;
select * from sys.dm_resource_governor_resource_pools  
go
select * from sys.dm_os_job_object
go
select parent_memory_broker_type,sum(virtual_memory_committed_kb)
 from sys.dm_os_memory_clerks
 group by parent_memory_broker_type


 select parent_memory_broker_type,sum(virtual_memory_committed_kb)
 from sys.dm_os_memory_clerks
 group by parent_memory_broker_type

 SELECT pool_id  
     , Name  
     , min_memory_percent  
     , max_memory_percent  
     , max_memory_kb/1024 AS max_memory_mb  
     , used_memory_kb/1024 AS used_memory_mb   
     , target_memory_kb/1024 AS target_memory_mb  
   FROM sys.dm_resource_governor_resource_pools 


   SELECT [type], [name], pages_kb, virtual_memory_committed_kb
FROM sys.dm_os_memory_clerks
WHERE memory_node_id <> 64 -- ignore Dedicated Admin Connection (DAC) node
ORDER BY pages_kb DESC;
GO
SELECT [type], [name], pages_kb, virtual_memory_committed_kb
FROM sys.dm_os_memory_clerks
WHERE memory_node_id <> 64 -- ignore Dedicated Admin Connection (DAC) node
ORDER BY virtual_memory_committed_kb DESC;
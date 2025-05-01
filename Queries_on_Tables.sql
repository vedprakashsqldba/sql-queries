SELECT DISTINCT TOP 100
ProcedureName = OBJECT_SCHEMA_NAME(sqlTxt.objectid) + '.' + OBJECT_NAME(sqlTxt.objectid)
,SQLStatement = SUBSTRING(
sqlTxt.Text
,(QueryState.statement_start_offset/2)+1
,CASE QueryState.statement_end_offset
WHEN -1 THEN DATALENGTH(sqlTxt.text)
ELSE QueryState.statement_end_offset
END - (QueryState.statement_start_offset/2) + 1
)
,DiskReads = QueryState.total_physical_reads --- Disk reads
,MemoryReads = QueryState.total_logical_reads --–Logical Reads are memory reads
,ExecutionCount = QueryState.execution_count --Execution Count
,CPUTime = QueryState.total_worker_time  --CPU Time
,DiskWaitAndCPUTime = QueryState.total_elapsed_time
,MemoryWrites = QueryState.max_logical_writes
,DateCached = QueryState.creation_time
,DatabaseName = DB_Name(sqlTxt.dbid) --Database name
,LastExecutionTime = QueryState.last_execution_time
,cte.*
FROM sys.dm_exec_query_stats AS QueryState
CROSS APPLY sys.dm_exec_sql_text(QueryState.sql_handle) AS sqlTxt
CROSS APPLY sys.dm_sql_referenced_entities(
OBJECT_SCHEMA_NAME(sqlTxt.objectid) + '.' + OBJECT_NAME(sqlTxt.objectid)
, 'OBJECT'
) cte
WHERE sqlTxt.dbid = db_id() --Get detail for current database
AND cte.referenced_entity_name = 'policy_pricing_history_pointers'

select statement_string, execution_count, total_execution_time from m_sql_plan_cache where statement_string like '%policy_pricing_history_pointer%' order by total_execution_time desc;

>>

 --SELECT "v_policy_pricing_history_pointers"."pointer_table_uid", "v_policy_pricing_history_pointers"."licensee_code", "v_policy_pricing_history_pointers"."level_2_code", "v_policy_pricing_history_pointers"."limi--t_code" FROM   "omsqa_ftj"."dbo"."v_policy_pricing_history_pointers" "v_policy_pricing_history_pointers" WHERE  "v_policy_pricing_history_pointers"."pointer_table_uid"='oC3nw19c6EudGUSXFAVZGw50' AND "v_policy_pricing_history_pointers"."licensee_code"='FTJ' AND "v_policy_pricing_history_pointers"."level_2_code"='SEXUAL_MISCONDUCT'
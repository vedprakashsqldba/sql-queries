SELECT QP.query_plan as [Query Plan], 
       ST.text AS [Query Text]
FROM sys.dm_exec_requests AS R
   CROSS APPLY sys.dm_exec_query_plan(R.plan_handle) AS QP
   CROSS APPLY sys.dm_exec_sql_text(R.plan_handle) ST
  WHERE SESSION_ID!=@@SPID ;
-------------------------------------------------------------------------------
SELECT sqltext.TEXT,
req.session_id,
req.status,
req.command,
req.cpu_time,
req.total_elapsed_time
FROM sys.dm_exec_requests req
CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS sqltext
WHERE SESSION_ID!=@@SPID ;

SELECT b.session_id,
(b.wait_duration_ms/1000)/60 
,b.wait_type 
,b.blocking_session_id 
,t.text 
FROM sys.dm_os_waiting_tasks b inner join sys.dm_exec_requests r on r.session_id= b.session_id
OUTER APPLY
sys.dm_exec_sql_text(sql_handle) t
WHERE b.blocking_session_id <> 0

-- session 
SELECT 
    DB_NAME(dbid) as DBName, 
    COUNT(dbid) as NumberOfConnections,
    loginame as LoginName
FROM
    sys.sysprocesses
WHERE 
    dbid > 0
GROUP BY 
    dbid, loginame


	select loginame,DB_NAME(dbid) as DBName,status,count(*) from sys.sysprocesses
	GROUP BY     dbid,status, loginame

 --SELECT "temp_proposal"."policy_item_code", "temp_proposal"."location_pointer_uid", "temp_proposal"."premium", "temp_proposal"."group_pointer_uid", "temp_proposal"."licensee_code", "temp_proposal"."exposure_code" FROM   "omspreprod_wcis"."dbo"."temp_proposal" "temp_proposal"



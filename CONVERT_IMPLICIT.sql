SELECT TOP(50) DB_NAME(t.[dbid]) AS [Database Name], 
t.text AS [Query Text],
qs.total_worker_time AS [Total Worker Time], 
qs.total_worker_time/qs.execution_count AS [Avg Worker Time], 
qs.max_worker_time AS [Max Worker Time], 
qs.total_elapsed_time/qs.execution_count AS [Avg Elapsed Time], 
qs.max_elapsed_time AS [Max Elapsed Time],
qs.total_logical_reads/qs.execution_count AS [Avg Logical Reads],
qs.max_logical_reads AS [Max Logical Reads], 
qs.execution_count AS [Execution Count], 
qs.creation_time AS [Creation Time],
qp.query_plan AS [Query Plan]
FROM sys.dm_exec_query_stats AS qs WITH (NOLOCK)
CROSS APPLY sys.dm_exec_sql_text(plan_handle) AS t 
CROSS APPLY sys.dm_exec_query_plan(plan_handle) AS qp 
WHERE --CAST(qp.query_plan AS NVARCHAR(MAX)) LIKE ('%CONVERT_IMPLICIT%') AND 
t.[dbid] = DB_ID()
ORDER BY qs.execution_count DESC OPTION (RECOMPILE);

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT  [ProcedureName]          =   OBJECT_NAME([ps].[object_id], [ps].[database_id]) 
		   ,[ProcedureExecutes]      =   [ps].[execution_count] 
		   ,[VersionOfPlan]          =   [qs].[plan_generation_num]
		   ,[ExecutionsOfCurrentPlan]    =   [qs].[execution_count] 
		   ,[Query Plan XML]         =   [qp].[query_plan]  

	FROM		[sys].[dm_exec_procedure_stats] AS [ps]
				JOIN [sys].[dm_exec_query_stats] AS [qs] ON [ps].[plan_handle] = [qs].[plan_handle]
				CROSS APPLY [sys].[dm_exec_query_plan]([qs].[plan_handle]) AS [qp]
	WHERE   [ps].[database_id] = DB_ID() and
			CAST(qp.query_plan AS NVARCHAR(MAX)) LIKE ('%CONVERT_IMPLICIT%')
       --AND  OBJECT_NAME([ps].[object_id], [ps].[database_id])  = 'TEST'
	   order by 2 desc

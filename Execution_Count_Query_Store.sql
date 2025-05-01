declare @results_row_count int = 10 
declare @interval_end_time datetime = getdate()
declare @interval_start_time datetime = getdate()-1

SELECT TOP (@results_row_count)
    p.query_id query_id,
    q.object_id object_id,
    ISNULL(OBJECT_NAME(q.object_id),'''') object_name,
    qt.query_sql_text query_sql_text,
    SUM(rs.count_executions) count_executions,
    COUNT(distinct p.plan_id) num_plans
FROM sys.query_store_runtime_stats rs
    JOIN sys.query_store_plan p ON p.plan_id = rs.plan_id
    JOIN sys.query_store_query q ON q.query_id = p.query_id
    JOIN sys.query_store_query_text qt ON q.query_text_id = qt.query_text_id
WHERE NOT (rs.first_execution_time > @interval_end_time OR rs.last_execution_time < @interval_start_time)
GROUP BY p.query_id, qt.query_sql_text, q.object_id
HAVING COUNT(distinct p.plan_id) >= 1
ORDER BY count_executions DESC
--',N'@results_row_count int,@interval_start_time datetimeoffset(7),@interval_end_time datetimeoffset(7)',@results_row_count=25,@interval_start_time='2024-10-14 19:18:50.8874875 +05:30',@interval_end_time='2024-10-15 19:18:50.8874875 +05:30'
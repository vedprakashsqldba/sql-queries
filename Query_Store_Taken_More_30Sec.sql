DECLARE @start_time_utc DATETIME = '2024-09-04T11:30:00';
DECLARE @end_time_utc DATETIME = '2024-09-04T14:30:00';

SELECT 
    qsq.query_id,
    qsqt.query_sql_text,
    qsrs.plan_id,
    qsrs.execution_type_desc,
    qsrs.first_execution_time AS start_time,
    qsrs.last_execution_time AS end_time,
    qsrs.avg_duration / 1000.0 AS AvgDurationSeconds,
    qsrs.max_duration / 1000.0 AS MaxDurationSeconds,
    qsrs.count_executions AS execution_count
FROM 
    sys.query_store_runtime_stats qsrs
JOIN 
    sys.query_store_plan qsp ON qsrs.plan_id = qsp.plan_id
JOIN 
    sys.query_store_query qsq ON qsp.query_id = qsq.query_id
JOIN 
    sys.query_store_query_text qsqt ON qsq.query_text_id = qsqt.query_text_id
WHERE 
    qsrs.first_execution_time >= @start_time_utc
    AND qsrs.last_execution_time <= @end_time_utc
    AND (qsrs.avg_duration / 1000.0) > 30 -- duration in seconds
ORDER BY 
    qsrs.max_duration DESC;

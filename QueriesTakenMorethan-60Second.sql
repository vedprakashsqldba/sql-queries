WITH FilteredRuntimeStats AS (
    SELECT
        qsqt.query_sql_text,
        qsp.plan_id,
        qsrs.runtime_stats_id,
        qsrs.execution_type_desc,
        qsrs.avg_duration / 1000.0 AS avg_duration_seconds,
        qsrs.last_execution_time,
        ROW_NUMBER() OVER (PARTITION BY qsqt.query_sql_text ORDER BY qsrs.avg_duration DESC) AS rn
    FROM
        sys.query_store_runtime_stats qsrs
    JOIN
        sys.query_store_runtime_stats_interval qsi
        ON qsrs.runtime_stats_interval_id = qsi.runtime_stats_interval_id
    JOIN
        sys.query_store_plan qsp
        ON qsrs.plan_id = qsp.plan_id
    JOIN
        sys.query_store_query qsq
        ON qsp.query_id = qsq.query_id
    JOIN
        sys.query_store_query_text qsqt
        ON qsq.query_text_id = qsqt.query_text_id
    WHERE
        qsrs.avg_duration > 60000000 -- 60 seconds in microseconds
        AND qsrs.last_execution_time >= DATEADD(DAY, -3, GETUTCDATE()) -- Last 3 days
)
SELECT
    query_sql_text,
    plan_id,
    runtime_stats_id,
    execution_type_desc,
    avg_duration_seconds,
    last_execution_time
FROM
    FilteredRuntimeStats
WHERE
    rn = 1
ORDER BY
    avg_duration_seconds DESC;



--------------------------------------------------------------------------------------------------------

WITH FilteredRuntimeStats AS (
    SELECT
        qsqt.query_sql_text,
        qsp.plan_id,
        qsrs.runtime_stats_id,
        qsrs.execution_type_desc,
        qsrs.avg_duration / 1000.0 AS avg_duration_seconds,
        qsrs.last_execution_time,
        qsq.object_id,
        ROW_NUMBER() OVER (PARTITION BY qsqt.query_sql_text ORDER BY qsrs.avg_duration DESC) AS rn
    FROM
        sys.query_store_runtime_stats qsrs
    JOIN
        sys.query_store_runtime_stats_interval qsi
        ON qsrs.runtime_stats_interval_id = qsi.runtime_stats_interval_id
    JOIN
        sys.query_store_plan qsp
        ON qsrs.plan_id = qsp.plan_id
    JOIN
        sys.query_store_query qsq
        ON qsp.query_id = qsq.query_id
    JOIN
        sys.query_store_query_text qsqt
        ON qsq.query_text_id = qsqt.query_text_id
    WHERE
        qsrs.avg_duration > 60000000 -- 60 seconds in microseconds
        AND qsrs.last_execution_time >= DATEADD(DAY, -1, GETUTCDATE()) -- Last 3 days
),
DetailedStats AS (
    SELECT
        frs.query_sql_text,
        frs.plan_id,
        frs.runtime_stats_id,
        frs.execution_type_desc,
        frs.avg_duration_seconds,
        frs.last_execution_time,
        frs.object_id,
        ISNULL(so.type_desc, 'AdHoc') AS object_type_desc, -- Get the object type
        frs.rn
    FROM
        FilteredRuntimeStats frs
    LEFT JOIN
        sys.objects so
        ON frs.object_id = so.object_id
)
SELECT
    query_sql_text,
    plan_id,
    runtime_stats_id,
    execution_type_desc,
    avg_duration_seconds,
    last_execution_time,
    object_id,
    object_type_desc -- Include the object type in the final output

FROM
    DetailedStats
WHERE
    rn = 1
ORDER BY
    avg_duration_seconds DESC;


	--select * from sys.objects where object_id=1378103950
SELECT 
    qsq.query_id,
    qsq.last_execution_time,
    qsqt.query_sql_text
FROM sys.query_store_query qsq
    INNER JOIN sys.query_store_query_text qsqt
        ON qsq.query_text_id = qsqt.query_text_id
WHERE
 --qsq.query_id=2580786;
	 qsqt.query_sql_text LIKE '%policy_pricing_history_pointers%'
	 and qsqt.query_sql_text LIKE '%drop%'
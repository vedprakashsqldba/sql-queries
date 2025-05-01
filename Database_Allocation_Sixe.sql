SELECT
    [database_name],
    start_time AS 'LastCollectionTime',
    storage_in_megabytes AS 'CurrentSize(MBs)',
    allocated_storage_in_megabytes AS 'AllocatedStorage(MBs)',
	ROUND(storage_in_megabytes * 100.0 / allocated_storage_in_megabytes, 1) AS Percents
  FROM (
            SELECT
                ROW_NUMBER() OVER(PARTITION BY [database_name] ORDER BY start_time DESC) AS rn,
                [database_name],
                start_time,
                storage_in_megabytes,
                allocated_storage_in_megabytes
            FROM sys.resource_stats
			--where  database_name='omspreprod_logdb'
        ) rs
WHERE rn = 1
order by 5 desc


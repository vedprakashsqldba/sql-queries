 -- Object Sizes 
 select 
 schema_name(sys.objects.schema_id) +'.' + sys.objects.name as ObjectName, 
 sum(reserved_page_count) * 8.0 / 1024 as ObjectSizeMB
from sys.dm_db_partition_stats, sys.objects
where sys.dm_db_partition_stats.object_id = sys.objects.object_id and 
schema_name(sys.objects.schema_id) <> 'sys'
group by schema_name(sys.objects.schema_id) +'.' + sys.objects.name
order by 2 desc


--ElasticPool - Detail (master)
select top 10 replace(elastic_pool_name,'MaximEyesProdvCore','') , 
max(avg_instance_memory_percent) avg_instance_memory_percent, 
max(elastic_pool_cpu_limit) elastic_pool_cpu_limit, 
max(elastic_pool_cpu_limit) * 5.1 as  elastic_pool_Memory_limit_GB,
SUM(CASE WHEN avg_instance_memory_percent = 100 THEN 1 ELSE 0 END) AS count_100_percent_memory
, max(avg_instance_cpu_percent) avg_instance_cpu_percent,  SUM(CASE WHEN avg_instance_cpu_percent = 100 THEN 1 ELSE 0 END) AS count_100_percent_cpu,
max(avg_allocated_storage_percent) avg_allocated_storage_percent, SUM(CASE WHEN avg_allocated_storage_percent = 100 THEN 1 ELSE 0 END) AS count_100_percent_storage
from sys.elastic_pool_resource_stats
where 
start_time >  dateadd(minute,-60,current_timestamp) -- '2024-01-11 16:10:15.8466667' 
--and end_time < '2024-01-12 2:00:15.8466667'
group by elastic_pool_name

-- Memory Usage by elastic pool (Master)
select top 200 avg_instance_memory_percent,  
* from sys.elastic_pool_resource_stats 
where elastic_pool_name = 'omsnonproddbpool' order by start_time desc


select top 10 peak_job_memory_used_mb, 
peak_process_memory_used_mb/1024 PeakProcessMemoryUsedGB  , process_memory_limit_mb ,
memory_limit_mb/1024 MemoryLimitGB, * from sys.dm_os_job_object

-- BufferSizeInMB
SELECT
  database_id AS DatabaseID,
  DB_NAME(database_id) AS DatabaseName,
  COUNT(file_id) * 8/1024.0 AS BufferSizeInMB
FROM sys.dm_os_buffer_descriptors
GROUP BY DB_NAME(database_id),database_id
ORDER BY BufferSizeInMB DESC
GO 

--memory-optimized tables
SELECT object_name(object_id) AS Name  
     , *  
   FROM sys.dm_db_xtp_table_memory_stats  

   SELECT memory_consumer_desc  
     , allocated_bytes/1024 AS allocated_bytes_kb  
     , used_bytes/1024 AS used_bytes_kb  
     , allocation_count  
   FROM sys.dm_xtp_system_memory_consumers  

   SELECT memory_object_address  
     , pages_in_bytes  
     , bytes_used  
     , type  
   FROM sys.dm_os_memory_objects



  
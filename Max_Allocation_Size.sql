select Db_Names,	type_desc,	sum(space_used_mb)/1024 as space_used_Gb,	sum(space_unused_mb)/1024 as space_unused_gb ,	sum(space_allocated_mb)/1024 as space_allocated_gb ,	
sum(max_size_mb)/1024 as max_size_Gb, (sum(space_used_mb)/1024) / (sum(max_size_mb)/1024) * 100 as 'percentage'
from 
(
SELECT db_name() Db_Names, type_desc,      CAST(FILEPROPERTY(name, 'SpaceUsed') AS decimal(19,4)) * 8 / 1024. AS space_used_mb,       
CAST(size/128.0 - CAST(FILEPROPERTY(name, 'SpaceUsed') AS int)/128.0 AS decimal(19,4)) AS space_unused_mb,
CAST(size AS decimal(19,4)) * 8 / 1024. AS space_allocated_mb, CAST(max_size AS decimal(19,4)) * 8 / 1024. AS max_size_mb 
FROM sys.database_files where type_desc='ROWS'
) as Db_Size
group by Db_Names,type_desc



space_used_Gb	space_unused_gb	space_allocated_gb	max_size_Gb	percentage
0.310974121	0.064025	0.375000000	30.000000000	1.036500


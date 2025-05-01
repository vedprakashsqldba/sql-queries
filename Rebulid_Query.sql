DROP TABLE IF EXISTS #frag
--drop table #frag
DECLARE @IndexName VARCHAR(128)
DECLARE @SQL VARCHAR(1024)

SELECT
OBJECT_NAME(ips.OBJECT_ID) table_name
,i.NAME
,ips.index_id
,index_type_desc
,avg_fragmentation_in_percent
,avg_page_space_used_in_percent
,page_count
into #frag  FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'SAMPLED') ips
			INNER JOIN sys.indexes i ON (ips.object_id = i.object_id)
			AND (ips.index_id = i.index_id)
			where avg_fragmentation_in_percent > 30

IF EXISTS  (select name from #frag where avg_fragmentation_in_percent > 30 )
Begin 
	SELECT @IndexName = ( select top 1 name from #frag where avg_fragmentation_in_percent >= 30	)
	WHILE @IndexName is not null

	BEGIN

	select top 1 @SQL='ALTER INDEX '+name+' ON '+table_name+' REBUILD WITH (ONLINE = ON); '
    from #frag
	
	--Print (@SQL)
	EXEC (@SQL)
	
	delete from #frag where name=@IndexName
	

		SELECT @IndexName = 
			(
			select top 1 name from #frag 
			)
	END
End

ELSE

Begin 
SELECT @IndexName = 
			(
			select top 1 name from #frag where avg_fragmentation_in_percent < 30
			)

WHILE @IndexName is not null

BEGIN

	select top 1 @SQL='ALTER INDEX '+name+' ON '+table_name+' REORGANIZE; '
    from #frag

     --Print (@SQL)
	 EXEC (@SQL)
	
	delete from #frag where name=@IndexName

SELECT @IndexName = 
			(
			select top 1 name from #frag where avg_fragmentation_in_percent < 30
			)

END
End



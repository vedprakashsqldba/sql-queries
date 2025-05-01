DECLARE @DatabaseName NVARCHAR(128) = DB_NAME();  -- Get the current database name
DECLARE @FragmentationThreshold INT = 30;  -- Set the threshold for fragmentation (in percentage)
DECLARE @ReorganizeThreshold INT = 10;  -- Set the threshold for reorganizing (in percentage)

-- Declare variables for looping through indexes
DECLARE @TableName NVARCHAR(128);
DECLARE @IndexName NVARCHAR(128);
DECLARE @FragmentationPercentage FLOAT;

-- Cursor to loop through indexes
DECLARE index_cursor CURSOR FOR
SELECT 
    OBJECT_NAME(i.object_id) AS TableName, 
    i.name AS IndexName, 
    ips.avg_fragmentation_in_percent
FROM 
    sys.indexes i
JOIN 
    sys.dm_db_index_physical_stats(NULL, NULL, NULL, NULL, 'DETAILED') ips
    ON i.object_id = ips.object_id
    AND i.index_id = ips.index_id
WHERE 
    i.type IN (1, 2)  -- Clustered and Nonclustered indexes
    AND ips.avg_fragmentation_in_percent > 0;  -- Only consider fragmented indexes

OPEN index_cursor;
FETCH NEXT FROM index_cursor INTO @TableName, @IndexName, @FragmentationPercentage;

-- Loop through each index to determine action
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Alert about fragmentation
    PRINT 'Fragmentation detected on Index: ' + @IndexName + ' in Table: ' + @TableName + 
          ' with fragmentation: ' + CAST(@FragmentationPercentage AS NVARCHAR(10)) + '%';

    -- Reorganize or Rebuild based on fragmentation level
    IF @FragmentationPercentage BETWEEN @ReorganizeThreshold AND @FragmentationThreshold
    BEGIN
        -- Reorganize the index
        PRINT 'Reorganizing Index: ' + @IndexName + ' in Table: ' + @TableName;
        EXEC('ALTER INDEX [' + @IndexName + '] ON [' + @TableName + '] REORGANIZE');
    END
    ELSE IF @FragmentationPercentage > @FragmentationThreshold
    BEGIN
        -- Rebuild the index
        PRINT 'Rebuilding Index: ' + @IndexName + ' in Table: ' + @TableName;
        EXEC('ALTER INDEX [' + @IndexName + '] ON [' + @TableName + '] REBUILD');
    END

    -- Fetch the next index
    FETCH NEXT FROM index_cursor INTO @TableName, @IndexName, @FragmentationPercentage;
END;

-- Clean up cursor
CLOSE index_cursor;
DEALLOCATE index_cursor;

PRINT 'Index maintenance completed.';

-- Index Defragmentation Script - Process One Index at a Time
-- This script rebuilds or reorganizes indexes based on fragmentation level
-- and processes them one by one to minimize locking impact

SET NOCOUNT ON;

DECLARE @DatabaseName NVARCHAR(128) = DB_NAME(); -- Current database
DECLARE @FragmentationThreshold_Reorganize FLOAT = 10.0; -- Reorganize if fragmentation > 10%
DECLARE @FragmentationThreshold_Rebuild FLOAT = 30.0;    -- Rebuild if fragmentation > 30%
DECLARE @MinPageCount INT = 1000; -- Only process indexes with more than 1000 pages
DECLARE @DelayBetweenIndexes INT = 2; -- Delay in seconds between index operations

-- Variables for cursor
DECLARE @SchemaName NVARCHAR(128);
DECLARE @TableName NVARCHAR(128);
DECLARE @IndexName NVARCHAR(128);
DECLARE @FragmentationPercent FLOAT;
DECLARE @PageCount BIGINT;
DECLARE @SQL NVARCHAR(MAX);
DECLARE @Operation NVARCHAR(20);
DECLARE @StartTime DATETIME2;
DECLARE @EndTime DATETIME2;
DECLARE @Duration NVARCHAR(20);

-- Create temporary table to store index information
CREATE TABLE #IndexFragmentation (
    SchemaName NVARCHAR(128),
    TableName NVARCHAR(128),
    IndexName NVARCHAR(128),
    FragmentationPercent FLOAT,
    PageCount BIGINT,
    ProcessOrder INT IDENTITY(1,1)
);

PRINT '=== Index Defragmentation Script Started ===';
PRINT 'Database: ' + @DatabaseName;
PRINT 'Started at: ' + CONVERT(NVARCHAR(30), GETDATE(), 120);
PRINT 'Reorganization threshold: ' + CAST(@FragmentationThreshold_Reorganize AS NVARCHAR(10)) + '%';
PRINT 'Rebuild threshold: ' + CAST(@FragmentationThreshold_Rebuild AS NVARCHAR(10)) + '%';
PRINT 'Minimum page count: ' + CAST(@MinPageCount AS NVARCHAR(10));
PRINT '';

-- Get fragmentation information for all indexes
INSERT INTO #IndexFragmentation (SchemaName, TableName, IndexName, FragmentationPercent, PageCount)
SELECT 
    s.name AS SchemaName,
    t.name AS TableName,
    i.name AS IndexName,
    ips.avg_fragmentation_in_percent AS FragmentationPercent,
    ips.page_count AS PageCount
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') ips
INNER JOIN sys.indexes i ON ips.object_id = i.object_id AND ips.index_id = i.index_id
INNER JOIN sys.tables t ON i.object_id = t.object_id
INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE ips.avg_fragmentation_in_percent > @FragmentationThreshold_Reorganize
    AND ips.page_count > @MinPageCount
    AND i.name IS NOT NULL -- Exclude heaps
    AND i.is_disabled = 0 -- Exclude disabled indexes
ORDER BY ips.avg_fragmentation_in_percent DESC;

-- Display summary of indexes to be processed
DECLARE @TotalIndexes INT;
SELECT @TotalIndexes = COUNT(*) FROM #IndexFragmentation;

PRINT 'Found ' + CAST(@TotalIndexes AS NVARCHAR(10)) + ' indexes requiring defragmentation.';
PRINT '';

IF @TotalIndexes = 0
BEGIN
    PRINT 'No indexes require defragmentation. Script completed.';
    DROP TABLE #IndexFragmentation;
    RETURN;
END

-- Create cursor to process indexes one by one
DECLARE index_cursor CURSOR FOR
SELECT SchemaName, TableName, IndexName, FragmentationPercent, PageCount
FROM #IndexFragmentation
ORDER BY ProcessOrder;

OPEN index_cursor;

FETCH NEXT FROM index_cursor INTO @SchemaName, @TableName, @IndexName, @FragmentationPercent, @PageCount;

DECLARE @ProcessedCount INT = 0;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @ProcessedCount = @ProcessedCount + 1;
    SET @StartTime = GETDATE();
    
    -- Determine operation based on fragmentation level
    IF @FragmentationPercent >= @FragmentationThreshold_Rebuild
    BEGIN
        SET @Operation = 'REBUILD';
        SET @SQL = 'ALTER INDEX [' + @IndexName + '] ON [' + @SchemaName + '].[' + @TableName + '] REBUILD WITH (ONLINE = ON, SORT_IN_TEMPDB = ON, MAXDOP = 1);';
    END
    ELSE
    BEGIN
        SET @Operation = 'REORGANIZE';
        SET @SQL = 'ALTER INDEX [' + @IndexName + '] ON [' + @SchemaName + '].[' + @TableName + '] REORGANIZE;';
    END
    
    -- Display current operation
    PRINT '[' + CAST(@ProcessedCount AS NVARCHAR(10)) + '/' + CAST(@TotalIndexes AS NVARCHAR(10)) + '] ' + 
          @Operation + ' - ' + @SchemaName + '.' + @TableName + '.' + @IndexName;
    PRINT 'Fragmentation: ' + CAST(ROUND(@FragmentationPercent, 2) AS NVARCHAR(10)) + '%, Pages: ' + CAST(@PageCount AS NVARCHAR(20));
    
    BEGIN TRY
        -- Execute the defragmentation command
        EXEC sp_executesql @SQL;
        
        SET @EndTime = GETDATE();
        SET @Duration = CAST(DATEDIFF(SECOND, @StartTime, @EndTime) AS NVARCHAR(10)) + ' seconds';
        
        PRINT 'Completed in: ' + @Duration;
        PRINT 'Status: SUCCESS';
        
    END TRY
    BEGIN CATCH
        SET @EndTime = GETDATE();
        PRINT 'Status: ERROR - ' + ERROR_MESSAGE();
        
        -- Log error but continue with next index
        PRINT 'Continuing with next index...';
    END CATCH
    
    PRINT ''; -- Empty line for readability
    
    -- Add delay between operations to reduce system impact
    IF @DelayBetweenIndexes > 0 AND @ProcessedCount < @TotalIndexes
    BEGIN
        PRINT 'Waiting ' + CAST(@DelayBetweenIndexes AS NVARCHAR(5)) + ' seconds before next operation...';
        WAITFOR DELAY @DelayBetweenIndexes;
        PRINT '';
    END
    
    FETCH NEXT FROM index_cursor INTO @SchemaName, @TableName, @IndexName, @FragmentationPercent, @PageCount;
END

CLOSE index_cursor;
DEALLOCATE index_cursor;

-- Cleanup
DROP TABLE #IndexFragmentation;

PRINT '=== Index Defragmentation Script Completed ===';
PRINT 'Total indexes processed: ' + CAST(@ProcessedCount AS NVARCHAR(10));
PRINT 'Completed at: ' + CONVERT(NVARCHAR(30), GETDATE(), 120);

-- Optional: Update statistics for processed tables
PRINT '';
PRINT 'Updating statistics for all tables...';
EXEC sp_updatestats;
PRINT 'Statistics update completed.';
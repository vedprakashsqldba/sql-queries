

DECLARE @BatchSize INT = 1000; -- Define batch size
DECLARE @RowCount INT = 1;    -- Variable to track how many rows are affected

-- Loop until no more rows are affected
WHILE @RowCount > 0
BEGIN
    -- Delete top 100 records
    DELETE TOP (@BatchSize) FROM app_transaction_steps_log 
    WHERE licensee_code ='OMAHA';  -- Add condition here if needed

    -- Check how many rows were deleted
    SET @RowCount = @@ROWCOUNT;

    -- Optionally print the number of deleted records in each batch
    PRINT CAST(@RowCount AS VARCHAR(10)) + ' rows deleted';
END;
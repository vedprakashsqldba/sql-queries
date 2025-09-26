-- ========================================
-- Drop All Stored Procedures with full schema and error handling
-- ========================================
DECLARE @schemaName NVARCHAR(255);
DECLARE @procName NVARCHAR(255);
DECLARE @dropProcSql NVARCHAR(MAX);

DECLARE proc_cursor CURSOR FOR
    SELECT s.name AS SchemaName, p.name AS ProcName
    FROM sys.procedures p
    JOIN sys.schemas s ON p.schema_id = s.schema_id
    WHERE p.is_ms_shipped = 0;

OPEN proc_cursor;
FETCH NEXT FROM proc_cursor INTO @schemaName, @procName;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @dropProcSql = 'DROP PROCEDURE [' + @schemaName + '].[' + @procName + '];';
    PRINT 'Dropping Stored Procedure: [' + @schemaName + '].[' + @procName + ']';

    BEGIN TRY
        EXEC sp_executesql @dropProcSql;
    END TRY
    BEGIN CATCH
        PRINT 'Error dropping procedure [' + @schemaName + '].[' + @procName + ']: ' + ERROR_MESSAGE();
    END CATCH;

    FETCH NEXT FROM proc_cursor INTO @schemaName, @procName;
END

CLOSE proc_cursor;
DEALLOCATE proc_cursor;


-- ========================================
-- Drop Certificate if it exists
-- ========================================
IF EXISTS (SELECT * FROM sys.certificates WHERE name = 'OMSPIICert')
BEGIN
    PRINT 'Dropping Certificate: OMSPIICert';
    DROP CERTIFICATE OMSPIICert;
END

-- ========================================
-- Drop All Users (excluding system/built-in users)
-- ========================================
DECLARE @userName NVARCHAR(255);
DECLARE dropUser CURSOR FOR
    SELECT name FROM sys.database_principals 
    WHERE type IN ('S', 'U', 'G')  -- SQL user, Windows user, Windows group
      AND name NOT IN ('dbo', 'guest', 'INFORMATION_SCHEMA', 'sys', 'db_owner', 'db_accessadmin', 'db_securityadmin', 'db_ddladmin', 'db_backupoperator', 'db_datareader', 'db_datawriter', 'db_denydatareader', 'db_denydatawriter');

OPEN dropUser;
FETCH NEXT FROM dropUser INTO @userName;

WHILE @@FETCH_STATUS = 0
BEGIN
    DECLARE @sqlUser NVARCHAR(MAX) = 'DROP USER [' + @userName + '];';
    PRINT 'Dropping User: ' + @userName;
    BEGIN TRY
        EXEC sp_executesql @sqlUser;
    END TRY
    BEGIN CATCH
        PRINT 'Error dropping user: ' + @userName + ' - ' + ERROR_MESSAGE();
    END CATCH;

    FETCH NEXT FROM dropUser INTO @userName;
END

CLOSE dropUser;
DEALLOCATE dropUser;

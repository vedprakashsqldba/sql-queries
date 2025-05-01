/****** Object:  DdlTrigger [trg_ddl_table_changes]    Script Date: 3/18/2025 10:52:03 AM ******/
DROP TRIGGER [trg_ddl_table_changes] ON DATABASE
GO

/****** Object:  DdlTrigger [trg_ddl_table_changes]    Script Date: 3/18/2025 10:52:03 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- Modify the existing trigger
CREATE TRIGGER [trg_ddl_table_changes]
ON DATABASE
FOR
    CREATE_TABLE,
    ALTER_TABLE,
    DROP_TABLE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @EventData XML = EVENTDATA(), @ip VARCHAR(32), @licensee_code varchar(30) ,@ReleaseVersion VARCHAR(50);
	SELECT @licensee_code = RIGHT(DB_NAME(), CHARINDEX('_', REVERSE(DB_NAME())) - 1);
    -- Get the IP address
    SELECT @ip = client_net_address
    FROM sys.dm_exec_connections
    WHERE session_id = @@SPID;

    -- Get the Release Version Number from your configuration table.  Adapt the code to reflect your 'licensee_code'
    SELECT @ReleaseVersion = variable_value
    FROM configuration
    WHERE licensee_code = @licensee_code  -- Replace with your actual licensee code
    AND variable = 'RELEASE_VERSION_NUMBER';

    -- Insert into dbo.zz_ddl_table_changes (assuming this is your target table)
    INSERT dbo.zz_ddl_table_changes
    (
        EventType,
        EventDDL,
        SchemaName,
        ObjectName,
        DatabaseName,
        HostName,
        IPAddress,
        ProgramName,
        LoginName,
        Release_Version_Number -- Add the column to the insert list
    )
    SELECT
        @EventData.value('(/EVENT_INSTANCE/EventType)[1]',   'NVARCHAR(100)'),
        @EventData.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'NVARCHAR(MAX)'),
        @EventData.value('(/EVENT_INSTANCE/SchemaName)[1]',  'NVARCHAR(255)'),
        @EventData.value('(/EVENT_INSTANCE/ObjectName)[1]',  'NVARCHAR(255)'),
        DB_NAME(), HOST_NAME(), @ip, PROGRAM_NAME(), SUSER_SNAME(),
        ISNULL(@ReleaseVersion, 'Unknown')  -- Use the @ReleaseVersion variable

    -- Ensure the added column is present in the SELECT statement
    -- and uses the @ReleaseVersion variable
END;
GO

ENABLE TRIGGER [trg_ddl_table_changes] ON DATABASE
GO



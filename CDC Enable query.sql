
--Step 1 for check CDC enable
SELECT name,
    object_id
FROM sys.triggers
WHERE parent_class_desc = 'DATABASE'
    AND is_disabled = 0;

	--Step 2 pass object id for find trigger
	SELECT OBJECT_DEFINITION(76683471) AS trigger_definition;

	Step 3 disable the find trigger name.
	DISABLE TRIGGER trg_ddl_table_changes ON DATABASE;

	Step 4 now enable CDC on DB with below mention command
	 EXEC sys.sp_cdc_enable_db;

	Step 5 now enable CDC on tables with below mention command
	  EXEC sys.sp_cdc_enable_table
    @source_schema = N'dbo',
    @source_name = N'account',
    @role_name = NULL;


	Step 6 now enable the trigger with below mention script 

	EnABLE TRIGGER trg_ddl_table_changes ON DATABASE;
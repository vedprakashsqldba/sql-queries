 declare @Target_Licensee varchar(100)  = '' --Set licensee code except 'base' which should be left after the cleanup
 declare  @error int  = 0
 if(@Target_Licensee = '')
 begin 
	 RAISERROR('Target licensee can not be blank',1,1)
	 set @error = 1
 end 

if( @error = 0 )
begin
 
	SET NOCOUNT ON;
 
	DECLARE @TableName varchar(200) ,@ExtendedPropertyValue varchar(200)
	declare @query varchar(max)

	PRINT '-------- DB Cleaup Start --------';

	DECLARE cleaup_cursor CURSOR FOR
	SELECT
	  -- SCHEMA_NAME(tbl.schema_id) AS SchemaName,	
	   tbl.name AS TableName, 
	  -- p.name AS ExtendedPropertyName,
	   cast(CAST(p.value AS sql_variant) as varchar(200)) AS ExtendedPropertyValue
	FROM
	   sys.tables AS tbl
	   INNER JOIN sys.extended_properties AS p ON p.major_id=tbl.object_id AND p.minor_id=0 AND p.class=1
	   where p.name = 'TABLE_CLASSIFICATION'
	   and tbl.name not in ( 'organizations_people' ,'next_unq_number','relationships_pointers')

	OPEN cleaup_cursor

	FETCH NEXT FROM cleaup_cursor
	INTO @TableName,@ExtendedPropertyValue

	--print 'Employee_ID  Employee_Name'

	WHILE @@FETCH_STATUS = 0
	BEGIN
 
		set @query = ''
		if ( @TableName= 'codes') begin alter table codes disable trigger tD_codes  end 

	
		if(@ExtendedPropertyValue = 'Transactional' )
			set @query  =  ' truncate table ' + CAST(@TableName as varchar(200)) 
		else if exists (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = @TableName and COLUMN_NAME = 'licensee_code ' )
		begin 
			set @query  =  ' delete from   ' + CAST(@TableName as varchar(200)) + ' where licensee_code not in (''base'', ''' + cast(@Target_Licensee as varchar(200))+''')'
		end 
		print 'executing query:' + @query
		SET NOCOUNT off;
		if  len(@query) > 0  begin  exec (@query) end 
		SET NOCOUNT on;
	 
		if ( @TableName= 'codes') begin alter table codes enable trigger tD_codes  end 


		FETCH NEXT FROM cleaup_cursor
	INTO @TableName,@ExtendedPropertyValue

	END
	CLOSE cleaup_cursor;
	DEALLOCATE cleaup_cursor;
end 
 
 
 delete from organizations_people where licensee_code not in ('base',@Target_Licensee) 
 delete from next_unq_number where licensee_code not in ('base',@Target_Licensee) 
 delete from relationships_pointers where licensee_code not in ('base',@Target_Licensee)  

delete from organizations_people where organizations_people_uid not in (
select organizations_people_uid from  organizations_people where  isnull(login_id,'') <> '' union all
select organizations_people_uid from  organizations_people where  ( isnull(organization_type_code,'') in  ('carrier','licensee') or isnull(people_type_code,'') in ('carrier','licensee')))

delete from relationships_pointers where isnull(people_pointer_uid,'') not in (select organizations_people_uid from organizations_people )
delete from relationships_pointers where isnull(pointer_table_name,'')  <>  'ORGANIZATIONS_PEOPLE'

--Mark all login as inactive which were created in lower environment
update organizations_people set status = 'INACTIVE' where isnull(login_id,'') <> '' and isnull(login_id,'') not like 'admin_%'

declare @passHash as varchar(2000),@uid as varchar(50)
select @uid =organizations_people_uid ,  @passHash = password  from organizations_people where isnull(login_id,'')  like 'admin_%'
 
 insert into password_history
 values ('initialsetuprequiement',@Target_Licensee,@uid,@passHash,getdate()-365,'initial_setup',getdate()-365,'initial_setup')
-- Primary Server Master Database 
IF NOT EXISTS(SELECT principal_id FROM sys.sql_logins WHERE name = 'agkalangutkar') 
BEGIN
    /* Syntax for SQL server login.  See BOL for domain logins, etc. */
    CREATE LOGIN ragupta  WITH PASSWORD = 'Omsoneshild@1234'
END
--'S6o9SAQ9oinvsDKR',
Alter login os_tvnivaskar disable;

---- Go to the specific database name 

CREATE USER 'agkalangutkar' FOR LOGIN 'agkalangutkar' WITH DEFAULT_SCHEMA = dbo; 
EXEC sp_addrolemember 'db_datareader',	'agkalangutkar';


-- Run the script on Primary Master server to copy the sid.

select 'create login',name,'with password=','''Omsoneshild@1234'',','sid=',sid,is_disabled,create_date from sys.sql_logins where name in ('ved')

-- Secondary Master Data 

create login with same sid 

SELECT  @@servername servername,db_name() dbname,DATABASEPROPERTYEX(DB_NAME(), 'Updateability') db_state,
--current_user as logged_in_user,
members.name as 'username', 
roles.name as 'roles_name',roles.type_desc as 'roles_desc',members.type_desc as 'members_desc'
FROM sys.database_role_members rolemem
INNER JOIN sys.database_principals roles
ON rolemem.role_principal_id = roles.principal_id
INNER JOIN sys.database_principals members
ON rolemem.member_principal_id = members.principal_id
where members.name like '%os_mnakoti'
ORDER BY members.name


ALTER LOGIN os_vghodekar WITH PASSWORD = 'OneShieldDbAccess$2024';
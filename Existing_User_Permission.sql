--Master
select * from sys.sql_logins where name like '%syadav%'

--Databases
CREATE USER agoswami 
FOR LOGIN agoswami 
WITH DEFAULT_SCHEMA = dbo; 

--Access 
EXEC sp_addrolemember 'db_datareader',		preprod_miec_app_user;
EXEC sp_addrolemember 'db_datawriter',		preprod_miec_app_user;
EXEC sp_addrolemember 'db_sp_exec',			agoswami;
EXEC sp_addrolemember 'db_securityadmin',	agoswami;

SELECT  @@servername servername,db_name() dbname,DATABASEPROPERTYEX(DB_NAME(), 'Updateability') db_state,
--current_user as logged_in_user,
members.name as 'username', 
roles.name as 'roles_name',roles.type_desc as 'roles_desc',members.type_desc as 'members_desc'
, members.*
FROM sys.database_role_members rolemem
INNER JOIN sys.database_principals roles
ON rolemem.role_principal_id = roles.principal_id
INNER JOIN sys.database_principals members
ON rolemem.member_principal_id = members.principal_id
--where members.name in  ('preprod_miec_app_user')
ORDER BY members.name



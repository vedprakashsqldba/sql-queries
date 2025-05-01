select  @@servername Servername	
,name  [Full Name]
,name [DB Username]	
,'' as Remark
,is_disabled

from sys.sql_logins where is_disabled=0


SELECT  @@servername servername,db_name() dbname,DATABASEPROPERTYEX(DB_NAME(), 'Updateability') db_state,
--current_user as logged_in_user,
members.name as 'username', 
roles.name as 'roles_name',roles.type_desc as 'roles_desc',members.type_desc as 'members_desc'
FROM sys.database_role_members rolemem
INNER JOIN sys.database_principals roles
ON rolemem.role_principal_id = roles.principal_id
INNER JOIN sys.database_principals members
ON rolemem.member_principal_id = members.principal_id
where members.name <> 'dbo'
ORDER BY members.name
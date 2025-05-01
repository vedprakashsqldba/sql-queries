SELECT DB_NAME() AS DatabaseName
,DatabasePrincipals.name AS PrincipalName
,DatabasePrincipals.type_desc AS PrincipalType
,DatabasePrincipals2.name AS GrantedBy
,DatabasePermissions.permission_name AS Permission
,DatabasePermissions.state_desc AS StateDescription
,SCHEMA_NAME(SO.schema_id) AS SchemaName
,SO.Name AS ObjectName
,SO.type_desc AS ObjectType
FROM sys.database_permissions DatabasePermissions LEFT JOIN sys.objects SO
ON DatabasePermissions.major_id = so.object_id LEFT JOIN sys.database_principals DatabasePrincipals
ON DatabasePermissions.grantee_principal_id = DatabasePrincipals.principal_id LEFT JOIN sys.database_principals DatabasePrincipals2
ON DatabasePermissions.grantor_principal_id = DatabasePrincipals2.principal_id
where DatabasePrincipals.principal_id > 4
--and so.name like 'audit_organizations_people%'
and DatabasePrincipals.name like 'cds_public'


SELECT  @@servername servername,db_name() dbname,DATABASEPROPERTYEX(DB_NAME(), 'Updateability') db_state,
--current_user as logged_in_user,
members.name as 'username', 
roles.name as 'roles_name',roles.type_desc as 'roles_desc',members.type_desc as 'members_desc'
FROM sys.database_role_members rolemem
INNER JOIN sys.database_principals roles
ON rolemem.role_principal_id = roles.principal_id
INNER JOIN sys.database_principals members
ON rolemem.member_principal_id = members.principal_id
where members.name like '%cds%'
ORDER BY members.name


SELECT DB_NAME() AS DatabaseName
,DatabasePrincipals.name AS PrincipalName
,DatabasePrincipals.type_desc AS PrincipalType
,DatabasePrincipals2.name AS GrantedBy
,DatabasePermissions.permission_name AS Permission
,DatabasePermissions.state_desc AS StateDescription
,SCHEMA_NAME(SO.schema_id) AS SchemaName
,SO.Name AS ObjectName
,SO.type_desc AS ObjectType
FROM sys.database_permissions DatabasePermissions LEFT JOIN sys.objects SO
ON DatabasePermissions.major_id = so.object_id LEFT JOIN sys.database_principals DatabasePrincipals
ON DatabasePermissions.grantee_principal_id = DatabasePrincipals.principal_id LEFT JOIN sys.database_principals DatabasePrincipals2
ON DatabasePermissions.grantor_principal_id = DatabasePrincipals2.principal_id
where DatabasePrincipals.principal_id > 4
--and so.name like 'audit_organizations_people%'
and DatabasePrincipals.name like 'cds_view'

-- Script out users and their roles
SELECT 'CREATE USER [' + dp.name + '] FOR LOGIN [' + dp.name + '];' as CreateUserScript
FROM sys.database_principals dp
WHERE dp.type IN ('S', 'E', 'X') -- S = SQL user, E = External user, X = External group
AND dp.principal_id > 1;

-- Script out role memberships for users
SELECT 'EXEC sp_addrolemember  ''' + dr.name + ''',''' + dp.name + + ''';'   as RoleMembershipScript
FROM sys.database_principals dp
JOIN sys.database_role_members drm ON dp.principal_id = drm.member_principal_id
JOIN sys.database_principals dr ON drm.role_principal_id = dr.principal_id
WHERE dp.type IN ('S', 'E', 'X');

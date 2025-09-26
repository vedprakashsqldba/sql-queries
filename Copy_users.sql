PRINT '-- USERS ------------------------------------'
SELECT 
    'CREATE USER [' + dp.name COLLATE DATABASE_DEFAULT + '] FROM EXTERNAL PROVIDER;' AS Script
FROM sys.database_principals dp
WHERE dp.type IN ('E','S','X','G')   -- External/SQL/Group
  AND dp.name NOT IN ('dbo','guest','sys','INFORMATION_SCHEMA')
  and dp.name = 'omsdeploy';

PRINT '-- ROLE MEMBERSHIPS --------------------------'
SELECT 
    'ALTER ROLE [' + dp2.name COLLATE DATABASE_DEFAULT + '] ADD MEMBER [' + dp1.name COLLATE DATABASE_DEFAULT + '];' AS Script
FROM sys.database_role_members drm
JOIN sys.database_principals dp1 ON drm.member_principal_id = dp1.principal_id
JOIN sys.database_principals dp2 ON drm.role_principal_id = dp2.principal_id
where dp1.name='omsdeploy';

PRINT '-- DATABASE-LEVEL PERMISSIONS ----------------'
SELECT 
    dp.state_desc COLLATE DATABASE_DEFAULT + ' ' + dp.permission_name COLLATE DATABASE_DEFAULT + 
    ' TO [' + dpr.name COLLATE DATABASE_DEFAULT + '];' AS Script
FROM sys.database_permissions dp
JOIN sys.database_principals dpr 
    ON dp.grantee_principal_id = dpr.principal_id
WHERE dp.class = 0  -- database-level
  AND dpr.name NOT IN ('dbo','guest','sys','INFORMATION_SCHEMA')
  and dpr.name = 'omsdeploy';

PRINT '-- OBJECT-LEVEL PERMISSIONS ------------------'
SELECT 
    dp.state_desc COLLATE DATABASE_DEFAULT + ' ' + dp.permission_name COLLATE DATABASE_DEFAULT + 
    ' ON ' + QUOTENAME(s.name COLLATE DATABASE_DEFAULT) + '.' + QUOTENAME(o.name COLLATE DATABASE_DEFAULT) + 
    ' TO [' + dpr.name COLLATE DATABASE_DEFAULT + '];' AS Script
FROM sys.database_permissions dp
JOIN sys.objects o ON dp.major_id = o.object_id
JOIN sys.schemas s ON o.schema_id = s.schema_id
JOIN sys.database_principals dpr ON dp.grantee_principal_id = dpr.principal_id
WHERE dpr.name NOT IN ('dbo','guest','sys','INFORMATION_SCHEMA')
and dpr.name = 'omsdeploy'
;

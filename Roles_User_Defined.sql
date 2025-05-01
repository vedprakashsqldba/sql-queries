-- Query to list all user-defined roles
SELECT name AS role_name, type_desc
FROM sys.database_principals
WHERE type = 'R' AND principal_id > 4; -- 'R' denotes database roles, and principal_id > 4 excludes system-defined roles

-- Query to count all user-defined roles
SELECT COUNT(*) AS user_defined_role_count
FROM sys.database_principals
WHERE type = 'R' AND principal_id > 4;

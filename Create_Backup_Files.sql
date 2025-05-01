DECLARE @commandcommand nvarchar(max) = ''
select @commandcommand +=N'
drop user '+ QUOTENAME(username) + N';'  
from (
SELECT distinct members.name as 'username'
FROM sys.database_role_members rolemem
INNER JOIN sys.database_principals roles
ON rolemem.role_principal_id = roles.principal_id
INNER JOIN sys.database_principals members
ON rolemem.member_principal_id = members.principal_id
--where members.name not in ('dbo','readonly','maintenance','omsdeploy','omsnonproddatafactoryapp')
where members.name not in ('dbo')
) t
ORDER BY username
exec  (@commandcommand);

DECLARE @sql1 NVARCHAR(MAX) = N'';
	SELECT @sql1 += N'
	DROP SYMMETRIC KEY ' + QUOTENAME(name) + N';'
	FROM sys.symmetric_keys
	WHERE symmetric_key_id > 101;
	EXEC sp_executesql @sql1;
	print 'Symmetric Keys Dropped.'
	PRINT ''	

/* Drop all non-system stored procs */
DECLARE @SPname VARCHAR(128)
DECLARE @SQL VARCHAR(254)
SELECT @SPname = (SELECT TOP 1 [name] FROM sysobjects WHERE [type] = 'P' AND category = 0 ORDER BY [name])
WHILE @SPname is not null
BEGIN
    SELECT @SQL = 'DROP PROCEDURE [dbo].[' + RTRIM(@SPname ) +']'
    EXEC (@SQL)
    PRINT 'Dropped Procedure: ' + @SPname
    SELECT @SPname = (SELECT TOP 1 [name] FROM sysobjects WHERE [type] = 'P' AND category = 0 AND [name] > @SPname ORDER BY [name])
END
GO

GO
/* Drop all functions */
DECLARE @FNname VARCHAR(128)
DECLARE @SQL VARCHAR(254)
SELECT @FNname = (SELECT TOP 1 [name] FROM sysobjects WHERE [type] IN (N'FN', N'IF', N'TF', N'FS', N'FT') AND category = 0 ORDER BY [name])
WHILE @FNname IS NOT NULL
BEGIN
    SELECT @SQL = 'DROP FUNCTION [dbo].[' + RTRIM(@FNname ) +']'
    EXEC (@SQL)
    PRINT 'Dropped Function: ' + @FNname
    SELECT @FNname = (SELECT TOP 1 [name] FROM sysobjects WHERE [type] IN (N'FN', N'IF', N'TF', N'FS', N'FT') AND category = 0 AND [name] > @FNname ORDER BY [name])
END
GO
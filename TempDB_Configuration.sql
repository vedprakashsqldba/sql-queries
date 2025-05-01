USE master;
GO

ALTER DATABASE tempdb REMOVE FILE temp2;
ALTER DATABASE tempdb REMOVE FILE temp3;
ALTER DATABASE tempdb REMOVE FILE temp4;
GO

DBCC SHRINKFILE (temp3, EMPTYFILE);
GO

-- Now try to remove the file again
USE master;
GO
ALTER DATABASE tempdb REMOVE FILE temp2;
GO
--
-- Enable server auditing - blob storage
--
 
-- Switch database
use master
GO
 
-- Create credential
CREATE CREDENTIAL [https://sqlvawa2warm56h33m.blob.core.windows.net/sc4asqlmi]
WITH IDENTITY='SHARED ACCESS SIGNATURE',
SECRET = 'sp=racwdli&st=2024-03-07T18:42:15Z&se=2024-03-15T02:42:15Z&spr=https&sv=2022-11-02&sr=c&sig=8lFOOI56S3Pg%2Fekj3DEWSYF0WdkUNGZmPNp923dpG4s%3D'
GO
 
-- Create server audit
CREATE SERVER AUDIT [Testing_SQLMI]
TO URL ( PATH ='https://sqlvawa2warm56h33m.blob.core.windows.net/sc4asqlmi' , RETENTION_DAYS = 0 )
GO
 
-- Create server specification
CREATE SERVER AUDIT SPECIFICATION [Testing_SQLMI]
FOR SERVER AUDIT [Testing_SQLMI]
    ADD (FAILED_LOGIN_GROUP),
    ADD (LOGOUT_GROUP),
    ADD (SUCCESSFUL_LOGIN_GROUP)
    WITH (STATE=ON);
GO
 
-- Set state on
ALTER SERVER AUDIT [Testing_SQLMI] WITH (STATE = ON);


--Read the log Files
select *
from sys.fn_get_audit_file('https://sqlvawa2warm56h33m.blob.core.windows.net/sc4asqlmi/free-sql-mi-1965055/master/Testing_SQLMI_NoRetention/2024-03-07/18_57_38_465_0.xel',null,null)
go


--
-- Enable database auditing - blob storage
--
 
-- Change to target database
USE [Testing_SQLMI];
GO
 
-- Create the database audit specification.
CREATE DATABASE AUDIT SPECIFICATION [Testing_SQLMI_DB]
FOR SERVER AUDIT [Testing_SQLMI]
ADD (SELECT, INSERT, UPDATE, DELETE ON Schema::DBO BY public)
WITH (STATE = ON);
GO


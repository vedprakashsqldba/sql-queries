
select 'DROP SYMMETRIC KEY ' +name from sys.symmetric_keys

DROP SYMMETRIC KEY ssnKey
DROP SYMMETRIC KEY birthDateKey
DROP SYMMETRIC KEY AccountNumberKey

-- Check if the certificate exists before attempting to delete
IF EXISTS (SELECT  name FROM sys.certificates WHERE name = 'OMSPIICert')
BEGIN
    -- Drop the certificate
    DROP CERTIFICATE OMSPIICert;
    PRINT 'Certificate deleted successfully';
END
ELSE
BEGIN
    PRINT 'Certificate does not exist';
END
GO

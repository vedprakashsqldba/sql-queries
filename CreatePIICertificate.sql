
IF NOT EXISTS (SELECT 1 FROM sys.certificates where name = 'OMSPIICert')
BEGIN
                CREATE CERTIFICATE OMSPIICert WITH SUBJECT = 'OMS PII Certificate'
END
GO

IF EXISTS(select 1 from sys.symmetric_keys skey where skey.name = 'ssnKey')
BEGIN
IF NOT EXISTS (select 1 from sys.symmetric_keys skey inner join sys.key_encryptions enc on enc.key_id = skey.symmetric_key_id and crypt_type_desc like '%CERTIFICATE%'
where skey.name = 'ssnKey')
BEGIN
				Open symmetric key ssnKey decryption BY password = 'A4dTyP@clear'
                Alter symmetric key ssnKey Add encryption by Certificate OMSPIICert
				Close symmetric key ssnKey
END
END
GO

--remove password based encryption
--IF EXISTS (select 1 from sys.symmetric_keys skey inner join sys.key_encryptions enc on enc.key_id = skey.symmetric_key_id and crypt_type_desc like '%PASSWORD%'
--where skey.name = 'ssnKey')
--BEGIN
--                Open symmetric key ssnKey decryption BY password = 'A4dTyP@clear' -- Certificate OMSPIICert
--				Alter symmetric key ssnKey drop encryption by password = 'A4dTyP@clear'
--				Close symmetric key ssnKey
--END
--GO
IF EXISTS(select 1 from sys.symmetric_keys skey where skey.name = 'birthDateKey')
BEGIN
IF NOT EXISTS (select 1 from sys.symmetric_keys skey inner join sys.key_encryptions enc on enc.key_id = skey.symmetric_key_id and crypt_type_desc like '%CERTIFICATE%'
where skey.name = 'birthDateKey')
BEGIN
				Open symmetric key birthDateKey decryption BY password = 'A4dTyP@clear'
                Alter symmetric key birthDateKey Add encryption by Certificate OMSPIICert
				Close symmetric key birthDateKey
END
END
GO

--remove password based encryption
--IF EXISTS (select 1 from sys.symmetric_keys skey inner join sys.key_encryptions enc on enc.key_id = skey.symmetric_key_id and crypt_type_desc like '%PASSWORD%'
--where skey.name = 'birthDateKey')
--BEGIN
--				Open symmetric key birthDateKey decryption BY password = 'A4dTyP@clear' --Certificate OMSPIICert
--                Alter symmetric key birthDateKey drop encryption by password = 'A4dTyP@clear'
--				Close symmetric key birthDateKey
--END
--GO

IF EXISTS(select 1 from sys.symmetric_keys skey where skey.name = 'AccountNumberKey')
BEGIN
IF NOT EXISTS (select 1 from sys.symmetric_keys skey inner join sys.key_encryptions enc on enc.key_id = skey.symmetric_key_id and crypt_type_desc like '%CERTIFICATE%'
where skey.name = 'AccountNumberKey')
BEGIN
				Open symmetric key AccountNumberKey decryption BY password = 'A4dTyP@clear'
                Alter symmetric key AccountNumberKey Add encryption by Certificate OMSPIICert
				Close symmetric key AccountNumberKey
END
END
GO


IF EXISTS ( SELECT 1 FROM CONFIGURATION  WHERE CONFIGURATION_uid = 'encryptionmethodkey' and licensee_code = 'BASE' and variable_value = 'password')
BEGIN 
  update CONFIGURATION set variable_value = 'certificate' where CONFIGURATION_uid = 'encryptionmethodkey' and licensee_code = 'BASE'
END
GO

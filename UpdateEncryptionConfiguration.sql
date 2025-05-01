IF EXISTS ( SELECT 1 FROM CONFIGURATION  WHERE CONFIGURATION_uid = 'encryptionmethodkey' and licensee_code = 'BASE' and variable_value = 'password')
BEGIN 
  update CONFIGURATION set variable_value = 'certificate' where CONFIGURATION_uid = 'encryptionmethodkey' and licensee_code = 'BASE'
END
GO
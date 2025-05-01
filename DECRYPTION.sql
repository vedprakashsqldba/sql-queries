OPEN SYMMETRIC KEY AccountNumberKey DECRYPTION BY certificate OMSPIICert 
SELECT CONVERT(varchar, DecryptByKey(account_number_encrypted)) ,account_number_encrypted, * from organization_payment_instruments 
where organization_payment_instruments_uid in ('cgvTGni0DEyaz9gWDdEJZQ71','A050747F*PL*EFT_F','z5ObA25kYk2OGx6thZB4rw03','A078146K*PL*EFT','V56VHs4ZUU2AusGo2Kvv0Q64') order  by add_date_time desc;
close SYMMETRIC KEY AccountNumberKey
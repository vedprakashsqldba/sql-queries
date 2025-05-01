SELECT
    c.name AS certificate_name,
    p.name AS principal_name,
    dp.permission_name,
    dp.state_desc
FROM
    sys.certificates c
JOIN
    sys.database_permissions dp
    ON c.certificate_id = dp.major_id
JOIN
    sys.database_principals p
    ON dp.grantee_principal_id = p.principal_id
WHERE
    dp.class_desc = 'CERTIFICATE'
ORDER BY
    c.name,
    p.name,
    dp.permission_name;


	--REVOKE Control
REVOKE CONTROL ON CERTIFICATE::OMSPIICert TO	aic_preprodapp_user;
REVOKE CONTROL ON SYMMETRIC KEY::AccountNumberKey TO  aic_preprodapp_user;
REVOKE CONTROL ON SYMMETRIC KEY::birthDateKey TO  aic_preprodapp_user;
REVOKE CONTROL ON SYMMETRIC KEY::ssnKey TO  aic_preprodapp_user;

	--Grant Control
GRANT CONTROL ON CERTIFICATE::OMSPIICert TO	aic_preprodapp_user;
GRANT CONTROL ON SYMMETRIC KEY::AccountNumberKey TO  aic_preprodapp_user;
GRANT CONTROL ON SYMMETRIC KEY::birthDateKey TO  aic_preprodapp_user;
GRANT CONTROL ON SYMMETRIC KEY::ssnKey TO  aic_preprodapp_user;


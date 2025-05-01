IF NOT EXISTS(SELECT * FROM sys.sql_logins WHERE name = 'tbarbee') 
BEGIN
    /* Syntax for SQL server login.  See BOL for domain logins, etc. */
    CREATE LOGIN egaonkar 
    WITH PASSWORD = '!UzjScu3HIL'
END

--select * from sys.sql_logins where name like ('%agkalangutkar%')

create user egaonkar from login egaonkar with default_schema=dbo;
go

ALTER role db_datawriter add member egaonkar;
go



SELECT  @@servername servername,db_name() dbname,DATABASEPROPERTYEX(DB_NAME(), 'Updateability') db_state,
--current_user as logged_in_user,
members.name as 'username', 
roles.name as 'roles_name',roles.type_desc as 'roles_desc',members.type_desc as 'members_desc'
-- Provide Permission 
--,'alter role '+ roles.name +' add member '+members.name+';'
FROM sys.database_role_members rolemem
INNER JOIN sys.database_principals roles
ON rolemem.role_principal_id = roles.principal_id
INNER JOIN sys.database_principals members
ON rolemem.member_principal_id = members.principal_id
where members.name in 
('cdavis')
ORDER BY members.name	 
  
--abaral	
--vkgupta	
select DATABASEPROPERTYEX(DB_NAME(), 'Updateability') db_state

--db_owner
--db_accessadmin
--db_securityadmin
--db_ddladmin
--db_backupoperator
--db_datareader
--db_datawriter
--db_denydatareader
--db_denydatawriter
--ALTER LOGIN prodftjconv WITH PASSWORD = 'tKdzPg1T75Fq0RwV';

grant execute on fn_Get_User_Timezone on smir ; 

GRANT EXECUTE ON GetLineOfBusiness TO smir;

create user bram from login bram with default_schema=dbo;
go


alter role db_datareader add member dbhardwaj;
alter role db_datawriter add member dbhardwaj;
go

upland_apoole


SELECT
    sk.name AS SymmetricKeyName,
    dp.permission_name AS Permission,
    USER_NAME(dp.grantee_principal_id) AS GranteeUserName,
    dp.state_desc AS PermissionState,dp.class_desc
	--,user_name(dp.grantor_principal_id) as GrantedBy
FROM sys.symmetric_keys sk
LEFT JOIN sys.database_permissions dp ON dp.major_id = sk.symmetric_key_id
WHERE sk.name IS NOT NULL and USER_NAME(dp.grantee_principal_id) like '%preprod%'

select * from sys.databases where name in 
(''omsucqa_upland''
,''omspreprod_upland''
,''omspreprod_logdb''
,''omsdev1_logdb''
,''omsucqa_logdb''
,''omsdev_logdb''
,''omsucdev'')


GRANT CONTROL ON CERTIFICATE	:: birthDateKey TO ved;
GRANT CONTROL ON SYMMETRIC KEY	:: birthDateKey TO ved;

select * from sys.sysusers  where name like ('%app%')


	
GRANT VIEW DEFINITION ON SYMMETRIC KEY::birthDateKey TO lawpro_app_user
--Grant Control
GRANT CONTROL ON CERTIFICATE::OMSPIICert TO lawpro_app_user


SELECT @@servername servername,db_name() dbname,perms.class_desc AS [Permission Class]
    ,perms.permission_name AS Permission
    ,type_desc AS [Principal Type]
    ,prin.name AS Principal,*
FROM sys.database_permissions AS perms
INNER JOIN sys.database_principals AS prin ON perms.grantee_principal_id = prin.principal_id
WHERE --permission_name IN ('ALTER','ALTER ANY USER') AND 
permission_name not IN ('CONNECT') AND 
--user_name(grantee_principal_id) NOT IN ('guest','public')
user_name(grantee_principal_id) IN ('omsdeploy')
    AND perms.class = 0
    AND [state] IN ('G','W')
    AND NOT (prin.type = 'S' AND prin.name = 'dbo' AND prin.authentication_type = 1 AND prin.owning_principal_id IS NULL)



 -- Role Permission 
SELECT DISTINCT pr.principal_id, pr.name, pr.type_desc, 
    pr.authentication_type_desc, pe.state_desc, pe.permission_name
FROM sys.database_principals AS pr
JOIN sys.database_permissions AS pe
    ON pe.grantee_principal_id = pr.principal_id
	WHERE pr.name IN ('Developer_omsdev1_IN');


alter login omsdeploy with password ='Bkpm66fYTDZGncfk'


GRANT VIEW DEFINITION ON SYMMETRIC KEY::AccountNumberKey TO aic_preprodapp_user;
GRANT CONTROL ON CERTIFICATE:: OMSPIICert                TO aic_preprodapp_user;


-- Full Access 
create user apparab from login apparab with default_schema=dbo;
exec sp_addrolemember db_datareader,apparab;
exec sp_addrolemember db_datawriter,apparab;
exec sp_addrolemember db_sp_exec,apparab;

-- Drop Access 
exec sp_droprolemember db_sp_exec,smvernekar;
exec sp_droprolemember db_datareader,smvernekar;
exec sp_droprolemember db_datawriter,smvernekar;






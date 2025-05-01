SELECT definition 
FROM sys.sql_modules 
WHERE definition like ('%licenseeCode nvarchar%')

set statistics time on 
declare @LicenseeCode NVARCHAR(20) = 'PRU'  
 ,@FormsInputUid NVARCHAR(50) = 'nwrubojzj32123903'  

exec  [dbo].[GetFormsInputXML]  @LicenseeCode,@FormsInputUid
set statistics time off
------------------------------------------------------------------------------------

set statistics time on 
declare @LicenseeCode VARCHAR(20) = 'PRU'  
 ,@FormsInputUid VARCHAR(50) = 'nwrubojzj32123903'  
 exec  [dbo].[GetFormsInputXML_VED]  @LicenseeCode,@FormsInputUid
set statistics time off
--------------------------------------------------------------------------------------

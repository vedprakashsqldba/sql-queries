SELECT @@SERVERNAME,name AS DatabaseName, create_date
FROM sys.databases
WHERE database_id > 4 -- Exclude system databases
AND create_date <= DATEADD(DAY, -21, GETDATE())
and name like ('%copy%')
ORDER BY create_date DESC;


version 2.49
maxbell 



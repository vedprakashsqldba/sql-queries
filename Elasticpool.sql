SELECT
       @@SERVERNAME as [ServerName],
       dso.elastic_pool_name,
       d.name as DatabaseName,
       dso.edition,
	   create_date
FROM
       sys.databases d inner join sys.database_service_objectives dso on d.database_id = dso.database_id
WHERE d.Name <> 'master'
and create_date < '2024-01-01'
ORDER BY
       d.name, dso.elastic_pool_name
	   
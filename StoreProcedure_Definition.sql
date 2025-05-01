select schema_name(obj.schema_id) as schema_name,
       obj.name as procedure_name,
       case type
            when 'P' then 'SQL Stored Procedure'
            when 'X' then 'Extended stored procedure'
        end as type,
        substring(par.parameters, 0, len(par.parameters)) as parameters,
        mod.definition
from sys.objects obj
join sys.sql_modules mod
     on mod.object_id = obj.object_id
cross apply (select p.name + ' ' + TYPE_NAME(p.user_type_id) + ', ' 
             from sys.parameters p
             where p.object_id = obj.object_id 
                   and p.parameter_id != 0 
             for xml path ('') ) par (parameters)
where obj.type in ('P', 'X','V')
and definition Like '%udf_getinsuredname%'
order by len(definition) desc
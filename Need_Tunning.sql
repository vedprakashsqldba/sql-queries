
SELECT organizations_people_UID  
 ,login_id  
 ,last_name  
 ,first_name  
 ,people_type_code  
 ,active_flag  
 ,pointer_table_uid  
 ,relationships_code  
 ,active_relationship_flag  
 ,organizations_people.licensee_code  
FROM dbo.organizations_people(NOLOCK)  
 ,dbo.relationships_pointers(NOLOCK)  
WHERE (  
  isnull(login_id, '') <> ''  
  AND isnull(active_flag, '') <> 'N'  
  AND (isnull(active_relationship_flag, '') <> 'N' OR relationships_pointers.expiration_date >=getdate())  
  AND organizations_people.licensee_code = relationships_pointers.licensee_code  
  AND people_pointer_uid = organizations_people_UID  
  AND pointer_table_name = 'ORGANIZATIONS_PEOPLE'  
  AND (  
   (  
    relationships_code = 'Employee'  
    AND (  
     pointer_table_uid IN (  
      SELECT entity_uid  
      FROM dbo.relationships_pointers(NOLOCK)  
      WHERE pointer_table_name = 'ORGANIZATIONS_PEOPLE'  
       AND relationships_code = 'PARTNER'  
       AND pointer_table_uid = licensee_code  
       AND (isnull(active_relationship_flag, '') <> 'N'  OR expiration_date >=getdate())  
      )  
     OR (  
      pointer_table_uid IN (  
       SELECT organizations_people_uid  
       FROM dbo.organizations_people(NOLOCK)  
       WHERE organization_type_code = 'BROKER'  
        AND isnull(active_flag, '') <> 'N'  
       )  
      )  
     OR (pointer_table_uid = relationships_pointers.licensee_code)  
     )  
    )  
   OR (  
    relationships_code = 'PARTNER'  
    AND pointer_table_uid = relationships_pointers.licensee_code  
    )  
   )  
  )  

  ---------------------------------
  
SELECT organizations_people_UID  
 ,login_id  
 ,last_name  
 ,first_name  
 ,people_type_code  
 ,active_flag  
 ,pointer_table_uid  
 ,relationships_code  
 ,active_relationship_flag  
 ,organ.licensee_code  
FROM dbo.organizations_people organ (NOLOCK) inner join 
 dbo.relationships_pointers relat(NOLOCK)  on 

organ.licensee_code			=  relat.licensee_code and 
organ.account_code			=  relat.account_code and 
organ.account_group_code	=  relat.account_group_code and
organ.organizations_people_uid =  relat.people_pointer_uid  

WHERE --login_id <> isnull('','')  
	login_id <> isnull('','') 
  AND active_flag <> isnull('N','')  
  AND active_relationship_flag <> isnull('N','') 
  OR relat.expiration_date >=getdate() 
  --AND organizations_people.licensee_code = relationships_pointers.licensee_code  
  --AND people_pointer_uid = organizations_people_UID  
  AND pointer_table_name = 'ORGANIZATIONS_PEOPLE'  
  AND (  
   (  
    relationships_code = 'Employee'  
    AND (  
     pointer_table_uid IN (  
      SELECT entity_uid  
      FROM dbo.relationships_pointers(NOLOCK)  
      WHERE pointer_table_name = 'ORGANIZATIONS_PEOPLE'  
       AND relationships_code = 'PARTNER'  
       AND pointer_table_uid = licensee_code  
       AND active_relationship_flag <> isnull('N','')  OR expiration_date >=getdate())  
      )  
     OR (  
      pointer_table_uid IN (  
       SELECT organizations_people_uid  
       FROM dbo.organizations_people(NOLOCK)  
       WHERE organization_type_code = 'BROKER'  
        AND active_flag <> isnull('N','')  
       )  
      )  
     OR (pointer_table_uid = relat.licensee_code)  
     )  
    )  
   OR (  
    relationships_code = 'PARTNER'  
    AND pointer_table_uid = relat.licensee_code  
    )  
   
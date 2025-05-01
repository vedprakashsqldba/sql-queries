set statistics io,time on 
SELECT
  *
FROM (SELECT TOP 91
  ROW_NUMBER() OVER (ORDER BY diary_date ASC) AS ROW_NUM,

  v_diary_uid,
  module_effective_date,
  diary_priority_Integer,
  module_name,
  pointer_table_number,
  due_date_text,
  file_note_description,
  people_name,
  diary_activity_code,

  diary_activity_desc,
  status,
  customer_name,
  pointer_table_name,
  file_note,
  diary_date,
  add_date_time,
  diary_priority_code,
  added_by,
  pointer_text_1,
  pointer_text_2,
  pointer_date_1
FROM v_diary
WHERE 1 = 1
AND (people_pointer_uid = 'spagnoloa'
OR workgroup_code IN (	SELECT
						workgroup_code
						FROM workgroup_pointers
						WHERE pointer_table_uid = 'spagnoloa'
						AND licensee_code = 'LAWPRO'
					 )
)
AND (status = 'Open' OR status = 'Requested')
AND v_diary_uid NOT IN 
	( SELECT
		filefolder_pointers_uid
FROM (
	SELECT
  ROW_NUMBER() OVER (PARTITION BY pointer_table_uid ORDER BY HasApprovedCurrentUser DESC, HasApprovedOtherUser ASC, sort_order)

  AS Row#,
  filefolder_pointers_uid,
  status,
  pointer_table_uid
FROM (SELECT
  c.sort_order,
  filefolder_pointers_uid,
  ff.pointer_table_uid,

  CASE
    WHEN ff.status IN ('Approved', 'Declined') AND
      ff.people_pointer_uid = 'spagnoloa' THEN 1
    ELSE 0
  END HasApprovedCurrentUser,
  CASE
    WHEN ff.status IN ('Approved', 'Declined') THEN 1
    ELSE 0
  END HasApprovedOtherUser,
  ff.status
FROM filefolder_pointers ff
LEFT OUTER JOIN Codes C
  ON C.code = workgroup_code
  AND c.licensee_code = ff.licensee_code
  AND group_code = 'WORKGROUP_CODE'
WHERE workgroup_code IN (SELECT
  workgroup_code
FROM workgroup_pointers
WHERE pointer_table_uid = 'spagnoloa'
AND licensee_code = 'LAWPRO')

AND diary_activity_code = 'Approval') t) k
WHERE Row# <> 1)
AND licensee_code = 'LAWPRO'
ORDER BY ROW_NUM) innerSelect
WHERE ROW_NUM > 0
set statistics io,time on 



set statistics io on 
SELECT
  *
FROM
  (
    select
      TOP 80 ROW_NUMBER() OVER (
        ORDER BY
          insured_name
      ) as ROW_NUM,
      policy_uid,
      billing_account_description,
      lso_number,
      file_number,
      effective_date,
      DueType,
      payer_uid,
      firm_name,
      payer_name,
      current_due,
      balance_to_pay_in_full
    FROM
      v_policy_claim_due_details
    where
      (
        DueType = 'PREMIUM'
        and firm_uid in ('A525390')
      )
      And licensee_code = 'LAWPRO'
    ORDER BY
      ROW_NUM
  ) innerSelect
WHERE
  ROW_NUM > 0


  -- select * from policy_accounting_details_pointers where licensee_code='LAWPRO'

policy_accounting_details_pointers_uid
licensee_code
add_date_time
added_by
alloc_amt
alloc_code
alloc_sub_code
change_date_time
changed_by
comm_due
comm_max
comm_pct
emp_comm_due
emp_comm_max
emp_comm_pct
org_broker_uid
org_carrier_uid
org_insured_uid
people_sales_uid
pointer_table_name
pointer_table_uid
policy_uid
qb_date
sales_comm_due
sales_comm_max
sales_comm_pct
alternate_pointer_table_name
alternate_pointer_table_uid
gl_posted
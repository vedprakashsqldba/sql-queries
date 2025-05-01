SET ANSI_PADDING ON
GO

/****** Object:  Index [idx7_policy_accounting_details_licensee_code_transaction_code]    Script Date: 6/26/2024 7:12:07 PM ******/
CREATE NONCLUSTERED INDEX [idx7_policy_accounting_details_licensee_code_transaction_code] ON [dbo].[policy_accounting_details]
(
	[licensee_code] ASC,
	[transaction_code] ASC
)
INCLUDE([pointer_table_uid],[transaction_amount],[billing_account_uid]) WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


SELECT   OBJECT_NAME(S.[OBJECT_ID]) AS [OBJECT NAME], 
         I.[NAME] AS [INDEX NAME], 
         USER_SEEKS, 
         USER_SCANS, 
         USER_LOOKUPS, 
         USER_UPDATES 
FROM     SYS.DM_DB_INDEX_USAGE_STATS AS S 
         INNER JOIN SYS.INDEXES AS I 
           ON I.[OBJECT_ID] = S.[OBJECT_ID] 
              AND I.INDEX_ID = S.INDEX_ID 
WHERE    OBJECTPROPERTY(S.[OBJECT_ID],'IsUserTable') = 1 
and I.name in 
(
'idx1_policy_accounting_details'
,'idx2_policy_accounting_details'
,'idx3_policy_accounting_details'
,'idx4_policy_accounting_details'
,'idx5_policy_accounting_details'
,'idx6_policy_accounting_details'
,'idx7_policy_accounting_details_licensee_code_transaction_code'
,'PK_policy_accounting_details'
) order by 3 desc

/****** Object:  Index [idx5_policy_accounting_details]    Script Date: 7/6/2024 1:07:20 AM ******/
DROP INDEX [idx7_transaction_code_transaction_code_sub_licensee_code_alternate_pointer_table_uid] ON [dbo].[policy_accounting_details]
GO

SET ANSI_PADDING ON
GO

/****** Object:  Index [idx5_policy_accounting_details]    Script Date: 7/6/2024 1:07:21 AM ******/
CREATE NONCLUSTERED INDEX [idx7_transaction_code_transaction_code_sub_licensee_code_alternate_pointer_table_uid] ON [dbo].[policy_accounting_details]
(
transaction_code			ASC,			
transaction_code_sub		ASC,			
licensee_code				ASC,		
alternate_pointer_table_uid ASC
)
INCLUDE(policy_accounting_details_uid) WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO



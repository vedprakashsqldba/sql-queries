DROP INDEX [ix_in_policy_accounting_details_licensee_code_transaction_code] ON [dbo].[policy_accounting_details]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ix_in_policy_accounting_details_licensee_code_transaction_code]    Script Date: 10/5/2023 6:19:07 PM ******/
CREATE NONCLUSTERED INDEX [ix_in_policy_accounting_details_licensee_code_transaction_code] ON [dbo].[policy_accounting_details]
(
[licensee_code] ASC,
[transaction_code] ASC
)
INCLUDE([pointer_table_uid],[transaction_amount],[billing_account_uid]) WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
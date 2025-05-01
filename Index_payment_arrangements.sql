/****** Object:  Index [Ix_In_Payment_Arrangements]    Script Date: 10/5/2023 6:54:02 PM ******/
DROP INDEX [Ix_In_Payment_Arrangements] ON [dbo].[payment_arrangements]
GO

SET ANSI_PADDING ON
GO

/****** Object:  Index [Ix_In_Payment_Arrangements]    Script Date: 10/5/2023 6:54:02 PM ******/
CREATE NONCLUSTERED INDEX [Ix_In_Payment_Arrangements] ON [dbo].[payment_arrangements]
(
	[licensee_code] ASC,
	[pointer_table_uid] ASC
)
INCLUDE([payer_uid],[pay_percentage]) WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO



/*
Missing Index Details from SQLQuery19.sql - omsnonproddb02.database.windows.net.omspreprod_lawpro (omsdbadmin (99))
The Query Processor estimates that implementing the following index could improve the query cost by 90.6574%.
*/

/*
USE [omspreprod_lawpro]
GO
CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>]
ON [dbo].[forms_input] ([pointer_table_uid])
INCLUDE ([text_6])
GO
*/

sp_spaceused forms_input

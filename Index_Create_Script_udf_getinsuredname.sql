/****** Object:  Index [IDX4_alternate_names_pointers]    Script Date: 5/28/2024 11:45:52 PM ******/
CREATE NONCLUSTERED INDEX [IDX5_alternate_names_pointers] ON [dbo].[alternate_names_pointers]
(
	pointer_table_uid ASC,
	alternate_name_code ASC,
	licensee_code ASC
)
include (alternate_name) ;
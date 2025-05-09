WITH CTE AS (
SELECT CAST(event_data AS XML) AS [target_data_XML]
FROM sys.fn_xe_telemetry_blob_target_read_file('dl', null, null, null)
)
SELECT target_data_XML.value('(/event/@timestamp)[1]', 'DateTime2') AS Timestamp,
target_data_XML.query('/event/data[@name=''xml_report'']/value/deadlock') AS
deadlock_xml,
target_data_XML.query('/event/data[@name=''database_name'']/value').value('(/value)[1]',
'nvarchar(100)') AS db_name,getdate()
FROM CTE
order by Timestamp desc
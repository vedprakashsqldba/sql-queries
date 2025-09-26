
SELECT
    job_type,
    retention AS retention_minutes
FROM cdc.cdc_jobs
WHERE job_type = 'cleanup';
GO
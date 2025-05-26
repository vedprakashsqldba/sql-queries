
SELECT 'audit_submissions' as Table_Name,
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2016 THEN 1 END) AS [Number of rows in Year_2016],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2017 THEN 1 END) AS [Number of rows in Year_2017],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2018 THEN 1 END) AS [Number of rows in Year_2018],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2019 THEN 1 END) AS [Number of rows in Year_2019],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2020 THEN 1 END) AS [Number of rows in Year_2020],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2021 THEN 1 END) AS [Number of rows in Year_2021],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2022 THEN 1 END) AS [Number of rows in Year_2022],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2023 THEN 1 END) AS [Number of rows in Year_2023],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2024 THEN 1 END) AS [Number of rows in Year_2024],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2025 THEN 1 END) AS [Number of rows in Year_2025]
FROM audit_submissions

Union All

SELECT 'audit_workflow_steps' as Table_Name,
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2016 THEN 1 END) AS [Number of rows in Year_2016],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2017 THEN 1 END) AS [Number of rows in Year_2017],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2018 THEN 1 END) AS [Number of rows in Year_2018],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2019 THEN 1 END) AS [Number of rows in Year_2019],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2020 THEN 1 END) AS [Number of rows in Year_2020],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2021 THEN 1 END) AS [Number of rows in Year_2021],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2022 THEN 1 END) AS [Number of rows in Year_2022],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2023 THEN 1 END) AS [Number of rows in Year_2023],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2024 THEN 1 END) AS [Number of rows in Year_2024],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2025 THEN 1 END) AS [Number of rows in Year_2025]
FROM audit_workflow_steps

Union All

SELECT 'audit_organizations_people' as Table_Name,
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2016 THEN 1 END) AS [Number of rows in Year_2016],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2017 THEN 1 END) AS [Number of rows in Year_2017],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2018 THEN 1 END) AS [Number of rows in Year_2018],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2019 THEN 1 END) AS [Number of rows in Year_2019],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2020 THEN 1 END) AS [Number of rows in Year_2020],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2021 THEN 1 END) AS [Number of rows in Year_2021],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2022 THEN 1 END) AS [Number of rows in Year_2022],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2023 THEN 1 END) AS [Number of rows in Year_2023],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2024 THEN 1 END) AS [Number of rows in Year_2024],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2025 THEN 1 END) AS [Number of rows in Year_2025]
FROM audit_organizations_people
Union All

SELECT 'audit_relationships_pointers' as Table_Name,
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2016 THEN 1 END) AS [Number of rows in Year_2016],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2017 THEN 1 END) AS [Number of rows in Year_2017],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2018 THEN 1 END) AS [Number of rows in Year_2018],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2019 THEN 1 END) AS [Number of rows in Year_2019],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2020 THEN 1 END) AS [Number of rows in Year_2020],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2021 THEN 1 END) AS [Number of rows in Year_2021],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2022 THEN 1 END) AS [Number of rows in Year_2022],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2023 THEN 1 END) AS [Number of rows in Year_2023],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2024 THEN 1 END) AS [Number of rows in Year_2024],
    COUNT(CASE WHEN YEAR(audit_add_date_time) = 2025 THEN 1 END) AS [Number of rows in Year_2025]
FROM audit_relationships_pointers

union all 

SELECT 'trace' as Table_Name,
    COUNT(CASE WHEN YEAR(add_date_time) = 2016 THEN 1 END) AS [Number of rows in Year_2016],
    COUNT(CASE WHEN YEAR(add_date_time) = 2017 THEN 1 END) AS [Number of rows in Year_2017],
    COUNT(CASE WHEN YEAR(add_date_time) = 2018 THEN 1 END) AS [Number of rows in Year_2018],
    COUNT(CASE WHEN YEAR(add_date_time) = 2019 THEN 1 END) AS [Number of rows in Year_2019],
    COUNT(CASE WHEN YEAR(add_date_time) = 2020 THEN 1 END) AS [Number of rows in Year_2020],
    COUNT(CASE WHEN YEAR(add_date_time) = 2021 THEN 1 END) AS [Number of rows in Year_2021],
    COUNT(CASE WHEN YEAR(add_date_time) = 2022 THEN 1 END) AS [Number of rows in Year_2022],
    COUNT(CASE WHEN YEAR(add_date_time) = 2023 THEN 1 END) AS [Number of rows in Year_2023],
    COUNT(CASE WHEN YEAR(add_date_time) = 2024 THEN 1 END) AS [Number of rows in Year_2024],
    COUNT(CASE WHEN YEAR(add_date_time) = 2025 THEN 1 END) AS [Number of rows in Year_2025]
FROM trace

union all 

SELECT 'thirdparty_requestresponse_logs' as Table_Name,
    COUNT(CASE WHEN YEAR(add_date_time) = 2016 THEN 1 END) AS [Number of rows in Year_2016],
    COUNT(CASE WHEN YEAR(add_date_time) = 2017 THEN 1 END) AS [Number of rows in Year_2017],
    COUNT(CASE WHEN YEAR(add_date_time) = 2018 THEN 1 END) AS [Number of rows in Year_2018],
    COUNT(CASE WHEN YEAR(add_date_time) = 2019 THEN 1 END) AS [Number of rows in Year_2019],
    COUNT(CASE WHEN YEAR(add_date_time) = 2020 THEN 1 END) AS [Number of rows in Year_2020],
    COUNT(CASE WHEN YEAR(add_date_time) = 2021 THEN 1 END) AS [Number of rows in Year_2021],
    COUNT(CASE WHEN YEAR(add_date_time) = 2022 THEN 1 END) AS [Number of rows in Year_2022],
    COUNT(CASE WHEN YEAR(add_date_time) = 2023 THEN 1 END) AS [Number of rows in Year_2023],
    COUNT(CASE WHEN YEAR(add_date_time) = 2024 THEN 1 END) AS [Number of rows in Year_2024],
    COUNT(CASE WHEN YEAR(add_date_time) = 2025 THEN 1 END) AS [Number of rows in Year_2025]
FROM thirdparty_requestresponse_logs



union all 

SELECT 'batch_log_detail' as Table_Name,
    COUNT(CASE WHEN YEAR(add_date_time) = 2016 THEN 1 END) AS [Number of rows in Year_2016],
    COUNT(CASE WHEN YEAR(add_date_time) = 2017 THEN 1 END) AS [Number of rows in Year_2017],
    COUNT(CASE WHEN YEAR(add_date_time) = 2018 THEN 1 END) AS [Number of rows in Year_2018],
    COUNT(CASE WHEN YEAR(add_date_time) = 2019 THEN 1 END) AS [Number of rows in Year_2019],
    COUNT(CASE WHEN YEAR(add_date_time) = 2020 THEN 1 END) AS [Number of rows in Year_2020],
    COUNT(CASE WHEN YEAR(add_date_time) = 2021 THEN 1 END) AS [Number of rows in Year_2021],
    COUNT(CASE WHEN YEAR(add_date_time) = 2022 THEN 1 END) AS [Number of rows in Year_2022],
    COUNT(CASE WHEN YEAR(add_date_time) = 2023 THEN 1 END) AS [Number of rows in Year_2023],
    COUNT(CASE WHEN YEAR(add_date_time) = 2024 THEN 1 END) AS [Number of rows in Year_2024],
    COUNT(CASE WHEN YEAR(add_date_time) = 2025 THEN 1 END) AS [Number of rows in Year_2025]
FROM batch_log_detail

union all 
----temp_forms_merge
SELECT 'temp_forms_merge' as Table_Name,
    COUNT(CASE WHEN YEAR(add_date_time) = 2016 THEN 1 END) AS [Number of rows in Year_2016],
    COUNT(CASE WHEN YEAR(add_date_time) = 2017 THEN 1 END) AS [Number of rows in Year_2017],
    COUNT(CASE WHEN YEAR(add_date_time) = 2018 THEN 1 END) AS [Number of rows in Year_2018],
    COUNT(CASE WHEN YEAR(add_date_time) = 2019 THEN 1 END) AS [Number of rows in Year_2019],
    COUNT(CASE WHEN YEAR(add_date_time) = 2020 THEN 1 END) AS [Number of rows in Year_2020],
    COUNT(CASE WHEN YEAR(add_date_time) = 2021 THEN 1 END) AS [Number of rows in Year_2021],
    COUNT(CASE WHEN YEAR(add_date_time) = 2022 THEN 1 END) AS [Number of rows in Year_2022],
    COUNT(CASE WHEN YEAR(add_date_time) = 2023 THEN 1 END) AS [Number of rows in Year_2023],
    COUNT(CASE WHEN YEAR(add_date_time) = 2024 THEN 1 END) AS [Number of rows in Year_2024],
    COUNT(CASE WHEN YEAR(add_date_time) = 2025 THEN 1 END) AS [Number of rows in Year_2025]
FROM temp_forms_merge

Union All 
--messages_logged
SELECT 'messages_logged' as Table_Name,
    COUNT(CASE WHEN YEAR(add_date_time) = 2016 THEN 1 END) AS [Number of rows in Year_2016],
    COUNT(CASE WHEN YEAR(add_date_time) = 2017 THEN 1 END) AS [Number of rows in Year_2017],
    COUNT(CASE WHEN YEAR(add_date_time) = 2018 THEN 1 END) AS [Number of rows in Year_2018],
    COUNT(CASE WHEN YEAR(add_date_time) = 2019 THEN 1 END) AS [Number of rows in Year_2019],
    COUNT(CASE WHEN YEAR(add_date_time) = 2020 THEN 1 END) AS [Number of rows in Year_2020],
    COUNT(CASE WHEN YEAR(add_date_time) = 2021 THEN 1 END) AS [Number of rows in Year_2021],
    COUNT(CASE WHEN YEAR(add_date_time) = 2022 THEN 1 END) AS [Number of rows in Year_2022],
    COUNT(CASE WHEN YEAR(add_date_time) = 2023 THEN 1 END) AS [Number of rows in Year_2023],
    COUNT(CASE WHEN YEAR(add_date_time) = 2024 THEN 1 END) AS [Number of rows in Year_2024],
    COUNT(CASE WHEN YEAR(add_date_time) = 2025 THEN 1 END) AS [Number of rows in Year_2025]
FROM messages_logged

Union All 
--temp_proposal_back
SELECT 'temp_proposal_back' as Table_Name,
    COUNT(CASE WHEN YEAR(add_date_time) = 2016 THEN 1 END) AS [Number of rows in Year_2016],
    COUNT(CASE WHEN YEAR(add_date_time) = 2017 THEN 1 END) AS [Number of rows in Year_2017],
    COUNT(CASE WHEN YEAR(add_date_time) = 2018 THEN 1 END) AS [Number of rows in Year_2018],
    COUNT(CASE WHEN YEAR(add_date_time) = 2019 THEN 1 END) AS [Number of rows in Year_2019],
    COUNT(CASE WHEN YEAR(add_date_time) = 2020 THEN 1 END) AS [Number of rows in Year_2020],
    COUNT(CASE WHEN YEAR(add_date_time) = 2021 THEN 1 END) AS [Number of rows in Year_2021],
    COUNT(CASE WHEN YEAR(add_date_time) = 2022 THEN 1 END) AS [Number of rows in Year_2022],
    COUNT(CASE WHEN YEAR(add_date_time) = 2023 THEN 1 END) AS [Number of rows in Year_2023],
    COUNT(CASE WHEN YEAR(add_date_time) = 2024 THEN 1 END) AS [Number of rows in Year_2024],
    COUNT(CASE WHEN YEAR(add_date_time) = 2025 THEN 1 END) AS [Number of rows in Year_2025]
FROM temp_proposal_back
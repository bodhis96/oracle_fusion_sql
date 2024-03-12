-- Count of AP Invoices created from all sources (along rows) and for specifeid periods (along columns)
-- Done without using PIVOT keyword
SELECT
    source,
    sum(DECODE(TO_CHAR(creation_date, 'YYYY-MM','2023-12',1,0))) AS creation_period_2023_12,
    sum(DECODE(TO_CHAR(creation_date, 'YYYY-MM','2024-01',1,0))) AS creation_period_2024_01,
    sum(DECODE(TO_CHAR(creation_date, 'YYYY-MM','2024-02',1,0))) AS creation_period_2024_02,
    sum(DECODE(TO_CHAR(creation_date, 'YYYY-MM','2025-03',1,0))) AS creation_period_2024_03,
    count(invoice_id) AS count_invoices
FROM
    ap_invoices_all
GROUP BY
    source
;




-- Count of AP Invoices created from all sources (along rows) and for specifeid periods (along columns)
-- Done by using PIVOT keyword
SELECT
    source,
    creation_period_2023_12,
    creation_period_2024_01,
    creation_period_2024_02,
    creation_period_2024_03,
    (creation_period_2023_12 + creation_period_2024_01 + creation_period_2024_02 + creation_period_2024_03) AS count_invoices
FROM
    (
        SELECT
            source,
            to_char(creation_date,'YYYY-MM') AS creation_period,
            invoice_id
        FROM
            ap_invoices_all
    ) PIVOT (
        count(invoice_id) FOR creation_period IN (
            '2023-12' AS creation_period_2023_12,
            '2024-01' AS creation_period_2024_01,
            '2024-02' AS creation_period_2024_02,
            '2024-03' AS creation_period_2024_03,
        )
    )

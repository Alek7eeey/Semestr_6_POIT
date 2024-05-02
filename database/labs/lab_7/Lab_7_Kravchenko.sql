---ex_1---
WITH sales_2022 AS (
    SELECT
        year,
        month,
        prd_type_id,
        emp_id,
        amount AS amount_2022
    FROM
        all_sales
)
SELECT
    *
FROM (
    SELECT
        year,
        month,
        prd_type_id,
        emp_id,
        amount_2022,
        CASE
            WHEN emp_id IN (21, 22) THEN ROUND(amount_2022 * 1.05, 2)
            ELSE ROUND(amount_2022 * 1.1, 2)
        END AS plan_amount
    FROM
        sales_2022
)
MODEL
    PARTITION BY (year, month, prd_type_id)
    DIMENSION BY (emp_id)
    MEASURES (amount_2022, plan_amount)
    RULES (
        plan_amount[21] = ROUND(amount_2022[21] * 1.05, 2),
        plan_amount[22] = ROUND(amount_2022[22] * 1.05, 2),
        plan_amount[23] = ROUND(amount_2022[23] * 1.1, 2),
        plan_amount[24] = ROUND(amount_2022[24] * 1.1, 2)
    );

---ex_2---
select emp_id, prd_type_id, year, month, sales_amount
    from all_sales
        model
            partition by (prd_type_id, emp_id)
            dimension by (month, year)
            measures (amount sales_amount)
            rules (

                sales_amount[for month from 1 to 12 increment 1 , 2004] =avg(sales_amount)[month between 2 and 3 ,2003]
                )
    order by year desc, month, emp_id, prd_type_id;

WITH ranked_employees AS (
    SELECT 
        employee_id,
        first_name,
        last_name,
        ROW_NUMBER() OVER (ORDER BY employee_id) AS rn,
        COUNT(*) OVER () AS total_rows
    FROM employees
)
SELECT *
FROM ranked_employees
WHERE 
    rn IN (1, 2, 5, 105, 150)
    OR rn > total_rows - 10;
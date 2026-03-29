/*
QUESTION:
Using window functions on the employees table, write a query that retrieves:
1. The first two rows in the table
2. The 5th row
3. The 105th row
4. The 150th row
5. The last 10 rows in the table

Requirements:
- Use ROW_NUMBER() to assign row positions
- Use COUNT() OVER() to determine total number of rows
- Assume ordering is based on employee_id
*/

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
    rn IN (1, 2, 5, 105, 150)   -- first two, 5th, 105th, 150th rows
    OR rn > total_rows - 10;    -- last 10 rows
/*
QUESTION 1:
Using window functions, write a query to retrieve the TOP 10 rows 
from the employees table based on employee_id ordering.
*/

SELECT *
FROM (
    SELECT 
        employee_id,
        first_name,
        last_name,
        ROW_NUMBER() OVER (ORDER BY employee_id) AS rn
    FROM employees
) t
WHERE rn <= 10;



/*
QUESTION 2:
Using window functions, write a query to retrieve ONLY the 5th row 
from the employees table based on employee_id ordering.
*/

SELECT *
FROM (
    SELECT 
        employee_id,
        first_name,
        last_name,
        ROW_NUMBER() OVER (ORDER BY employee_id) AS rn
    FROM employees
) t
WHERE rn = 5;



/*
QUESTION 3:
Using window functions, write a query to retrieve the LAST 2 rows 
from the employees table based on employee_id ordering.
*/

SELECT *
FROM (
    SELECT 
        employee_id,
        first_name,
        last_name,
        ROW_NUMBER() OVER (ORDER BY employee_id) AS rn,
        COUNT(*) OVER () AS total_rows
    FROM employees
) t
WHERE rn > total_rows - 2;



/*
QUESTION 4:
Using window functions, write a query to retrieve the 5th and 20th rows 
from the employees table based on employee_id ordering.
*/

SELECT *
FROM (
    SELECT 
        employee_id,
        first_name,
        last_name,
        ROW_NUMBER() OVER (ORDER BY employee_id) AS rn
    FROM employees
) t
WHERE rn IN (5, 20);
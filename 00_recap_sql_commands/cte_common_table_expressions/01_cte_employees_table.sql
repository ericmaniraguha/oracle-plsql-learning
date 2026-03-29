--A CTE is like a temporary named query that exists only during the execution of a single SQL statement.

/*
Why use a CTE?
    1. Makes queries easier to read
    2. Breaks complex logic into steps
    3. Replaces nested subqueries
    4. Can be reused multiple times in the same query
*/

-- ============================================
-- CTE (COMMON TABLE EXPRESSIONS)
-- ============================================

-- Syntax Reminder:
-- WITH cte_name AS (
--     SELECT ...
-- )
-- SELECT * FROM cte_name;


-- ============================================
-- EXERCISES
-- ============================================

-- EX1:
-- Create a CTE to store average salary,
-- then find employees earning above average.

-- EX2:
-- Create a CTE for total salary per department,
-- then show departments with total salary > 2000.

-- EX3:
-- Create a CTE listing employee full names and departments,
-- then filter only IT department employees.

-- EX4:
-- Use a CTE to rank employees by salary (highest first).

-- EX5:
-- Create a CTE for employees with their managers,
-- then display only employees who have managers.

-- EX6:
-- Use multiple CTEs:
-- 1) average salary per department
-- 2) employees
-- Then find employees earning above their department average.


-- ============================================
-- ANSWERS
-- ============================================

-- ANS1
WITH avg_salary_cte AS (
    SELECT AVG(salary) AS avg_salary
    FROM employees
)
SELECT first_name, salary
FROM employees
WHERE salary > (SELECT avg_salary FROM avg_salary_cte);


-- ANS2
WITH dept_salary AS (
    SELECT department_id, SUM(salary) AS total_salary
    FROM employees
    GROUP BY department_id
)
SELECT department_id, total_salary
FROM dept_salary
WHERE total_salary > 2000;


-- ANS3
WITH emp_dept AS (
    SELECT e.first_name || ' ' || e.last_name AS full_name,
           d.department_name
    FROM employees e
    JOIN departments d
    ON e.department_id = d.department_id
)
SELECT *
FROM emp_dept
WHERE department_name = 'IT';


-- ANS4 (Ranking)
WITH ranked_emp AS (
    SELECT first_name, salary,
           RANK() OVER (ORDER BY salary DESC) AS rank_salary
    FROM employees
)
SELECT *
FROM ranked_emp;


-- ANS5
WITH emp_manager AS (
    SELECT e.first_name AS employee,
           m.first_name AS manager
    FROM employees e
    LEFT JOIN employees m
    ON e.manager_id = m.employee_id
)
SELECT *
FROM emp_manager
WHERE manager IS NOT NULL;


-- ANS6 (MULTIPLE CTEs ?)
WITH dept_avg AS (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
),
emp_data AS (
    SELECT first_name, salary, department_id
    FROM employees
)
SELECT e.first_name, e.salary, e.department_id
FROM emp_data e
JOIN dept_avg d
ON e.department_id = d.department_id
WHERE e.salary > d.avg_salary;


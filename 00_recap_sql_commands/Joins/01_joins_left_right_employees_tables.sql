
-- ============================================
-- 1. EXERCISES
-- ============================================

-- EX1: Show employee full name and department name.

-- EX2: Show employee and their manager name (self join).

-- EX3: List employees with salary > 1000 and their department.

-- EX4: Count number of employees per department.

-- EX5: Find average salary per department.

-- EX6: Find highest salary in each department.

-- EX7: Show departments with total salary > 2000.

-- EX8: Show employees who do not belong to any department.


-- ============================================
-- 2. ANSWERS
-- ============================================

-- ANS1 (JOIN)
SELECT e.first_name || ' ' || e.last_name AS full_name,
       d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id;


-- ANS2 (SELF JOIN)
SELECT e.first_name AS employee,
       m.first_name AS manager
FROM employees e
LEFT JOIN employees m
ON e.manager_id = m.employee_id;


-- ANS3
SELECT e.first_name, e.salary, d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
WHERE e.salary > 1000;


-- ANS4 (COUNT + GROUP BY)
SELECT d.department_name,
       COUNT(e.employee_id) AS total_employees
FROM departments d
LEFT JOIN employees e
ON d.department_id = e.department_id
GROUP BY d.department_name;


-- ANS5 (AVG)
SELECT d.department_name,
       AVG(e.salary) AS avg_salary
FROM departments d
JOIN employees e
ON d.department_id = e.department_id
GROUP BY d.department_name;


-- ANS6 (MAX)
SELECT d.department_name,
       MAX(e.salary) AS highest_salary
FROM departments d
JOIN employees e
ON d.department_id = e.department_id
GROUP BY d.department_name;


-- ANS7 (HAVING)
SELECT d.department_name,
       SUM(e.salary) AS total_salary
FROM departments d
JOIN employees e
ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING SUM(e.salary) > 2000;


-- ANS8 (NULL CHECK)
SELECT first_name, last_name
FROM employees
WHERE department_id IS NULL;
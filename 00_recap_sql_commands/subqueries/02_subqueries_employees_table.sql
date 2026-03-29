-- ============================================
-- SUBQUERY EXERCISES
-- ============================================

-- EX1:
-- Find employees who earn more than the average salary.

-- EX2:
-- Find employees who work in the same department as 'Eric'.

-- EX3:
-- Find employees whose salary is higher than the salary of 'Alice'.

-- EX4:
-- Find employees working in departments with more than 1 employee.

-- EX5:
-- Find the employee(s) with the highest salary.

-- EX6:
-- Find employees who are NOT assigned to any department
-- (use subquery instead of direct NULL check).

-- EX7:
-- Find departments that have no employees.

-- EX8:
-- Find employees whose salary is above the average salary of their department
-- (correlated subquery).


-- ============================================
-- ANSWERS
-- ============================================

-- ANS1 (Single-row subquery)
SELECT first_name, salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);


-- ANS2
SELECT first_name, department_id
FROM employees
WHERE department_id = (
    SELECT department_id
    FROM employees
    WHERE first_name = 'Bruce'
);


-- ANS3
SELECT first_name, salary
FROM employees
WHERE salary > (
    SELECT salary
    FROM employees
    WHERE first_name = 'Alice'
);


-- ANS4 (GROUP BY + subquery)
SELECT first_name, department_id
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM employees
    GROUP BY department_id
    HAVING COUNT(*) > 1
);


-- ANS5 (MAX)
SELECT first_name, salary
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
);


-- ANS6 (NOT IN)
SELECT first_name
FROM employees
WHERE department_id NOT IN (
    SELECT department_id
    FROM departments
);


-- ANS7
SELECT department_name
FROM departments
WHERE department_id NOT IN (
    SELECT department_id
    FROM employees
    WHERE department_id IS NOT NULL
);


-- ANS8 (CORRELATED SUBQUERY ?)
SELECT e.first_name, e.salary, e.department_id
FROM employees e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = e.department_id
);
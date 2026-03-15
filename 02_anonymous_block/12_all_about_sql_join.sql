-- ========================================================
-- Exercise Set: JOINs in Oracle Database
-- ========================================================

SET SERVEROUTPUT ON;

-- ========================================================
-- Question 1: Employees with Department Names
-- ========================================================
-- Write a block to display all employees along with their department names.
-- Columns: Employee ID, Full Name, Salary, Department Name.
-- Sort by Employee ID ascending.

DECLARE
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Employees with Departments ---');
    FOR rec IN (
        SELECT e.employee_id,
               e.first_name || ' ' || e.last_name AS full_name,
               e.salary,
               d.department_name
        FROM employees e
        JOIN departments d
          ON e.department_id = d.department_id
        ORDER BY e.employee_id
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || rec.employee_id || 
                             ' | Name: ' || rec.full_name || 
                             ' | Salary: ' || rec.salary || 
                             ' | Dept: ' || rec.department_name);
    END LOOP;
END;
/

-- ========================================================
-- Question 2: Employees with Job Titles
-- ========================================================
-- Display each employee along with their job title and hire date.
DECLARE
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Employees with Job Titles ---');
    FOR rec IN (
        SELECT e.employee_id,
               e.first_name || ' ' || e.last_name AS full_name,
               j.job_title,
               e.hire_date
        FROM employees e
        JOIN jobs j
          ON e.job_id = j.job_id
        ORDER BY e.hire_date DESC
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || rec.employee_id ||
                             ' | Name: ' || rec.full_name ||
                             ' | Job: ' || rec.job_title ||
                             ' | Hire Date: ' || TO_CHAR(rec.hire_date,'YYYY-MM-DD'));
    END LOOP;
END;
/

-- ========================================================
-- Question 3: Employees above Department Average Salary
-- ========================================================
DECLARE
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Employees Above Department Average Salary ---');
    FOR rec IN (
        SELECT e.employee_id,
               e.first_name || ' ' || e.last_name AS full_name,
               e.salary,
               d.department_name,
               AVG(e.salary) OVER (PARTITION BY e.department_id) AS dept_avg
        FROM employees e
        JOIN departments d
          ON e.department_id = d.department_id
        WHERE e.salary > AVG(e.salary) OVER (PARTITION BY e.department_id)
        ORDER BY d.department_name, e.salary DESC
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || rec.employee_id ||
                             ' | Name: ' || rec.full_name ||
                             ' | Salary: ' || rec.salary ||
                             ' | Dept: ' || rec.department_name ||
                             ' | Dept Avg: ' || rec.dept_avg);
    END LOOP;
END;
/

-- ========================================================
-- Question 4: Departments with Employee Count
-- ========================================================
DECLARE
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Departments with Employee Count ---');
    FOR rec IN (
        SELECT d.department_name,
               COUNT(e.employee_id) AS num_employees
        FROM departments d
        LEFT JOIN employees e
          ON d.department_id = e.department_id
        GROUP BY d.department_name
        ORDER BY d.department_name
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Dept: ' || rec.department_name ||
                             ' | Employees: ' || rec.num_employees);
    END LOOP;
END;
/

-- ========================================================
-- Question 5: Employees with Manager Names
-- ========================================================
DECLARE
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Employees with Manager Names ---');
    FOR rec IN (
        SELECT e.first_name || ' ' || e.last_name AS emp_name,
               m.first_name || ' ' || m.last_name AS mgr_name,
               d.department_name,
               e.salary
        FROM employees e
        LEFT JOIN employees m
          ON e.manager_id = m.employee_id
        JOIN departments d
          ON e.department_id = d.department_id
        ORDER BY d.department_name, e.employee_id
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Employee: ' || rec.emp_name ||
                             ' | Manager: ' || NVL(rec.mgr_name,'No Manager') ||
                             ' | Dept: ' || rec.department_name ||
                             ' | Salary: ' || rec.salary);
    END LOOP;
END;
/

-- ========================================================
-- Question 6: Top 5 Highest Paid Employees per Department
-- ========================================================
DECLARE
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Top 5 Salaries per Department ---');
    FOR rec IN (
        SELECT *
        FROM (
            SELECT e.first_name || ' ' || e.last_name AS emp_name,
                   e.salary,
                   d.department_name,
                   ROW_NUMBER() OVER (PARTITION BY e.department_id ORDER BY e.salary DESC) AS rn
            FROM employees e
            JOIN departments d
              ON e.department_id = d.department_id
        )
        WHERE rn <= 5
        ORDER BY department_name, rn
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Dept: ' || rec.department_name ||
                             ' | Name: ' || rec.emp_name ||
                             ' | Salary: ' || rec.salary);
    END LOOP;
END;
/
-- ========================================================
-- Exercise: Employee Ranking and Salary Analysis using PL/SQL
-- ========================================================
-- Context:
-- You have the employees and departments tables in your Oracle database. 
-- Use anonymous PL/SQL blocks to answer the following questions. 
-- Combine JOINs and window functions like ROW_NUMBER(), RANK(), or COUNT() OVER () where needed. 
-- Print results using DBMS_OUTPUT.PUT_LINE.
-- ========================================================

SET SERVEROUTPUT ON;

DECLARE
BEGIN
    -- ================= First 2 Employees =================
    DBMS_OUTPUT.PUT_LINE('--- First 2 Employees ---');
    FOR rec IN (
        SELECT e.first_name || ' ' || e.last_name AS emp_name,
               e.salary,
               d.department_name,
               ROW_NUMBER() OVER (ORDER BY e.employee_id) AS rn
        FROM employees e
        JOIN departments d ON e.department_id = d.department_id
    ) LOOP
        EXIT WHEN rec.rn > 2;
        DBMS_OUTPUT.PUT_LINE(rec.rn || ': ' || rec.emp_name || ' | Salary: ' || rec.salary || ' | Dept: ' || rec.department_name);
    END LOOP;

    -- ================= Top 10 Employees by Salary =================
    DBMS_OUTPUT.PUT_LINE('--- Top 10 Employees by Salary ---');
    FOR rec IN (
        SELECT e.first_name || ' ' || e.last_name AS emp_name,
               e.salary,
               d.department_name,
               RANK() OVER (ORDER BY e.salary DESC) AS rnk
        FROM employees e
        JOIN departments d ON e.department_id = d.department_id
    ) LOOP
        EXIT WHEN rec.rnk > 10;
        DBMS_OUTPUT.PUT_LINE(rec.rnk || ': ' || rec.emp_name || ' | Salary: ' || rec.salary || ' | Dept: ' || rec.department_name);
    END LOOP;

    -- ================= Last 5 Employees by Salary =================
    DBMS_OUTPUT.PUT_LINE('--- Last 5 Employees by Salary ---');
    FOR rec IN (
        SELECT e.first_name || ' ' || e.last_name AS emp_name,
               e.salary,
               d.department_name,
               ROW_NUMBER() OVER (ORDER BY e.salary ASC) AS rn_asc,
               COUNT(*) OVER () AS total_count
        FROM employees e
        JOIN departments d ON e.department_id = d.department_id
    ) LOOP
        EXIT WHEN rec.rn_asc <= rec.total_count - 5;
        DBMS_OUTPUT.PUT_LINE(rec.rn_asc || ': ' || rec.emp_name || ' | Salary: ' || rec.salary || ' | Dept: ' || rec.department_name);
    END LOOP;

    -- ================= 50th Employee by Salary =================
    DBMS_OUTPUT.PUT_LINE('--- 50th Employee by Salary ---');
    FOR rec IN (
        SELECT e.first_name || ' ' || e.last_name AS emp_name,
               e.salary,
               d.department_name,
               ROW_NUMBER() OVER (ORDER BY e.salary DESC) AS rn
        FROM employees e
        JOIN departments d ON e.department_id = d.department_id
    ) LOOP
        IF rec.rn = 50 THEN
            DBMS_OUTPUT.PUT_LINE(rec.rn || ': ' || rec.emp_name || ' | Salary: ' || rec.salary || ' | Dept: ' || rec.department_name);
            EXIT;
        END IF;
    END LOOP;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
END;
/
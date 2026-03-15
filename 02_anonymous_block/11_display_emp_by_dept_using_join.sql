-- ========================================================
-- Exercise: Display Employees with Departments using Anonymous Block
-- ========================================================
-- Question:
-- Write an anonymous PL/SQL block that prints all employees along with their department names.
-- Include:
-- 1. Employee ID
-- 2. Employee full name (first_name + last_name)
-- 3. Salary
-- 4. Department name
-- Sort the results by employee ID in ascending order.
-- ========================================================

SET SERVEROUTPUT ON;

DECLARE
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Employees and Their Departments ---');

    FOR rec IN (
        SELECT e.employee_id,
               e.first_name || ' ' || e.last_name AS employee_name,
               e.salary,
               d.department_name
        FROM employees e
        JOIN departments d 
          ON e.department_id = d.department_id
        ORDER BY e.employee_id
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(
            'ID: ' || rec.employee_id || 
            ' | Name: ' || rec.employee_name || 
            ' | Salary: ' || rec.salary || 
            ' | Dept: ' || rec.department_name
        );
    END LOOP;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
END;
/
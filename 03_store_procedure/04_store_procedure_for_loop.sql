-- ========================================================
-- Procedure: list_employees_by_department
-- Purpose  : List employees for a given department using a FOR loop
-- Parameter: p_dept_id (Department ID)
-- ========================================================

CREATE OR REPLACE PROCEDURE list_employees_by_department (
    p_dept_id IN employees.department_id%TYPE
)
IS
BEGIN
    -- Loop through all employees in the given department
    FOR emp_rec IN (
        SELECT employee_id, first_name, last_name, salary
        FROM employees
        WHERE department_id = p_dept_id
        ORDER BY last_name, first_name
    )
    LOOP
        -- Display employee info
        DBMS_OUTPUT.PUT_LINE(
            'Employee ID: ' || emp_rec.employee_id ||
            ' | Name: ' || emp_rec.first_name || ' ' || emp_rec.last_name ||
            ' | Salary: ' || emp_rec.salary
        );
    END LOOP;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No employees found for department ID ' || p_dept_id);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
END list_employees_by_department;
/
-- ========================================================

-- Example call:

BEGIN
    -- Replace 10 with the department_id you want to query
    list_employees_by_department(10);
END;
/
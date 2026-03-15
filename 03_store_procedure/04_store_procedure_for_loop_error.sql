-- =============================================
-- Procedure: list_employees_by_department
-- Purpose  : Show first employee's first name in a given department
-- Note     : This version uses SELECT INTO, which can only handle
--            one row at a time. If multiple employees exist in the
--            department without the ROWNUM filter, it will throw
--            ORA-01422 (exact fetch returns more than one row)
-- =============================================

CREATE OR REPLACE PROCEDURE list_employees_by_department (
    p_dept_id IN employees.department_id%TYPE  -- input parameter: department id
)
IS
    v_emp_name employees.first_name%TYPE;     -- variable to hold first_name
BEGIN
    -- SELECT INTO fetches a single value
    -- If multiple employees exist for the department, it will fail
    SELECT first_name
    INTO v_emp_name
    FROM employees
    WHERE department_id = p_dept_id
      AND ROWNUM = 1;  -- limits the result to 1 row to prevent error

    DBMS_OUTPUT.PUT_LINE('First employee: ' || v_emp_name);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No employees found in this department.');
    WHEN TOO_MANY_ROWS THEN
        -- This will not occur here because of ROWNUM = 1
        DBMS_OUTPUT.PUT_LINE('Error: More than one employee found.');
END;
/

-- Enable output so you can see DBMS_OUTPUT
SET SERVEROUTPUT ON;

-- Call the procedure for department 10 (example)
BEGIN
    list_employees_by_department(10);
END;
/
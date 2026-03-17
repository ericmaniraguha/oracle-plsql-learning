-- ========================================================
-- Function: update_salary_func
-- Updates the salary of an employee and returns a status message
-- Includes:
--   - User-defined exception
--   - Savepoint and rollback
--   - Exception handling for VALUE_ERROR and others
-- ========================================================

CREATE OR REPLACE FUNCTION update_salary_func (
    p_emp_id      IN employees.employee_id%TYPE,  -- Employee ID
    p_new_salary  IN employees.salary%TYPE       -- New salary
) RETURN VARCHAR2
IS
    ---------------------------------------------------------------------
    -- User-defined exception for invalid employee
    ---------------------------------------------------------------------
    e_invalid_emp EXCEPTION;

    ---------------------------------------------------------------------
    -- Variable to check number of rows updated
    ---------------------------------------------------------------------
    v_rows_updated NUMBER;

BEGIN
    -- Savepoint before update
    SAVEPOINT before_salary_update;

    -- Attempt to update salary
    UPDATE employees
    SET salary = p_new_salary
    WHERE employee_id = p_emp_id;

    v_rows_updated := SQL%ROWCOUNT; -- Number of rows affected

    -- Raise user-defined exception if no rows were updated
    IF v_rows_updated = 0 THEN
        RAISE e_invalid_emp;
    END IF;

    RETURN 'Salary updated successfully for Employee ID ' || p_emp_id;

EXCEPTION
    -- Handle user-defined exception
    WHEN e_invalid_emp THEN
        ROLLBACK TO before_salary_update;
        RETURN 'Error: Employee ID ' || p_emp_id || ' does not exist.';

    -- Handle numeric or value errors
    WHEN VALUE_ERROR THEN
        ROLLBACK TO before_salary_update;
        RETURN 'Error: Invalid salary value provided.';

    -- Handle any other unexpected errors
    WHEN OTHERS THEN
        ROLLBACK TO before_salary_update;
        RETURN 'Unexpected error: ' || SQLERRM;

END update_salary_func;
/

--Test the function

SET SERVEROUTPUT ON;

DECLARE
    v_status VARCHAR2(200);
BEGIN
    -- Test 1: Valid Employee
    v_status := update_salary_func(101, 7500);
    DBMS_OUTPUT.PUT_LINE(v_status);

    -- Test 2: Invalid Employee
    v_status := update_salary_func(999, 6000);
    DBMS_OUTPUT.PUT_LINE(v_status);

    -- Test 3: Invalid Salary Value
    v_status := update_salary_func(101, NULL);
    DBMS_OUTPUT.PUT_LINE(v_status);
END;
/
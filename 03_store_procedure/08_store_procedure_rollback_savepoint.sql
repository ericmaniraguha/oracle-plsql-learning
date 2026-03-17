-- Procedure: Update salary for an employee with exception handling
CREATE OR REPLACE PROCEDURE update_salary (
    p_emp_id      IN  employees.employee_id%TYPE,  -- Employee ID
    p_new_salary  IN  employees.salary%TYPE        -- New salary
) IS
    ---------------------------------------------------------------------
    -- User-defined exception for invalid employee ID
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

    DBMS_OUTPUT.PUT_LINE('Salary updated successfully for Employee ID ' || p_emp_id);

EXCEPTION
    -- Handle user-defined exception
    WHEN e_invalid_emp THEN
        DBMS_OUTPUT.PUT_LINE('Error: Employee ID ' || p_emp_id || ' does not exist.');
        ROLLBACK TO before_salary_update;  -- Rollback to savepoint

    -- Handle numeric or value errors
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Error: Invalid salary value provided.');
        ROLLBACK TO before_salary_update;

    -- Handle any other unexpected errors
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
        ROLLBACK TO before_salary_update;
END;
/



-- ========================================================
-- Test Block for update_salary Procedure
-- Demonstrates:
--   1. Valid update
--   2. Invalid employee ID
--   3. Invalid salary value
-- ========================================================

SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Test 1: Valid Employee ---');
    update_salary(p_emp_id => 101, p_new_salary => 7500);

    DBMS_OUTPUT.PUT_LINE('--- Test 2: Invalid Employee ---');
    update_salary(p_emp_id => 999, p_new_salary => 6000);

    DBMS_OUTPUT.PUT_LINE('--- Test 3: Invalid Salary Value ---');
    -- Assuming salary cannot be NULL or negative
    update_salary(p_emp_id => 101, p_new_salary => NULL);  

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error in test block: ' || SQLERRM);
END;
/
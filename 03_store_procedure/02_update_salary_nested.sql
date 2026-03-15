/*
Nested Procedure Example
This demonstrates how a procedure can call another procedure defined inside it.
The outer procedure updates an employee's salary by a given percentage.
*/

CREATE OR REPLACE PROCEDURE update_salary_nested (
    p_emp_id    IN employees.employee_id%TYPE,
    p_percent   IN NUMBER
)
IS
    -- Inner procedure to validate the salary percentage
    PROCEDURE validate_percentage(p IN NUMBER) IS
    BEGIN
        IF p <= 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Percentage must be positive.');
        END IF;
    END validate_percentage;

BEGIN
    -- Call inner procedure to validate the input
    validate_percentage(p_percent);

    -- Update the employee's salary
    UPDATE employees
    SET salary = salary + (salary * p_percent / 100)
    WHERE employee_id = p_emp_id;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No employee found with ID ' || p_emp_id);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Salary updated for employee ID ' || p_emp_id);
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END update_salary_nested;
/


-- Enable output
SET SERVEROUTPUT ON;

-- Test Case 1: Valid update
BEGIN
    update_salary_nested(101, 10);  -- Increase salary of employee_id 101 by 10%
END;
/

-- Test Case 2: Invalid percentage (negative)
BEGIN
    update_salary_nested(101, -5);  -- Should raise an error from nested procedure
END;
/

-- Test Case 3: Non-existent employee
BEGIN
    update_salary_nested(999, 5);   -- Employee 999 does not exist
END;
/
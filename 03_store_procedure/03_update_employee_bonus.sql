-- Procedure: update_employee_bonus
-- Purpose: Update the bonus of an employee safely with error handling
-- Inputs:
--   p_emp_id  -> Employee ID
--   p_bonus   -> Bonus amount (must be non-negative)
-- Features:
--   1. Checks if employee exists
--   2. Validates bonus amount
--   3. Handles exceptions and rolls back changes
--   4. Displays success or error messages


/*

1. Why is it important to ROLLBACK changes when an error occurs?
   Answer: To ensure the database remains consistent and no partial updates corrupt the data.

2. What happens if we remove the ROLLBACK from the procedure?
   Answer: Partial updates may remain, which can lead to inconsistent or invalid data.

3. How can we modify the procedure to log errors into a separate database table instead of just displaying messages?
   Answer:
      a) Create an error_log table with columns like error_date, employee_id, error_message.
      b) Inside the WHEN OTHERS block of the procedure, insert the error information into this table
         instead of just using DBMS_OUTPUT.PUT_LINE.
*/

CREATE OR REPLACE PROCEDURE update_employee_bonus (
    p_emp_id IN employees.employee_id%TYPE,
    p_bonus  IN employees.commission_pct%TYPE
)
IS
    -- Variable to check if employee exists
    v_count NUMBER;
BEGIN
    -- Check if the employee exists
    SELECT COUNT(*)
    INTO v_count
    FROM employees
    WHERE employee_id = p_emp_id;

    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Error: Employee ID ' || p_emp_id || ' does not exist.');
        RETURN;
    END IF;

    -- Check if bonus is valid
    IF p_bonus < 0 THEN
        DBMS_OUTPUT.PUT_LINE('Error: Bonus amount cannot be negative.');
        RETURN;
    END IF;

    -- Update bonus
    UPDATE employees
    SET commission_pct = p_bonus
    WHERE employee_id = p_emp_id;

    COMMIT;  -- Commit only if all checks pass
    DBMS_OUTPUT.PUT_LINE('Success: Bonus updated for Employee ID ' || p_emp_id || ' to ' || p_bonus);

EXCEPTION
    -- Handle any unexpected errors
    WHEN OTHERS THEN
        ROLLBACK;  -- Undo any partial changes
        DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
END update_employee_bonus;
/


SET SERVEROUTPUT ON;

-- Valid update
BEGIN
    update_employee_bonus(101, 0.15);
END;
/

-- Employee does not exist
BEGIN
    update_employee_bonus(999, 0.10);
END;
/

-- Invalid bonus
BEGIN
    update_employee_bonus(101, -0.05);
END;
/


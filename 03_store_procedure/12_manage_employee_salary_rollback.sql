
    /*
Question:
Write a PL/SQL stored procedure named manage_employee_salary_rollback that:
- Accepts employee ID and an action (SHOW, RAISE, LOWER)
- Displays employee salary if action is SHOW
- Increases salary by 10% if action is RAISE
- Decreases salary by 10% if action is LOWER
- Uses SAVEPOINT and ROLLBACK to handle errors
- Prevents invalid actions from committing changes
*/

CREATE OR REPLACE PROCEDURE manage_employee_salary_rollback (
    p_emp_id    IN employees.employee_id%TYPE,  
    p_action    IN VARCHAR2                    
)
IS
    v_first_name employees.first_name%TYPE;
    v_last_name  employees.last_name%TYPE;
    v_salary     employees.salary%TYPE;
BEGIN
    -- Set savepoint before any change
    SAVEPOINT before_update;

    -- Fetch employee details
    SELECT first_name, last_name, salary
    INTO v_first_name, v_last_name, v_salary
    FROM employees
    WHERE employee_id = p_emp_id;

    -- Perform action
    IF UPPER(p_action) = 'SHOW' THEN
        DBMS_OUTPUT.PUT_LINE('Employee: ' || v_first_name || ' ' || v_last_name || 
                             ' - Salary: ' || v_salary);

    ELSIF UPPER(p_action) = 'RAISE' THEN
        UPDATE employees
        SET salary = salary * 1.10
        WHERE employee_id = p_emp_id;

        DBMS_OUTPUT.PUT_LINE('Salary increased by 10% for ' || v_first_name || ' ' || v_last_name);

    ELSIF UPPER(p_action) = 'LOWER' THEN
        UPDATE employees
        SET salary = salary * 0.90
        WHERE employee_id = p_emp_id;

        DBMS_OUTPUT.PUT_LINE('Salary decreased by 10% for ' || v_first_name || ' ' || v_last_name);

    ELSE
        DBMS_OUTPUT.PUT_LINE('Invalid action! Use SHOW, RAISE, or LOWER.');
        ROLLBACK TO before_update;
        RETURN;
    END IF;

    -- Commit only if successful
    COMMIT;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Employee ID ' || p_emp_id || ' not found.');
        ROLLBACK TO before_update;

    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Error: Multiple employees found with ID ' || p_emp_id);
        ROLLBACK TO before_update;

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
        ROLLBACK TO before_update;
END manage_employee_salary_rollback;
/
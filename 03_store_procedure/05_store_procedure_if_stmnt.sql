-- ========================================================
-- Example: Parameterized Procedure with IF, CASE, and Exception Handling
-- Table: EMPLOYEES
-- ========================================================

CREATE OR REPLACE PROCEDURE manage_employee_salary (
    p_emp_id    IN employees.employee_id%TYPE,   -- Employee ID input
    p_action    IN VARCHAR2                       -- Action type: 'SHOW', 'RAISE', 'LOWER'
)
IS
    v_first_name employees.first_name%TYPE;
    v_last_name  employees.last_name%TYPE;
    v_salary     employees.salary%TYPE;
BEGIN
    -- Fetch employee details
    SELECT first_name, last_name, salary
    INTO v_first_name, v_last_name, v_salary
    FROM employees
    WHERE employee_id = p_emp_id;

    -- Determine action using IF or CASE
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
    END IF;

    COMMIT;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Employee ID ' || p_emp_id || ' not found.');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Error: Multiple employees found with ID ' || p_emp_id);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
END manage_employee_salary;
/
-- ========================================================

-- Example calls:
-- Display salary
BEGIN
    manage_employee_salary(101, 'SHOW');
END;
/

-- Increase salary
BEGIN
    manage_employee_salary(101, 'RAISE');
END;
/

-- Decrease salary
BEGIN
    manage_employee_salary(101, 'LOWER');
END;
/
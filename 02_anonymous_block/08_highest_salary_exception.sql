-- ========================================================
-- Exercise 8: Highest Salary Employee with Exception Handling
-- ========================================================
DECLARE
    v_first_name employees.first_name%TYPE;
    v_last_name employees.last_name%TYPE;
    v_salary employees.salary%TYPE;

    -- User-defined exception
    e_no_employee_found EXCEPTION;
BEGIN
    -- Attempt to get the employee with the highest salary
    SELECT first_name, last_name, salary
    INTO v_first_name, v_last_name, v_salary
    FROM employees
    WHERE salary = (SELECT MAX(salary) FROM employees);

    -- Check if salary is NULL (no data)
    IF v_salary IS NULL THEN
        RAISE e_no_employee_found;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Highest salary employee: ' || v_first_name || ' ' || v_last_name || ' - Salary: ' || v_salary);

EXCEPTION
    -- Handle user-defined exception
    WHEN e_no_employee_found THEN
        DBMS_OUTPUT.PUT_LINE('Error: No employees found in the table.');

    -- Handle predefined exceptions
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: No matching data found.');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Error: More than one employee has the highest salary.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
END;
/
-- ========================================================
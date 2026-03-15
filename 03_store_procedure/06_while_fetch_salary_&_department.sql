-- ========================================================
-- Example: WHILE Loop with Table, Parameter, and Exception Handling
-- ========================================================

SET SERVEROUTPUT ON;

-- Create a procedure with an input parameter
CREATE OR REPLACE PROCEDURE print_employees(
    p_max IN NUMBER   -- input: number of employees to print
)
IS
    v_counter NUMBER := 1;  -- counter for loop
    v_emp_name employees.first_name%TYPE;
    
    -- User-defined exception
    e_no_employees EXCEPTION;
BEGIN
    IF p_max <= 0 THEN
        RAISE e_no_employees;  -- raise user-defined exception if input invalid
    END IF;

    DBMS_OUTPUT.PUT_LINE('--- Printing first ' || p_max || ' employees ---');

    WHILE v_counter <= p_max LOOP
        -- Fetch employee name by rownum
        SELECT first_name || ' ' || last_name
        INTO v_emp_name
        FROM (
            SELECT first_name, last_name, ROW_NUMBER() OVER (ORDER BY employee_id) AS rn
            FROM employees
        )
        WHERE rn = v_counter;

        DBMS_OUTPUT.PUT_LINE('Employee ' || v_counter || ': ' || v_emp_name);
        v_counter := v_counter + 1;
    END LOOP;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Employee not found.');
    WHEN e_no_employees THEN
        DBMS_OUTPUT.PUT_LINE('User-defined error: Invalid number of employees.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
END;
/

--How to Run the Procedure with a Parameter

-- Example: Print first 3 employees
BEGIN
    print_employees(3);
END;
/
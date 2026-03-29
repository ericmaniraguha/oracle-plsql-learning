DECLARE
    -- Declare a cursor variable (pointer)
    TYPE emp_ref_cursor IS REF CURSOR;
    c_emp emp_ref_cursor;

    -- Variables to store fetched values
    v_id employees.employee_id%TYPE;
    v_name employees.first_name%TYPE;
BEGIN
    -- Open the cursor variable for a query
    OPEN c_emp FOR
        SELECT employee_id, first_name
        FROM employees
        WHERE department_id = 30;

    -- Loop through the cursor
    LOOP
        FETCH c_emp INTO v_id, v_name;
        EXIT WHEN c_emp%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_id || ', Name: ' || v_name);
    END LOOP;

    -- Close the cursor variable
    CLOSE c_emp;
END;
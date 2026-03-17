SET SERVEROUTPUT ON;

DECLARE
    --------------------------------------------------------------------
    -- Cursor Example: Fetch employee data from the EMPLOYEES table
    --------------------------------------------------------------------
    
    -- Step 1: Declare a cursor to select employee_id and first_name
    CURSOR c_emp IS 
        SELECT employee_id, first_name 
        FROM employees;

    -- Step 2: Declare a record variable to hold a row fetched from the cursor
    emp_rec c_emp%ROWTYPE;

BEGIN
    --------------------------------------------------------------------
    -- Step 3: Open the cursor
    --------------------------------------------------------------------
    OPEN c_emp;

    --------------------------------------------------------------------
    -- Step 4: Fetch rows one by one using a loop
    --------------------------------------------------------------------
    LOOP
        -- Fetch a row from the cursor into the record
        FETCH c_emp INTO emp_rec;

        -- Exit the loop if there are no more rows
        EXIT WHEN c_emp%NOTFOUND;

        -- Step 5: Process/display the data
        DBMS_OUTPUT.PUT_LINE(
            'Employee ID: ' || emp_rec.employee_id || 
            ', Name: ' || emp_rec.first_name
        );
    END LOOP;

    --------------------------------------------------------------------
    -- Step 6: Close the cursor
    --------------------------------------------------------------------
    CLOSE c_emp;

EXCEPTION
    --------------------------------------------------------------------
    -- Exception handling block to catch unexpected errors
    --------------------------------------------------------------------
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);

        -- Ensure the cursor is closed if an error occurs
        IF c_emp%ISOPEN THEN
            CLOSE c_emp;
        END IF;
END;
/
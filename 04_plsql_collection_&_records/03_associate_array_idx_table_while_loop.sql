-- 1 – Associative Array (Index-by Table)
SET SERVEROUTPUT ON;

DECLARE
    -- Step 1: Define an associative array type
    -- Key: Employee ID (integer)
    -- Value: Employee Name (string)
    TYPE emp_array IS TABLE OF VARCHAR2(50) INDEX BY PLS_INTEGER;

    -- Step 2: Declare a variable of this type
    employees emp_array;

    -- Step 3: Iterator variable for looping through keys
    v_id PLS_INTEGER;
BEGIN
    -- Step 4: Populate the associative array
    employees(101) := 'Alice';
    employees(102) := 'Bob';
    employees(103) := 'Charlie';

    -- Step 5: Loop through all keys to display employee names
    v_id := employees.FIRST;  -- Get first key
    WHILE v_id IS NOT NULL LOOP
        DBMS_OUTPUT.PUT_LINE('Employee ID ' || v_id || ' ? ' || employees(v_id));
        v_id := employees.NEXT(v_id);  -- Move to next key
    END LOOP;
END;
/
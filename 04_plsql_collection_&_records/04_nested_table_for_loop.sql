SET SERVEROUTPUT ON;

DECLARE
    -- Step 1: Define a nested table type to store numbers
    TYPE num_table IS TABLE OF NUMBER;

    -- Step 2: Declare a nested table variable
    numbers num_table := num_table();

    -- Step 3: Variable to calculate total sum
    total NUMBER := 0;
BEGIN
    -- Step 4: Add numbers dynamically using EXTEND
    numbers.EXTEND; numbers(1) := 10;
    numbers.EXTEND; numbers(2) := 20;
    numbers.EXTEND; numbers(3) := 15;
    numbers.EXTEND; numbers(4) := 25;
    numbers.EXTEND; numbers(5) := 30;

    -- Step 5: Loop through the nested table to calculate sum
    FOR i IN 1..numbers.COUNT LOOP
        total := total + numbers(i);
    END LOOP;

    -- Step 6: Display the total sum
    DBMS_OUTPUT.PUT_LINE('Total sum of numbers: ' || total);
END;
/
-- ========================================================
-- Example: Simple WHILE Loop in PL/SQL
-- ========================================================

SET SERVEROUTPUT ON;

DECLARE
    v_counter NUMBER := 1;  -- initialize counter
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Counting from 1 to 5 using WHILE loop ---');

    WHILE v_counter <= 5 LOOP
        DBMS_OUTPUT.PUT_LINE('Counter: ' || v_counter);
        v_counter := v_counter + 1;  -- increment counter
    END LOOP;
END;
/
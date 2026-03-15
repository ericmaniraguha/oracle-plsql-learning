-- =========================
-- Exercise 7: Exception Handling
-- =========================
-- Question:
-- Write a block that divides two numbers and handles division by zero.

-- Solution:
SET SERVEROUTPUT ON;

DECLARE
    a NUMBER := 10;
    b NUMBER := 0; -- simulate error
    result NUMBER;
BEGIN
    BEGIN
        result := a / b;
        DBMS_OUTPUT.PUT_LINE('Result is ' || result);
    EXCEPTION
        WHEN ZERO_DIVIDE THEN
            DBMS_OUTPUT.PUT_LINE('Error: Division by zero is not allowed');
    END;
END;
/
-- ========================================================

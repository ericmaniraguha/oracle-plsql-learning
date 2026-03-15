
-- =========================
-- Exercise 5: Using Variables and Loops
-- =========================
-- Question:
-- Ask the user (simulate by variable) for a number n.
-- Print the squares of numbers from 1 to n.

-- Solution:
SET SERVEROUTPUT ON;

DECLARE
    n NUMBER := 5; -- simulate user input
BEGIN
    FOR i IN 1..n LOOP
        DBMS_OUTPUT.PUT_LINE('Square of ' || i || ' is ' || (i*i));
    END LOOP;
END;
/
-- ========================================================
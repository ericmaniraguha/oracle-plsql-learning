-- ========================================================

-- =========================
-- Exercise 4: Looping
-- =========================
-- Question:
-- Write a block that prints numbers from 1 to 5 using a FOR loop.

-- Solution:
BEGIN
    FOR i IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE('Number: ' || i);
    END LOOP;
END;
/

-- =========================
-- Exercise 3: Conditional Logic
-- =========================
-- Question:
-- Write an anonymous block that checks if a number is positive, negative, or zero
-- and prints the result.

-- Solution:
DECLARE
    num NUMBER := -7;
BEGIN
    IF num > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Number is positive');
    ELSIF num < 0 THEN
        DBMS_OUTPUT.PUT_LINE('Number is negative');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Number is zero');
    END IF;
END;
/
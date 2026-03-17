SET SERVEROUTPUT ON;

-- 1. Create deterministic function
CREATE OR REPLACE FUNCTION square_num(p_num NUMBER)
RETURN NUMBER
DETERMINISTIC
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Function executed for value: ' || p_num);
    RETURN p_num * p_num;
END;
/

-- =====================================================
-- 2. Statement-level demonstration
-- Same function call repeated in one SQL statement
-- =====================================================

SELECT square_num(5) AS result1,
       square_num(5) AS result2,
       square_num(5) AS result3
FROM dual;

-- =====================================================
-- 3. Session-level demonstration
-- Separate SQL statements in the same session
-- =====================================================

SELECT square_num(5) FROM dual;
SELECT square_num(5) FROM dual;
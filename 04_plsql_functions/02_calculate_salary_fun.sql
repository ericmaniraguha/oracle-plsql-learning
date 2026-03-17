-- ========================================================
-- Function: get_bonus
-- Purpose: Calculate a simple bonus (e.g., 10% of salary)
-- ========================================================
CREATE OR REPLACE FUNCTION get_bonus (
    p_salary NUMBER
) RETURN NUMBER
IS
BEGIN
    RETURN p_salary * 0.1;  -- 10% bonus
END get_bonus;
/

-- PL/SQL test with output:

SET SERVEROUTPUT ON;

DECLARE
    v_bonus NUMBER;
BEGIN
    v_bonus := get_bonus(5);  -- assign function result
    DBMS_OUTPUT.PUT_LINE('Bonus: ' || v_bonus);
END;
/



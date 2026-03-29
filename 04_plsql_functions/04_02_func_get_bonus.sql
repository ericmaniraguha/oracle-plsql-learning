create or replace FUNCTION get_bonus (
    p_salary NUMBER
) RETURN NUMBER
IS
BEGIN
    RETURN p_salary * 0.1;  -- 10% bonus
END get_bonus;

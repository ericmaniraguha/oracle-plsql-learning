create or replace FUNCTION get_total_income (p_salary NUMBER)

RETURN NUMBER
IS
    v_bonus NUMBER;
BEGIN
    -- Call function inside another function
    v_bonus := get_bonus(p_salary);

    RETURN p_salary + v_bonus;
END;

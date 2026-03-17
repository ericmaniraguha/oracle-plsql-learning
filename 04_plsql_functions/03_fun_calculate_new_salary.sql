
-- ========================================================
-- Function: calculate_new_salary
-- Purpose: Calculate new salary with a given increment rate
-- ========================================================

CREATE OR REPLACE FUNCTION calculate_new_salary (
    p_salary NUMBER,
    p_increment_rate NUMBER
) RETURN NUMBER
IS
BEGIN
    -- Check valid input
    IF p_salary IS NULL OR p_salary < 0 THEN
        RAISE VALUE_ERROR;
    END IF;

    -- Return salary with increment
    RETURN p_salary * (1 + p_increment_rate);

EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Error: Invalid salary (' || p_salary || ').');
        RETURN NULL;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
        RETURN NULL;
END calculate_new_salary;
/


SET SERVEROUTPUT ON;

-- ========================================================
-- Test Block for Function: calculate_new_salary
-- Purpose: Test the function with valid and invalid inputs
-- ========================================================

DECLARE
    v_new_salary NUMBER;
BEGIN
    ------------------------------------------------------------
    -- Test 1: Valid salary with 2% increment
    ------------------------------------------------------------
    v_new_salary := calculate_new_salary(5000, 0.02);
    DBMS_OUTPUT.PUT_LINE('Test 1 - New salary: ' || v_new_salary);

    ------------------------------------------------------------
    -- Test 2: Valid salary with 10% increment
    ------------------------------------------------------------
    v_new_salary := calculate_new_salary(7500, 0.10);
    DBMS_OUTPUT.PUT_LINE('Test 2 - New salary: ' || v_new_salary);

    ------------------------------------------------------------
    -- Test 3: Invalid salary (negative value)
    ------------------------------------------------------------
    v_new_salary := calculate_new_salary(-1000, 0.05);
    DBMS_OUTPUT.PUT_LINE('Test 3 - New salary: ' || v_new_salary);

    ------------------------------------------------------------
    -- Test 4: Invalid salary (NULL)
    ------------------------------------------------------------
    v_new_salary := calculate_new_salary(NULL, 0.05);
    DBMS_OUTPUT.PUT_LINE('Test 4 - New salary: ' || v_new_salary);

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error in test block: ' || SQLERRM);
END;
/
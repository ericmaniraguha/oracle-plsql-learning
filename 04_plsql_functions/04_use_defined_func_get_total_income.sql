-- Enable output
SET SERVEROUTPUT ON;

--------------------------------------------------------
-- 1 Test: Simple PL/SQL block with variable
--------------------------------------------------------
DECLARE
    v_total NUMBER;
BEGIN
    v_total := get_total_income(5000);
    DBMS_OUTPUT.PUT_LINE('1 Total income (PL/SQL block): ' || v_total);
END;
/

--------------------------------------------------------
-- 2. Test: Using SELECT from DUAL
--------------------------------------------------------
SELECT get_total_income(5000) AS total_income
FROM dual;

--------------------------------------------------------
-- 3. Test: PL/SQL block with calculation / logic
--------------------------------------------------------
DECLARE
    v_salary NUMBER := 7000;
    v_income NUMBER;
BEGIN
    v_income := get_total_income(v_salary);

    IF v_income > v_salary THEN
        DBMS_OUTPUT.PUT_LINE('3 Salary increased to: ' || v_income);
    ELSE
        DBMS_OUTPUT.PUT_LINE('3 No increase');
    END IF;
END;
/

--------------------------------------------------------
-- 4. Test: Inside a procedure
--------------------------------------------------------
CREATE OR REPLACE PROCEDURE print_income(p_salary NUMBER) IS
    v_income NUMBER;
BEGIN
    v_income := get_total_income(p_salary);
    DBMS_OUTPUT.PUT_LINE('4. Total income for salary ' || p_salary || ' is ' || v_income);
END;
/
-- Call the procedure
BEGIN
    print_income(6000);
END;
/

--------------------------------------------------------
-- 5. Test: Using UPDATE statement (example table: employees)
-- Make sure 'total_income' column exists
--------------------------------------------------------
-- UPDATE employees
-- SET total_income = get_total_income(salary)
-- WHERE employee_id = 101;
-- COMMIT;

--------------------------------------------------------
-- 6. Test: Using INSERT statement (example table: test_salaries)
-- Make sure table exists
--------------------------------------------------------
-- INSERT INTO test_salaries(employee_id, total_income)
-- VALUES (1, get_total_income(5000));
-- COMMIT;

--------------------------------------------------------
-- 7?? Test: Inside another function
--------------------------------------------------------
CREATE OR REPLACE FUNCTION double_total_income(p_salary NUMBER)
RETURN NUMBER
IS
    v_total NUMBER;
BEGIN
    v_total := get_total_income(p_salary);
    RETURN v_total * 2;
END;
/
-- Test the new function
SELECT double_total_income(5000) AS double_income FROM dual;

--------------------------------------------------------
-- 8. Test: Inside calculations
--------------------------------------------------------
DECLARE
    v_salary NUMBER := 8000;
    v_total_income NUMBER;
    v_tax NUMBER;
BEGIN
    v_total_income := get_total_income(v_salary);
    v_tax := v_total_income * 0.1;

    DBMS_OUTPUT.PUT_LINE('8. Total income: ' || v_total_income);
    DBMS_OUTPUT.PUT_LINE('8. Tax (10%): ' || v_tax);
END;
/

--------------------------------------------------------
-- 9. Test: Shortcut EXECUTE block
--------------------------------------------------------
BEGIN
    DBMS_OUTPUT.PUT_LINE('9. Total income (EXEC shortcut): ' || get_total_income(5500));
END;
/
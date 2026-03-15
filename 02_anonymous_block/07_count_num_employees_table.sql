
-- ========================================================
-- Exercise 2: Count Employees
-- ========================================================
-- Question:
-- Print the total number of employees in the EMPLOYEES table.
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM employees;
    DBMS_OUTPUT.PUT_LINE('Total employees: ' || v_count);
END;
/
-- ========================================================

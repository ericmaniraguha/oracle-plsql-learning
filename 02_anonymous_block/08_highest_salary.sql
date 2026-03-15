-- ========================================================
-- Exercise 8: Highest Salary Employee
-- ========================================================
-- Question:
-- Find and print the employee with the highest salary.
DECLARE
    v_first_name employees.first_name%TYPE;
    v_last_name employees.last_name%TYPE;
    v_salary employees.salary%TYPE;
BEGIN
    SELECT first_name, last_name, salary
    INTO v_first_name, v_last_name, v_salary
    FROM employees
    WHERE salary = (SELECT MAX(salary) FROM employees);

    DBMS_OUTPUT.PUT_LINE('Highest salary employee: ' || v_first_name || ' ' || v_last_name || ' - Salary: ' || v_salary);
END;
/
-- ========================================================
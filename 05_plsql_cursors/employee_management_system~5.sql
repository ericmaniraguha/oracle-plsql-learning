
-- ========================================================
-- Exercise 3: Employee Salary Check
-- ========================================================
-- Question:
-- Print employees who earn more than 5000.
DECLARE
    CURSOR emp_cur IS
        SELECT first_name, last_name, salary FROM employees WHERE salary > 5000;
    v_emp emp_cur%ROWTYPE;
BEGIN
    OPEN emp_cur;
    LOOP
        FETCH emp_cur INTO v_emp;
        EXIT WHEN emp_cur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_emp.first_name || ' ' || v_emp.last_name || ' - Salary: ' || v_emp.salary);
    END LOOP;
    CLOSE emp_cur;
END;
/
-- ========================================================

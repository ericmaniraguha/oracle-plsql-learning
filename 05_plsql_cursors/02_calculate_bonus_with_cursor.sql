/*
QUESTION:

A company stores employee information in a table called employees 
(emp_id, emp_name, salary, department_id, status).

Write a PL/SQL program that:
1. Uses a cursor to retrieve all ACTIVE employees.
2. Processes each employee one by one.
3. Calculates a bonus as follows:
   - Department 10 ? 10% of salary
   - Department 20 ? 15% of salary
   - Other departments ? 5% of salary
4. Displays the employee name and calculated bonus.

Explain why a cursor is used in this scenario.

--------------------------------------------------

ANSWER:

A cursor is used because:
- The program needs to process multiple rows one by one.
- Each employee requires a different calculation based on department.
- This row-by-row logic cannot be handled easily with a single SQL statement.

--------------------------------------------------

PL/SQL CODE:
*/

DECLARE
    -- Cursor declaration
    CURSOR emp_cursor IS
        SELECT employee_id, first_name, salary, department_id
        FROM employees;

    -- Variables to store fetched data
    v_emp_id employees.employee_id%TYPE;
    v_emp_name employees.first_name%TYPE;
    v_salary employees.salary%TYPE;
    v_dept employees.department_id%TYPE;
    v_bonus NUMBER;

BEGIN
    -- Open cursor
    OPEN emp_cursor;

    LOOP
        -- Fetch data
        FETCH emp_cursor INTO v_emp_id, v_emp_name, v_salary, v_dept;
        EXIT WHEN emp_cursor%NOTFOUND;

        -- Apply bonus logic
        IF v_dept = 10 THEN
            v_bonus := v_salary * 0.10;
        ELSIF v_dept = 20 THEN
            v_bonus := v_salary * 0.15;
        ELSE
            v_bonus := v_salary * 0.05;
        END IF;

        -- Display result
        DBMS_OUTPUT.PUT_LINE('Employee: ' || v_emp_name || 
                             ' | Bonus: ' || v_bonus);
    END LOOP;

    -- Close cursor
    CLOSE emp_cursor;
END;
/


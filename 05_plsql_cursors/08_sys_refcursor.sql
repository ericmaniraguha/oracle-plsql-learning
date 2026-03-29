/*
PL/SQL function that calculates annual salaries for all employees in department 3 and
 returns a result set with full name, monthly salary, and annual salary. 

PL/SQL Function Creation
*/

-- Step 1: Create the function
CREATE OR REPLACE FUNCTION get_annual_salaries(p_dept_id IN NUMBER)
RETURN SYS_REFCURSOR
IS
    emp_cursor SYS_REFCURSOR;
BEGIN
    -- Open cursor for employees in the given department
    OPEN emp_cursor FOR
        SELECT 
            first_name || ' ' || last_name AS full_name,
            salary AS monthly_salary,
            salary * 12 AS annual_salary
        FROM employees
        WHERE department_id = p_dept_id;
    
    RETURN emp_cursor;
END;
/

/*
Explanation:
1. `p_dept_id IN NUMBER`: input parameter for department ID.
2. `SYS_REFCURSOR`: allows returning a result set.
3. `first_name || ' ' || last_name`: concatenates first and last names.
4. `salary * 12`: calculates annual salary. 
*/


/*

2. Displaying the Result
Display the output by calling the function in an anonymous PL/SQL block:

*/

SET SERVEROUTPUT ON

DECLARE
    v_cursor SYS_REFCURSOR;
    v_full_name employees.first_name%TYPE;
    v_monthly_salary employees.salary%TYPE;
    v_annual_salary NUMBER(30,2);
BEGIN
    -- Call the function for department ID 3
    v_cursor := get_annual_salaries(90);

    -- Loop through the cursor to display results
    LOOP
        FETCH v_cursor INTO v_full_name, v_monthly_salary, v_annual_salary;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(
            'Name: ' || v_full_name ||
            ', Monthly Salary: ' || v_monthly_salary ||
            ', Annual Salary: ' || v_annual_salary
        );
    END LOOP;

    CLOSE v_cursor;
END;
/




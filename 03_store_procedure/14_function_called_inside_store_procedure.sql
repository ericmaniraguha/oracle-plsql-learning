
-- This PL/SQL procedure `display_ann_salary` retrieves employee details (name, department, and salary), calculates the annual salary using a function, and displays the results.


/*
1. How can we retrieve an employee’s full name, department, and salary using a JOIN?

2. How do we calculate annual salary from a monthly salary using a function?

3. How can we display results in PL/SQL using DBMS_OUTPUT?

4. How do we handle cases where the employee ID does not exist?

5. How can we test a stored procedure using:
   - Direct EXEC call
   - Anonymous block
   - Multiple test inputs

6. How can we structure clean and readable PL/SQL code with proper variables?
*/

---

-- 1. Function to calculate annual salary
CREATE OR REPLACE FUNCTION calc_ann_salary(p_salary NUMBER)
RETURN NUMBER
IS
BEGIN
    RETURN p_salary * 12;
END;
/

---

-- 2. Procedure Implementation

CREATE OR REPLACE PROCEDURE display_ann_salary(
    p_emp_id NUMBER   -- Input parameter: Employee ID
)
IS 
    v_annual_salary NUMBER;        -- Stores computed annual salary
    v_names VARCHAR2(100);         -- Stores employee full name
    v_monthly_salary NUMBER;       -- Stores monthly salary
    v_dept_name VARCHAR2(50);      -- Stores department name

BEGIN 

    -- Retrieve employee details using JOIN
    SELECT e.first_name || ' ' || e.last_name, 
           d.department_name,  
           e.salary 
    INTO v_names,
         v_dept_name, 
         v_monthly_salary
    FROM employees e
    JOIN departments d
        ON e.department_id = d.department_id
    WHERE employee_id = p_emp_id;

    -- Calculate annual salary using function
    v_annual_salary := calc_ann_salary(v_monthly_salary);
    
    -- Display results
    DBMS_OUTPUT.PUT_LINE('Employee Name       : ' || v_names);
    DBMS_OUTPUT.PUT_LINE('Department          : ' || v_dept_name);
    DBMS_OUTPUT.PUT_LINE('Monthly Salary      : ' || v_monthly_salary);
    DBMS_OUTPUT.PUT_LINE('Annual Salary       : ' || v_annual_salary);

-- Exception handling
EXCEPTION 
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No such Employee ID');
END;
/

--- 3. Test Cases

-- Enable output
SET SERVEROUTPUT ON;

-- 3.1. Direct Execution
EXEC display_ann_salary(250);
EXECUTE display_ann_salary(100);

-- 3.2. Anonymous Block (Multiple Tests)
DECLARE 
    v_salary NUMBER := 45;
    v_salary_120 NUMBER := 120;
    v_salary_200 NUMBER := 200;
BEGIN
    display_ann_salary(v_salary);

    DBMS_OUTPUT.PUT_LINE('------------------------------------------');

    display_ann_salary(v_salary_120);

    DBMS_OUTPUT.PUT_LINE('------------------------------------------');

    display_ann_salary(v_salary_200);
END;
/

---  Expected Results (Answers)

-- If employee exists:
--    - Full name is displayed
--    - Department name is shown
--    - Monthly salary is printed
--    - Annual salary is calculated and displayed

-- If employee does NOT exist:
--    Output:
--    No such Employee ID

---  Key Concepts

-- JOIN between tables (employees & departments)
-- SELECT INTO for single-row retrieval
-- Calling user-defined functions
-- DBMS_OUTPUT for displaying results
-- Exception handling (NO_DATA_FOUND)
-- Procedure testing methods

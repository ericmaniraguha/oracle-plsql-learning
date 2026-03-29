/*
Transform your function to use **bulk collection**, which fetches all rows at once into a collection and then processes them. 
This is usually **faster** than fetching row by row. 
*/

/*
1. Create a SQL Object and Collection Types
First, define an object type for each employee’s salary info and a nested table type to hold all employees:
*/
-- Object type to store employee salary info
CREATE OR REPLACE TYPE emp_salary_obj AS OBJECT (
    full_name       VARCHAR2(100),
    monthly_salary  NUMBER,
    annual_salary   NUMBER
);

-- Nested table type to hold multiple employee salary objects
CREATE OR REPLACE TYPE emp_salary_table AS TABLE OF emp_salary_obj;

/*
 Function Using Bulk Collect
 */


CREATE OR REPLACE FUNCTION get_annual_salaries_bulk(p_dept_id IN NUMBER)
RETURN emp_salary_table
IS
    -- Collection to store all employees
    emp_salaries emp_salary_table;

BEGIN
    -- Bulk collect all rows from employees table
    SELECT 
        first_name || ' ' || last_name AS full_name,
        salary AS monthly_salary,
        salary * 12 AS annual_salary
    BULK COLLECT INTO emp_salaries
    FROM employees
    WHERE department_id = p_dept_id;

    -- Return the collection
    RETURN emp_salaries;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN emp_salary_table(); -- Return empty table if no rows
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN emp_salary_table();
END;
/

/*
* `BULK COLLECT INTO` fetches all rows at once into the `emp_salaries` collection.
* No explicit cursor loop is needed.
* Returns a nested table of employee salary objects.
*/


/*
3. Displaying the Results**
*/
DECLARE
    v_emp_salaries emp_salary_table;
BEGIN
    -- Get all salaries for department 3
    v_emp_salaries := get_annual_salaries_bulk(3);

    -- Loop through the collection
    FOR i IN 1 .. v_emp_salaries.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Name: ' || v_emp_salaries(i).full_name ||
            ', Monthly Salary: ' || v_emp_salaries(i).monthly_salary ||
            ', Annual Salary: ' || v_emp_salaries(i).annual_salary
        );
    END LOOP;
END;
/

-- This approach **uses bulk collection**, avoids row-by-row fetching, and is much more efficient for large datasets.



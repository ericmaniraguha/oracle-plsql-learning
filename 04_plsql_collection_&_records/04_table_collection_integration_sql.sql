--Table + Collection Integration (Nested Table of Records)

SET SERVEROUTPUT ON;

DECLARE
    -- Step 1: Define a record type matching table structure
    TYPE emp_rec_type IS RECORD (
        emp_id employees.employee_id%TYPE,
        emp_name employees.first_name%TYPE,
        salary employees.salary%TYPE
    );

    -- Step 2: Define a nested table to hold multiple employee records
    TYPE emp_table_type IS TABLE OF emp_rec_type;
    emp_list emp_table_type;
    
BEGIN
    -- Step 3: Fetch employees with salary > 5000 into the nested table
    SELECT employee_id, first_name, salary
    BULK COLLECT INTO emp_list
    FROM employees
    WHERE salary > 5000;

    -- Step 4: Loop through nested table to display each employee
    FOR i IN 1..emp_list.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Name: ' || emp_list(i).emp_name || ', Salary: ' || emp_list(i).salary
        );
    END LOOP;
END;
/
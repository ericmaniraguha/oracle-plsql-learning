DECLARE
    -- Step 1: Define a record type
    TYPE emp_rec_type IS RECORD (
        first_name employees.first_name%TYPE,
        last_name  employees.last_name%TYPE,
        salary     employees.salary%TYPE
    );
    
    -- Step 2: Define a collection (table of records)
    TYPE emp_table_type IS TABLE OF emp_rec_type;
    
    -- Step 3: Declare a collection variable
    emp_table emp_table_type;
BEGIN
    -- Step 4: Bulk collect rows into the collection
    SELECT first_name, last_name, salary
    BULK COLLECT INTO emp_table
    FROM employees
    WHERE department_id = 10; -- fetch multiple rows
    
    -- Step 5: Loop through the collection
    FOR i IN 1..emp_table.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(emp_table(i).first_name || ' ' || emp_table(i).last_name || ' earns ' || emp_table(i).salary);
    END LOOP;
END;

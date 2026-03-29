/*
Exercise: PL/SQL Records and Collections

Instructions:
1. Read each question.
2. Write the PL/SQL block or code snippet requested.
3. Answers are provided in comments (.......).
*/

-- 1. Define and use a record to store one employee's details
DECLARE
    -- Define a record type for an employee
    TYPE emp_record_type IS RECORD (
        emp_id     employees.employee_id%TYPE,
        first_name employees.first_name%TYPE,
        last_name  employees.last_name%TYPE,
        salary     employees.salary%TYPE
    );

    -- Declare a variable of this record type
    emp_rec emp_record_type;
BEGIN
    -- Fetch one employee into the record
    SELECT employee_id, first_name, last_name, salary
    INTO emp_rec
    FROM employees
    WHERE employee_id = 101;

    -- Access record fields
    DBMS_OUTPUT.PUT_LINE('Employee: ' || emp_rec.first_name || ' ' || emp_rec.last_name || 
                         ' - Salary: ' || emp_rec.salary);

    /*
    Expected output example:
    Employee: John Doe - Salary: 5000
    */
END;
/

-- 2. Create an associative array and loop through it
DECLARE
    TYPE salary_table IS TABLE OF employees.salary%TYPE INDEX BY PLS_INTEGER;
    salaries salary_table;
BEGIN
    -- Store some salary values
    salaries(1) := 5000;
    salaries(2) := 6000;
    salaries(3) := 7000;

    -- Loop through collection
    FOR i IN 1..3 LOOP
        DBMS_OUTPUT.PUT_LINE('Salary ' || i || ': ' || salaries(i));
    END LOOP;

    /*
    Expected output:
    Salary 1: 5000
    Salary 2: 6000
    Salary 3: 7000
    */
END;
/

-- 3. Create a nested table of names
DECLARE
    TYPE name_list IS TABLE OF employees.first_name%TYPE;
    names name_list;
BEGIN
    -- Assign values
    names := name_list('Alice', 'Bob', 'Charlie');

    -- Loop through nested table
    FOR i IN 1..names.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Employee Name: ' || names(i));
    END LOOP;

    /*
    Expected output:
    Employee Name: Alice
    Employee Name: Bob
    Employee Name: Charlie
    */
END;
/

-- 4. Create a VARRAY of salaries
DECLARE
    TYPE salary_varray IS VARRAY(5) OF employees.salary%TYPE;
    salaries salary_varray := salary_varray(4000, 5000, 6000);
BEGIN
    FOR i IN 1..salaries.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Salary ' || i || ': ' || salaries(i));
    END LOOP;

    /*
    Expected output:
    Salary 1: 4000
    Salary 2: 5000
    Salary 3: 6000
    */
END;
/

-- 5. Collection of records using BULK COLLECT
DECLARE
    TYPE emp_rec_type IS RECORD (
        emp_id employees.employee_id%TYPE,
        name   employees.first_name%TYPE
    );

    TYPE emp_table_type IS TABLE OF emp_rec_type;
    emp_table emp_table_type;
BEGIN
    -- Fetch multiple rows into the collection
    SELECT employee_id, first_name BULK COLLECT INTO emp_table
    FROM employees
    WHERE ROWNUM <= 5;

    -- Loop through collection
    FOR i IN 1..emp_table.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || emp_table(i).emp_id || 
                             ', Name: ' || emp_table(i).name);
    END LOOP;

    /*
    Expected output example (first 5 employees):
    Employee ID: 101, Name: John
    Employee ID: 102, Name: Alice
    Employee ID: 103, Name: Bob
    Employee ID: 104, Name: Mary
    Employee ID: 105, Name: James
    */
END;
/
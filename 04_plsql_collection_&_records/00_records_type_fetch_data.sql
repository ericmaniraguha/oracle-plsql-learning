DECLARE
    -- Define a custom record type
    TYPE emp_rec_type IS RECORD (
        first_name employees.first_name%TYPE,
        last_name  employees.last_name%TYPE,
        salary     employees.salary%TYPE
    );
    
    -- Declare a variable of that record type
    emp_rec emp_rec_type;
BEGIN
    -- Fill the record variable
    SELECT first_name, last_name, salary
    INTO emp_rec.first_name, emp_rec.last_name, emp_rec.salary
    FROM employees
    WHERE employee_id = 101;
    
    DBMS_OUTPUT.PUT_LINE(emp_rec.first_name || ' ' || emp_rec.last_name || ' earns ' || emp_rec.salary);
END;

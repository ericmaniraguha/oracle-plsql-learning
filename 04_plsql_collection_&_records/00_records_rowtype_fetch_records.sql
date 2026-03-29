DECLARE
    emp_rec employees%ROWTYPE;
BEGIN
    SELECT * INTO emp_rec
    FROM employees
    WHERE employee_id = 101;
    
    DBMS_OUTPUT.PUT_LINE(emp_rec.first_name || ' ' || emp_rec.last_name);
    
    -- SQL%ROWCOUNT after SELECT INTO will always be 1
    DBMS_OUTPUT.PUT_LINE('Rows fetched: ' || SQL%ROWCOUNT);
END;
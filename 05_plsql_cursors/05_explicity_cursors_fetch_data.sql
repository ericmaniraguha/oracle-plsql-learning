DECLARE
    CURSOR c_emp IS SELECT employee_id, first_name FROM employees WHERE department_id = 30;
    v_id employees.employee_id%TYPE;
    v_name employees.first_name%TYPE;
BEGIN
    OPEN c_emp;
    DBMS_OUTPUT.PUT_LINE('Cursor open? ' || CASE WHEN c_emp%ISOPEN THEN 'Yes' ELSE 'No' END);
    
    LOOP
        FETCH c_emp INTO v_id, v_name;
        EXIT WHEN c_emp%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Fetched row count: ' || c_emp%ROWCOUNT);
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_id || ', Name: ' || v_name);
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Cursor open after loop? ' || CASE WHEN c_emp%ISOPEN THEN 'Yes' ELSE 'No' END);
    CLOSE c_emp;
END;
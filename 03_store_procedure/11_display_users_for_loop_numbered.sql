
CREATE OR REPLACE PROCEDURE list_employees_by_min_id (
    p_min_id IN NUMBER  -- input parameter
)
AS
    row_number NUMBER := 1;  -- counter to number each row
BEGIN
    -- Loop over the SELECT statement with input parameter filter
    FOR rec IN (SELECT employee_id, first_name, last_name 
                FROM employees
                WHERE employee_id >= p_min_id
                ORDER BY employee_id) LOOP
        DBMS_OUTPUT.PUT_LINE(row_number || ': ' 
                             || rec.employee_id || ' - ' 
                             || rec.first_name || ' ' 
                             || rec.last_name);
        row_number := row_number + 1;  -- increment the counter
    END LOOP;
END;
/


-- Test the store procedure

BEGIN
    list_employees_by_min_id(100);  -- replace 100 with your desired min employee_id
END;
/


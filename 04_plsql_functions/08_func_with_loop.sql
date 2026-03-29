DECLARE
    counter NUMBER;
BEGIN
    -- get total number of employees
    SELECT COUNT(*) INTO counter FROM employees;

    FOR rec IN (
        SELECT employee_id, first_name, last_name
        FROM employees
        ORDER BY employee_id  -- normal order
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(counter || '. ' ||
            rec.employee_id || ' - ' ||
            rec.first_name || ' ' ||
            rec.last_name
        );

        counter := counter - 1;  -- count down
    END LOOP;
END;
/
SET SERVEROUTPUT ON;

DECLARE
    v_new_salary NUMBER;
BEGIN
    -- Loop through all managers and update their salaries
    FOR rec IN (SELECT employee_id, salary
                FROM employees
                WHERE job_id = 'MANAGER')  -- Assuming job_id for managers
    LOOP
        -- Call the function to calculate new salary (2% increment)
        v_new_salary := calculate_new_salary(rec.salary, 0.02);

        -- Update salary in the table
        UPDATE employees
        SET salary = v_new_salary
        WHERE employee_id = rec.employee_id;

        DBMS_OUTPUT.PUT_LINE('Updated Employee ID ' || rec.employee_id || 
                             ' from ' || rec.salary || ' to ' || v_new_salary);
    END LOOP;
    
    -- Commit changes
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
        ROLLBACK;
END;
/
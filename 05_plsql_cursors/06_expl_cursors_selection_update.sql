SET SERVEROUTPUT ON SIZE 100000;

DECLARE
    CURSOR c_emp IS SELECT employee_id, salary FROM employees WHERE department_id = 30;
    v_id employees.employee_id%TYPE;
    v_salary employees.salary%TYPE;
BEGIN
    OPEN c_emp;
    LOOP
        FETCH c_emp INTO v_id, v_salary;
        EXIT WHEN c_emp%NOTFOUND;

        -- Example: Update salary
        BEGIN
            UPDATE employees
            SET salary = salary * 1.1
            WHERE employee_id = v_id;

            -- Simulate error
            IF v_id = 207 THEN
                RAISE_APPLICATION_ERROR(-20001, 'Demo rollback on employee 207');
            END IF;

        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error occurred, rolling back for employee ' || v_id);
                ROLLBACK;  -- undoes all updates so far
        END;
    END LOOP;
    CLOSE c_emp;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('All updates processed successfully!');
END;
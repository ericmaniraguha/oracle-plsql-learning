SET SERVEROUTPUT ON;

-- ========================================================
-- Procedure: update_salary_by_role
-- Purpose: Update salaries for employees of a specific role
--          and display old vs new salaries
-- Parameters:
--   p_job_role  -> Job role to filter employees (e.g., 'MANAGER')
--   p_increment -> Salary increment rate as a decimal (0.02 = 2%)
-- ========================================================

CREATE OR REPLACE PROCEDURE update_salary_by_role (
    p_job_role  IN VARCHAR2,
    p_increment IN NUMBER
)
IS
    -- Variables to hold old and new salary
    v_old_salary NUMBER;
    v_new_salary NUMBER;

    -- Summary counters
    v_count_updated NUMBER := 0;
    v_total_old     NUMBER := 0;
    v_total_new     NUMBER := 0;

BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Updating salaries for role: ' || p_job_role || ' ---');

    -- Loop through employees of the given role
    FOR rec IN (SELECT employee_id, salary
                FROM employees
                WHERE job_id = p_job_role)
    LOOP
        v_old_salary := rec.salary;

        -- Calculate new salary using the function
        v_new_salary := calculate_new_salary(v_old_salary, p_increment);

        -- Update the employee's salary
        UPDATE employees
        SET salary = v_new_salary
        WHERE employee_id = rec.employee_id;

        -- Display old and new salaries
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || rec.employee_id ||
                             ' | Old Salary: ' || v_old_salary ||
                             ' | New Salary: ' || v_new_salary);

        -- Update summary
        v_count_updated := v_count_updated + 1;
        v_total_old     := v_total_old + v_old_salary;
        v_total_new     := v_total_new + v_new_salary;
    END LOOP;

    -- Commit all changes
    COMMIT;

    -- Display summary
    DBMS_OUTPUT.PUT_LINE('--- Summary ---');
    DBMS_OUTPUT.PUT_LINE('Total employees updated: ' || v_count_updated);
    DBMS_OUTPUT.PUT_LINE('Total of old salaries: ' || v_total_old);
    DBMS_OUTPUT.PUT_LINE('Total of new salaries: ' || v_total_new);

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
        ROLLBACK;
END update_salary_by_role;
/

-- Test procedure 
BEGIN
    update_salary_by_role('IT_PROG', 0.02);
    update_salary_by_role('FI_MGR', 0.02);
    update_salary_by_role('SA_REP', 0.02);
END;
/


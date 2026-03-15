-- ========================================================
-- Exercise 9: Job History Entry with Exception Handling
-- ========================================================
DECLARE
    v_emp_id employees.employee_id%TYPE := 101; -- example employee
    v_start_date DATE := TO_DATE('2026-01-01','YYYY-MM-DD');
    v_end_date DATE := TO_DATE('2026-03-31','YYYY-MM-DD');
    v_job_id jobs.job_id%TYPE := 'IT_PROG';
    v_dept_id departments.department_id%TYPE := 60;

    -- User-defined exception
    e_invalid_dates EXCEPTION;
BEGIN
    -- Validate dates
    IF v_end_date < v_start_date THEN
        RAISE e_invalid_dates;
    END IF;

    -- Insert job history record
    INSERT INTO job_history(employee_id, start_date, end_date, job_id, department_id)
    VALUES(v_emp_id, v_start_date, v_end_date, v_job_id, v_dept_id);

    DBMS_OUTPUT.PUT_LINE('Job history inserted for employee ID ' || v_emp_id);
    COMMIT;

EXCEPTION
    -- User-defined exception handler
    WHEN e_invalid_dates THEN
        DBMS_OUTPUT.PUT_LINE('Error: End date cannot be earlier than start date.');

    -- Predefined exceptions
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Error: Duplicate job history entry for this employee.');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Employee or department does not exist.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
END;
/
-- ========================================================
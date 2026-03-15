
-- ========================================================
-- Exercise 9: Job History Entry
-- ========================================================
-- Question:
-- Insert a new job history record for an employee and print confirmation.
DECLARE
    v_emp_id employees.employee_id%TYPE := 101; -- example employee
    v_start_date DATE := TO_DATE('2026-01-01','YYYY-MM-DD');
    v_end_date DATE := TO_DATE('2026-03-31','YYYY-MM-DD');
    v_job_id jobs.job_id%TYPE := 'IT_PROG';
    v_dept_id departments.department_id%TYPE := 60;
BEGIN
    INSERT INTO job_history(employee_id, start_date, end_date, job_id, department_id)
    VALUES(v_emp_id, v_start_date, v_end_date, v_job_id, v_dept_id);

    DBMS_OUTPUT.PUT_LINE('Job history inserted for employee ID ' || v_emp_id);
    COMMIT;
END;

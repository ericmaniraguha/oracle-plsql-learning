CREATE OR REPLACE PROCEDURE get_salary_statistics(
    p_department_id    IN NUMBER,
    p_start_date       IN DATE,
    p_end_date         IN DATE,
    p_salary_threshold IN NUMBER
)
IS
    v_total_salary      NUMBER := 0;
    v_average_salary    NUMBER := 0;
    v_employee_count    NUMBER := 0;
    v_rows_above_thresh NUMBER := 0;
    v_salary_message    VARCHAR2(400);
BEGIN
    -- Calculate total salary
    SELECT NVL(SUM(salary), 0)
    INTO v_total_salary
    FROM employees
    WHERE department_id = p_department_id
      AND hire_date BETWEEN p_start_date AND p_end_date;

    -- Calculate average salary
    SELECT NVL(AVG(salary), 0)
    INTO v_average_salary
    FROM employees
    WHERE department_id = p_department_id
      AND hire_date BETWEEN p_start_date AND p_end_date;

    -- Count employees in the period
    SELECT COUNT(*)
    INTO v_employee_count
    FROM employees
    WHERE department_id = p_department_id
      AND hire_date BETWEEN p_start_date AND p_end_date;

    -- Count employees above salary threshold
    SELECT COUNT(*)
    INTO v_rows_above_thresh
    FROM employees
    WHERE department_id = p_department_id
      AND hire_date BETWEEN p_start_date AND p_end_date
      AND salary > p_salary_threshold;

    -- Check if any employees exist in the period
    IF v_employee_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No employees found in department ' || p_department_id || ' for the given date range.');
        RETURN;
    END IF;

    -- Prepare result message
    v_salary_message := 'Department ' || p_department_id || ': ' ||
                        'Total Salary = ' || v_total_salary || ', ' ||
                        'Average Salary = ' || ROUND(v_average_salary, 2) || ', ' ||
                        'Employees above salary threshold (' || p_salary_threshold || '): ' || v_rows_above_thresh || ', ' ||
                        'Total Employees Processed: ' || v_employee_count;

    -- Output the message
    DBMS_OUTPUT.PUT_LINE(v_salary_message);

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/

/*
Test department 30, from 01-JAN-2023 to 31-DEC-2023, salary threshold 5000
*/
SET SERVEROUTPUT ON;

BEGIN
    get_salary_statistics(
        p_department_id    => 30,
        p_start_date       => TO_DATE('2023-01-01', 'YYYY-MM-DD'),
        p_end_date         => TO_DATE('2023-12-31', 'YYYY-MM-DD'),
        p_salary_threshold => 5000
    );
END;
/
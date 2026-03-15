SET SERVEROUTPUT ON;

-- 1. Insert sample employee
INSERT INTO employees (
    employee_id, first_name, last_name, email, phone_number,
    hire_date, job_id, salary, commission_pct, manager_id,
    department_id, bonus
) VALUES (
    114, 'John', 'Doe', 'john.doe@example.com', '123-456-7890',
    TO_DATE('01-01-2006','DD-MM-YYYY'), 'ST_CLERK', 5000, 0, 101,
    50, 1000
);

-- Optional: Insert job history
INSERT INTO job_history (
    employee_id, start_date, end_date, job_id, department_id
) VALUES (
    114, TO_DATE('24-03-2006','DD-MM-YYYY'), TO_DATE('31-12-2007','DD-MM-YYYY'),
    'ST_CLERK', 50
);

COMMIT;

BEGIN
    update_employee_bonus(114, 1500);
END;/
SET SERVEROUTPUT ON;

-- 1. Insert a sample employee
INSERT INTO employees (
    employee_id,
    first_name,
    last_name,
    email,
    phone_number,
    hire_date,
    job_id,
    salary,
    commission_pct,
    manager_id,
    department_id,
    bonus
) VALUES (
    114,
    'John',
    'Doe',
    'john.doe@example.com',
    '123-456-7890',
    TO_DATE('01-01-2006','DD-MM-YYYY'),
    'ST_CLERK',
    5000,
    0,
    101,
    50,
    1000
);
COMMIT;

-- 2. Insert corresponding job_history (optional for demonstration)
INSERT INTO job_history (
    employee_id,
    start_date,
    end_date,
    job_id,
    department_id
) VALUES (
    114,
    TO_DATE('24-03-2006','DD-MM-YYYY'),
    TO_DATE('31-12-2007','DD-MM-YYYY'),
    'ST_CLERK',
    50
);
COMMIT;

-- 3. Create procedure to update bonus with SAVEPOINT
CREATE OR REPLACE PROCEDURE update_employee_bonus (
    p_emp_id IN NUMBER,
    p_bonus  IN NUMBER
)
AS
    v_current_bonus NUMBER;
    v_job_id        job_history.job_id%TYPE;
    v_dept_id       job_history.department_id%TYPE;
BEGIN
    -- Get current bonus
    SELECT bonus
    INTO v_current_bonus
    FROM employees
    WHERE employee_id = p_emp_id;

    -- Get job info from job_history
    SELECT job_id, department_id
    INTO v_job_id, v_dept_id
    FROM job_history
    WHERE employee_id = p_emp_id
      AND ROWNUM = 1;

    -- Create a savepoint before updating
    SAVEPOINT before_update;

    -- Update bonus
    UPDATE employees
    SET bonus = p_bonus
    WHERE employee_id = p_emp_id;

    -- Check if update affected any row
    IF SQL%ROWCOUNT = 0 THEN
        ROLLBACK TO before_update;
        RAISE_APPLICATION_ERROR(-20002, 'Error: Employee ID ' || p_emp_id || ' does not exist.');
    END IF;

    -- Commit changes
    COMMIT;

    -- Output info
    DBMS_OUTPUT.PUT_LINE('Employee ID: ' || p_emp_id ||
                         ' | Old Bonus: ' || NVL(v_current_bonus,0) ||
                         ' | New Bonus: ' || p_bonus ||
                         ' | Job: ' || v_job_id ||
                         ' | Dept: ' || v_dept_id);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK TO before_update;
        DBMS_OUTPUT.PUT_LINE('Error: Employee ID ' || p_emp_id || ' not found in job_history.');

    WHEN VALUE_ERROR THEN
        ROLLBACK TO before_update;
        DBMS_OUTPUT.PUT_LINE('Error: Invalid bonus value.');

    WHEN OTHERS THEN
        ROLLBACK TO before_update;
        DBMS_OUTPUT.PUT_LINE('Unexpected Error: ' || SQLERRM);
END;
/
select * from employees;
INSERT INTO employees (employee_id, bonus) VALUES (114, 1000);
COMMIT;
SET SERVEROUTPUT ON;

-- Procedure to update employee bonus with savepoint and rollback
CREATE OR REPLACE PROCEDURE update_employee_bonus (
    p_emp_id IN NUMBER,
    p_bonus  IN NUMBER
)
AS
    v_current_bonus NUMBER;
    v_job_id        job_history.job_id%TYPE;
    v_dept_id       job_history.department_id%TYPE;
BEGIN
    -- Check current bonus
    SELECT bonus
    INTO v_current_bonus
    FROM employees
    WHERE employee_id = p_emp_id;

    -- Optional: get job info from job_history
    SELECT job_id, department_id
    INTO v_job_id, v_dept_id
    FROM job_history
    WHERE employee_id = p_emp_id
      AND ROWNUM = 1;  -- in case of multiple rows

    -- Savepoint before updating
    SAVEPOINT before_update;

    -- Update the bonus
    UPDATE employees
    SET bonus = p_bonus
    WHERE employee_id = p_emp_id;

    -- Check if the employee exists
    IF SQL%ROWCOUNT = 0 THEN
        ROLLBACK TO before_update;
        RAISE_APPLICATION_ERROR(-20002,
            'Error: Employee ID ' || p_emp_id || ' does not exist.');
    END IF;

    -- Commit the change
    COMMIT;

    -- Display info
    DBMS_OUTPUT.PUT_LINE('Employee ID: ' || p_emp_id ||
                         ' | Old Bonus: ' || NVL(v_current_bonus,0) ||
                         ' | New Bonus: ' || p_bonus ||
                         ' | Job: ' || v_job_id ||
                         ' | Dept: ' || v_dept_id);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK TO before_update;
        DBMS_OUTPUT.PUT_LINE('Error: Employee ID ' || p_emp_id || ' not found in job_history.');

    WHEN VALUE_ERROR THEN
        ROLLBACK TO before_update;
        DBMS_OUTPUT.PUT_LINE('Error: Invalid bonus value.');

    WHEN OTHERS THEN
        ROLLBACK TO before_update;
        DBMS_OUTPUT.PUT_LINE('Unexpected Error: ' || SQLERRM);
END;
/
-- 2. Procedure to update bonus with SAVEPOINT
CREATE OR REPLACE PROCEDURE update_employee_bonus (
    p_emp_id IN NUMBER,
    p_bonus  IN NUMBER
) AS
    v_current_bonus employees.bonus%TYPE;
    v_job_id        job_history.job_id%TYPE;
    v_dept_id       job_history.department_id%TYPE;
BEGIN
    -- Get current bonus
    SELECT bonus INTO v_current_bonus
    FROM employees
    WHERE employee_id = p_emp_id;

    -- Get job info (first record from history)
    SELECT job_id, department_id INTO v_job_id, v_dept_id
    FROM job_history
    WHERE employee_id = p_emp_id
      AND ROWNUM = 1;

    -- Savepoint before update
    SAVEPOINT before_update;

    -- Update bonus
    UPDATE employees
    SET bonus = p_bonus
    WHERE employee_id = p_emp_id;

    IF SQL%ROWCOUNT = 0 THEN
        ROLLBACK TO before_update;
        RAISE_APPLICATION_ERROR(-20002, 'Error: Employee ID ' || p_emp_id || ' not found.');
    END IF;

    COMMIT;

    -- Output result
    DBMS_OUTPUT.PUT_LINE(
        'Employee ID: ' || p_emp_id ||
        ' | Old Bonus: ' || NVL(v_current_bonus,0) ||
        ' | New Bonus: ' || p_bonus ||
        ' | Job: ' || v_job_id ||
        ' | Dept: ' || v_dept_id
    );

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK TO before_update;
        DBMS_OUTPUT.PUT_LINE('Error: Employee ID ' || p_emp_id || ' not found in job_history.');
    WHEN VALUE_ERROR THEN
        ROLLBACK TO before_update;
        DBMS_OUTPUT.PUT_LINE('Error: Invalid bonus value.');
    WHEN OTHERS THEN
        ROLLBACK TO before_update;
        DBMS_OUTPUT.PUT_LINE('Unexpected Error: ' || SQLERRM);
END;
/
-- 3. Test the procedure4
SET SERVEROUTPUT ON;

BEGIN
    update_employee_bonus(114, 1500);
END;
/

-- 4. Verify update
SELECT employee_id, first_name, last_name, bonus
FROM employees
WHERE employee_id = 114;
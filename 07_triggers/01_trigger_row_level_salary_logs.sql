-- 1. Drop previous audit table if exists (optional cleanup)
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE salary_audit';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN -- -942 = table does not exist
            RAISE;
        END IF;
END;
/

-- 2. Create audit table
CREATE TABLE salary_audit (
    employee_id NUMBER,
    old_salary NUMBER,
    new_salary NUMBER,
    change_date DATE
);

-- 3. Create the row-level trigger with exception handling
CREATE OR REPLACE TRIGGER log_salary_changes
AFTER UPDATE ON employees
FOR EACH ROW
WHEN (OLD.salary != NEW.salary)
DECLARE
    v_dummy NUMBER;
BEGIN
    BEGIN
        INSERT INTO salary_audit (employee_id, old_salary, new_salary, change_date)
        VALUES (:OLD.employee_id, :OLD.salary, :NEW.salary, SYSDATE);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error logging salary change for employee ' || :OLD.employee_id || ': ' || SQLERRM);
    END;
END;
/

-- 4. Optional: Insert sample employees if your table is empty

-- 5. Update salaries to trigger the audit
UPDATE employees
SET salary = salary + 500;

-- Make changes permanent
COMMIT;

-- 6. Query the audit table to see the logged changes
SELECT * FROM salary_audit;
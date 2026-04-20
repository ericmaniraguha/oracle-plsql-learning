/*
Question:
Create a package that demonstrates encapsulation using an employees table.

The package should:
1. Have a public procedure to display an employee salary
2. Have a public function to calculate annual salary
3. Have a private function to calculate bonus
4. Show that the private function cannot be called outside the package
*/

--====================================================
-- Package Specification
--====================================================
CREATE OR REPLACE PACKAGE employee_pkg IS

                /*Public Store Procedure
                A procedure that takes an employee ID
                It will display or process the employee’s salary
                It does NOT return a value
                */
    PROCEDURE show_salary(p_employee_id NUMBER);
         
                /* Public Function
                A function that takes an employee ID
                It returns a NUMBER (annual salary)
                The logic is defined in the package body
                */
    FUNCTION annual_salary(p_employee_id NUMBER) RETURN NUMBER;
-- END of specification
END employee_pkg;
/
--====================================================
-- Package Body
--====================================================
CREATE OR REPLACE PACKAGE BODY employee_pkg IS

    -- Private function
    FUNCTION calculate_bonus(p_salary NUMBER) RETURN NUMBER IS
    BEGIN
        RETURN p_salary * 0.10;
    END calculate_bonus;

    -- Public procedure
    PROCEDURE show_salary(p_employee_id NUMBER) IS
        v_salary NUMBER;
    BEGIN
        SELECT salary
        INTO v_salary
        FROM employees
        WHERE employee_id = p_employee_id;

        DBMS_OUTPUT.PUT_LINE('Salary: ' || v_salary);
    END show_salary;

    -- Public function
    FUNCTION annual_salary(p_employee_id NUMBER) RETURN NUMBER IS
        v_salary NUMBER;
    BEGIN
        SELECT salary
        INTO v_salary
        FROM employees
        WHERE employee_id = p_employee_id;

        RETURN (v_salary * 12) + calculate_bonus(v_salary);
    END annual_salary;

END employee_pkg;
/

SET SERVEROUTPUT ON;

-- Call the public procedure
BEGIN
    employee_pkg.show_salary(1);
END;
/

-- Call the public function
SELECT employee_pkg.annual_salary(25) AS total_salary
FROM dual;

-- This will cause an error because calculate_bonus
-- is private inside the package body
SELECT employee_pkg.calculate_bonus(50000)
FROM dual;


/*Simple analogy

Think of it like a mobile app:

Specification = App buttons (what you can click)
Package body = Code behind the buttons (how it works)
*/
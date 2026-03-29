/* =====================================================
   QUESTION 1: Create a Function
   Create a function calc_annual_salary that:
   - Takes monthly salary as input
   - Returns annual salary
===================================================== */

-- ANSWER
CREATE OR REPLACE FUNCTION calc_annual_salary (
    p_monthly_salary NUMBER
) RETURN NUMBER
IS
BEGIN
    RETURN p_monthly_salary * 12;
END;
/

/* =====================================================
   QUESTION 1: Create a Function
   Create a function calc_annual_salary that:
   - Takes monthly salary as input
   - Returns annual salary
===================================================== */

-- ANSWER
CREATE OR REPLACE FUNCTION calc_annual_salary (
    p_monthly_salary NUMBER
) RETURN NUMBER
IS
BEGIN
    RETURN p_monthly_salary * 12;
END;
/

/* =====================================================
   QUESTION 3: Exception Handling
   Already included in the procedure above:
   - Handles NO_DATA_FOUND
===================================================== */


/* =====================================================
   QUESTION 4: Execute the Procedure
   Call the procedure with employee ID
===================================================== */

-- ANSWER
BEGIN
    show_employee_salary(101);
END;
/



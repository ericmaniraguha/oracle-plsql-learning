/* 
    Procedure Name: list_employees_by_min_id

    Description:
    This procedure retrieves and displays employees whose employee_id 
    is greater than or equal to a given input parameter (p_min_id).
    It also numbers each row using a counter.

    Input Parameter:
    p_min_id - Minimum employee_id to filter records

    Output:
    Displays employee details (ID, First Name, Last Name) using DBMS_OUTPUT
*/

CREATE OR REPLACE PROCEDURE list_employees_by_min_id (
    p_min_id IN NUMBER  -- Input parameter: minimum employee ID
)
AS
    row_number NUMBER := 1;  -- Variable to keep track of row numbering
BEGIN
    /* 
        Loop through employees table:
        - Filters employees with ID >= p_min_id
        - Orders results by employee_id in ascending order
    */
    FOR rec IN (SELECT employee_id, first_name, last_name 
                FROM employees
                WHERE employee_id >= p_min_id
                ORDER BY employee_id) LOOP
        
        -- Print each employee record with a row number
        DBMS_OUTPUT.PUT_LINE(
            row_number || ': ' || 
            rec.employee_id || ' - ' || 
            rec.first_name || ' ' || 
            rec.last_name
        );

        -- Increment the row counter after each iteration
        row_number := row_number + 1;
    END LOOP;

    -- Indicate completion (optional for clarity)
    DBMS_OUTPUT.PUT_LINE('--- End of Employee List ---');

END;
/

/* Enable output display in SQL*Plus or SQL Developer */
SET SERVEROUTPUT ON;

/* Execute the procedure with a sample input value */
BEGIN
    list_employees_by_min_id(5);  -- Change 15 to test different values
END;
/
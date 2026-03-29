/*

Write a PL/SQL procedure to delete a record from the ALLOWANCES table by ID.
Use implicit cursor attributes (SQL%FOUND, SQL%ROWCOUNT, SQL%ISOPEN) to display the result, 
and include exception handling with rollback.

*/


SET SERVEROUTPUT ON SIZE 100000;

CREATE OR REPLACE PROCEDURE delete_allowance(p_allowance_id NUMBER) AS
BEGIN
    -- Attempt to delete a row
    DELETE FROM ALLOWANCES 
    WHERE ALLOWANCE_ID = p_allowance_id;

    -- Check result
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Allowance with ID ' || p_allowance_id || ' deleted successfully.');
        DBMS_OUTPUT.PUT_LINE('Rows deleted: ' || SQL%ROWCOUNT);
    ELSE
        DBMS_OUTPUT.PUT_LINE('No allowance found with ID ' || p_allowance_id);
    END IF;

    -- Check cursor status
    IF SQL%ISOPEN THEN
        DBMS_OUTPUT.PUT_LINE('Cursor is open.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Implicit cursor is closed.');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK; -- undo changes if error occurs
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END;
/

--Test my procedure 

BEGIN
    -- Call the procedure with an example ID
    delete_allowance(101);  -- Replace 101 with the actual ALLOWANCE_ID you want to delete

EXCEPTION
    WHEN OTHERS THEN
        -- Catch any errors that occur during the procedure call
        DBMS_OUTPUT.PUT_LINE('Error calling delete_allowance: ' || SQLERRM);
END;
/

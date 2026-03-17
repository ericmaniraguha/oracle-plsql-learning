-- Enable output display
SET SERVEROUTPUT ON;

DECLARE
    -- Step 1: Define a VARRAY type with a maximum size of 5
    TYPE score_array IS VARRAY(5) OF NUMBER;

    -- Step 2: Initialize the VARRAY with 3 elements
    scores score_array := score_array(80, 90, 85);

    -- Step 3: Procedure with parameter to access a specific index
    PROCEDURE display_score(p_index NUMBER) IS
    BEGIN
        -- Attempt to display the element at the given index
        DBMS_OUTPUT.PUT_LINE(
            'Score at position ' || p_index || ' is: ' || scores(p_index)
        );

    -- Exception handling if index is invalid
    EXCEPTION
        WHEN SUBSCRIPT_BEYOND_COUNT THEN
            DBMS_OUTPUT.PUT_LINE(
                'Error: Index exceeds the number of elements in the VARRAY.'
            );
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Invalid index.');
    END;

BEGIN
    -- Step 4: Call procedure with a valid index
    display_score(2);

    -- Step 5: Call procedure with an invalid index (demonstrates error handling)
    display_score(12);
END;
/
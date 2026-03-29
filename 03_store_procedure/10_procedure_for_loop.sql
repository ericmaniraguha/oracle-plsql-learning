SET SERVEROUTPUT ON;  -- Enables printing output to the console

DECLARE
    start_num NUMBER := &start_value;  -- Accept starting value from user input
    end_num   NUMBER := &end_value;    -- Accept ending value from user input

BEGIN
    -- Check if any input is missing (NULL values are not allowed)
    IF start_num IS NULL OR end_num IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'Inputs cannot be NULL');
    END IF;

    -- Determine loop direction based on user input
    IF start_num < end_num THEN
        -- Case 1: Ascending order (e.g., 1 to 5)
        FOR i IN start_num .. end_num LOOP
            DBMS_OUTPUT.PUT_LINE('Value: ' || i);  -- Display each number
        END LOOP;

    ELSE
        -- Case 2: Descending order (e.g., 5 to 1)
        -- REVERSE ensures iteration from higher value to lower value
        FOR i IN REVERSE end_num .. start_num LOOP
            DBMS_OUTPUT.PUT_LINE('Value: ' || i);  -- Display each number
        END LOOP;
    END IF;

EXCEPTION
    -- Handles invalid input types (e.g., user enters text instead of number)
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Error: Please enter valid numeric values.');

    -- Handles any other unexpected errors
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected Error: ' || SQLERRM);
END;
/
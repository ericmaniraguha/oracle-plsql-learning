CREATE OR REPLACE FUNCTION print_range_fn(p_start NUMBER, p_end NUMBER)
RETURN VARCHAR2
IS
    v_result VARCHAR2(4000) := '';  -- Variable to store output
BEGIN
    -- Determine direction
    IF p_start < p_end THEN
        -- Ascending
        FOR i IN p_start .. p_end LOOP
            v_result := v_result || i || ' ';
        END LOOP;
    ELSE
        -- Descending
        FOR i IN REVERSE p_end .. p_start LOOP
            v_result := v_result || i || ' ';
        END LOOP;
    END IF;

    RETURN v_result;  -- Return the full result

EXCEPTION
    WHEN OTHERS THEN
        RETURN 'Error: ' || SQLERRM;
END;
/

-- Test the function

SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE(print_range_fn(&start_value, &end_value));
END;
/
SET SERVEROUTPUT ON;

DECLARE
  ---------------------------------------------------------------------
  -- Variable to store results
  ---------------------------------------------------------------------
  v_result NUMBER;

  ---------------------------------------------------------------------
  -- Function to calculate square of a number
  ---------------------------------------------------------------------
  FUNCTION get_square(p_number NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN p_number * p_number;
  END get_square;

  ---------------------------------------------------------------------
  -- Function to calculate cube of a number using the square function
  ---------------------------------------------------------------------
  FUNCTION get_cube(p_number NUMBER) RETURN NUMBER IS
  BEGIN
    -- Nested function call: cube = number * (number squared)
    RETURN p_number * get_square(p_number);
  END get_cube;

BEGIN
  ---------------------------------------------------------------------
  -- Test the square function
  ---------------------------------------------------------------------
  v_result := get_square(5);
  DBMS_OUTPUT.PUT_LINE('Square of 5: ' || v_result);

  ---------------------------------------------------------------------
  -- Test the cube function
  ---------------------------------------------------------------------
  v_result := get_cube(3);
  DBMS_OUTPUT.PUT_LINE('Cube of 3: ' || v_result);
END;
/
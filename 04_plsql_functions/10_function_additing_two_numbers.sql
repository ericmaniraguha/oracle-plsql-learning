/*
  Simple addition calculation
*/
CREATE OR REPLACE FUNCTION add_number(
a IN NUMBER, 
b NUMBER
)
RETURN NUMBER
IS
BEGIN 
    RETURN a +b;
END;

-- Test or Call the function 
-- Testing using anonymous block
SET SERVEROUTPUT ON;

BEGIN
     DBMS_OUTPUT.PUT_LINE('Sum of two numbers: '|| add_number(12, 2));
END;

--Test the function using selection

SELECT add_number (78, 5) AS "Adding Two Numbers"  FROM DUAL;

SELECT add_number (15, 5) AS AddingTwoNumbers  FROM DUAL;


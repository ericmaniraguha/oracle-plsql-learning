/*
 Function to check either a text input is a palindrome or not
*/

CREATE OR REPLACE FUNCTION is_palindrome( p_str IN VARCHAR2)
RETURN VARCHAR2

IS 
var_reverse VARCHAR2(40) := '';

BEGIN 
     FOR i IN REVERSE 1 .. LENGTH(p_str) LOOP 
               var_reverse := var_reverse  || substr(p_str, i, 1);
    END LOOP;
    
    IF var_reverse = p_str THEN 
        RETURN 'Yes it is a palindrome';
    ELSE
        RETURN 'Not a palindrome';
    END IF;
        
END;
/

/*
 Call or testing the function 
*/
SET SERVEROUTPUT ON

BEGIN 

DBMS_OUTPUT.PUT_LINE(is_palindrome ('umuvumu'));

END;



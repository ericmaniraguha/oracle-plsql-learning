-- Question:
-- Create a package named my_package that contains:
-- 1. A public function called public_function
-- 2. A private function called private_helper
-- The private function should multiply the input by 2.
-- The public function should call the private function and then add 10.
-- Finally, test the public function and show that the private function cannot be accessed outside the package.

CREATE OR REPLACE PACKAGE my_package IS
    FUNCTION public_function(p_val NUMBER) RETURN NUMBER;
END my_package;
/

CREATE OR REPLACE PACKAGE BODY my_package IS

    -- Private function: not declared in package specification
    FUNCTION private_helper(p_val NUMBER) RETURN NUMBER IS
    BEGIN
        RETURN p_val * 2;
    END private_helper;

    -- Public function: declared in package specification
    FUNCTION public_function(p_val NUMBER) RETURN NUMBER IS
    BEGIN
        RETURN private_helper(p_val) + 10;
    END public_function;

END my_package;
/

-- Test the public function
SELECT my_package.public_function(5) AS result
FROM dual;

-- This statement will cause an error because private_helper
-- is not visible outside the package body
SELECT my_package.private_helper(5)
FROM dual;
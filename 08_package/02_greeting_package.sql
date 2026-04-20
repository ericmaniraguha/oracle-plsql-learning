-- Question:
-- Create a package named greeting_package that contains:
-- 1. A public function called greet_user
-- 2. A private function called format_name
-- The private function should convert the name to uppercase.
-- The public function should return a greeting message using the formatted name.
-- Finally, test the public function and show that the private function cannot be accessed outside the package.

CREATE OR REPLACE PACKAGE greeting_package IS
    FUNCTION greet_user(p_name VARCHAR2) RETURN VARCHAR2;
END greeting_package;
/

CREATE OR REPLACE PACKAGE BODY greeting_package IS

    -- Private function: only accessible inside the package body
    FUNCTION format_name(p_name VARCHAR2) RETURN VARCHAR2 IS
    BEGIN
        RETURN UPPER(p_name);
    END format_name;

    -- Public function: accessible outside the package
    FUNCTION greet_user(p_name VARCHAR2) RETURN VARCHAR2 IS
    BEGIN
        RETURN 'Hello, ' || format_name(p_name) || '!';
    END greet_user;

END greeting_package;
/

-- Test the public function
SELECT greeting_package.greet_user('Eric') AS greeting
FROM dual;

-- This statement will cause an error because format_name
-- is private and not visible outside the package body
SELECT greeting_package.format_name('Eric')
FROM dual;
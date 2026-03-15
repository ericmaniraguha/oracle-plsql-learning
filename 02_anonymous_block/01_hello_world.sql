-- ========================================================
-- PL/SQL Anonymous Block Exercises
-- From simple to more advanced
-- Save this file as plsql_anonymous_exercises.sql
-- ========================================================

-- =========================
-- Exercise 1: Hello World
-- =========================
-- Question:
-- Write an anonymous PL/SQL block that prints "Hello World!" to the console.

-- Solution:
SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello World!');
END;
/
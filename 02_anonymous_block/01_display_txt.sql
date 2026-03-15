-- ========================================================
-- PL/SQL Anonymous Block Exercises using HR Schema
-- Tables: EMPLOYEES, DEPARTMENTS, JOBS, LOCATIONS, COUNTRIES, REGIONS, JOB_HISTORY
-- Save as: plsql_hr_anonymous_exercises.sql
-- ========================================================

-- ========================================================
-- Exercise 1: Hello World
-- ========================================================
-- Question:
-- Print "Hello HR World!" using DBMS_OUTPUT.
SET SERVEROUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello HR World!');
END;
/
-- ========================================================

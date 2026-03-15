/*
00_drop_existing_tables.sql

Skip dropping objects if they don’t exist
Modify your SQL scripts to only drop tables if they exist, e.g.:

*/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE job_history CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN -- ignore table does not exist
         RAISE;
      END IF;
END;
/



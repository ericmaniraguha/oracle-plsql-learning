/* =========================================================
   EXAM QUESTION
   ---------------------------------------------------------
   Design a PL/SQL solution that automatically calculates
   the Net Salary of an employee whenever HR inserts or
   updates an employee record.

   Requirements:
   1. Create EMPLOYEES table with given attributes.
   2. Create EMPLOYEE_PAYMENT table to store salary records.
   3. Create a function to calculate Net Salary.
   4. Create a trigger that:
      - Automatically calculates Net Salary
      - Validates that salary processing is only allowed in APRIL
        (based on CREATED_AT date)
      - Inserts payroll information into payment table
   ========================================================= */

/* =========================================================
   EMPLOYEE PAYROLL SYSTEM (PL/SQL FULL SOLUTION)
   ---------------------------------------------------------
   FEATURES:
   1. Employees table
   2. Payroll/payment table
   3. Function to calculate Net Salary
   4. Trigger:
      - Validates APRIL only
      - Calculates Net Salary
      - Inserts payroll record automatically
   5. Test cases + queries
   ========================================================= */


/* ================================
   STEP 1: EMPLOYEES TABLE
================================ */
/*
CREATE TABLE EMPLOYEES (
    EMPLOYEE_ID     NUMBER PRIMARY KEY,
    FIRST_NAME      VARCHAR2(50),
    LAST_NAME       VARCHAR2(50),
    EMAIL           VARCHAR2(100),
    PHONE_NUMBER    VARCHAR2(20),
    ADDRESS         VARCHAR2(200),
    HIRE_DATE       DATE,
    DEPARTMENT_ID   NUMBER,
    ROLE_ID         NUMBER,
    SALARY          NUMBER,
    STATUS          VARCHAR2(20),
    CREATED_AT      DATE,
    UPDATED_AT      DATE,
    NET_SALARY      NUMBER
);
*/

/* ================================
   STEP 1-2: ALTER TABLE EMPLOYEES TABLE ADD EXTRA COLUMN
================================ */

ALTER TABLE EMPLOYEES
ADD NET_SALARY NUMBER;


/* ================================
   STEP 2: EMPLOYEE PAYMENT TABLE
================================ */
CREATE TABLE EMPLOYEE_PAYMENT (
    PAYMENT_ID      NUMBER GENERATED ALWAYS AS IDENTITY,
    EMPLOYEE_ID     NUMBER,
    FULL_NAME       VARCHAR2(120),
    DEPARTMENT_ID   NUMBER,
    GROSS_SALARY    NUMBER,
    NET_SALARY      NUMBER,
    PAYMENT_DATE    DATE,
    CONSTRAINT FK_EMP_PAYMENT
        FOREIGN KEY (EMPLOYEE_ID)
        REFERENCES EMPLOYEES (EMPLOYEE_ID)
);


/* ================================
   STEP 3: FUNCTION
   CALCULATE NET SALARY
================================ */
CREATE OR REPLACE FUNCTION CALC_NET_SALARY (
    p_salary NUMBER
) RETURN NUMBER
IS
    v_tax     NUMBER;
    v_pension NUMBER;
    v_net     NUMBER;
BEGIN
    -- 15% TAX
    v_tax := p_salary * 0.15;

    -- 5% PENSION
    v_pension := p_salary * 0.05;

    -- NET SALARY
    v_net := p_salary - (v_tax + v_pension);

    RETURN v_net;
END;
/

/* ================================
   STEP 4: TRIGGER
   AUTO CALCULATION + VALIDATION + REPORT
================================ */
CREATE OR REPLACE TRIGGER TRG_EMPLOYEE_SALARY
BEFORE INSERT OR UPDATE ON EMPLOYEES
FOR EACH ROW
BEGIN

    /* ----------------------------------------
       ENSURE CREATED_AT HAS VALUE
    ---------------------------------------- */
    IF :NEW.CREATED_AT IS NULL THEN
        :NEW.CREATED_AT := SYSDATE;
    END IF;

    /* ----------------------------------------
       VALIDATE: ONLY APRIL IS ALLOWED
    ---------------------------------------- */
    IF EXTRACT(MONTH FROM :NEW.CREATED_AT) <> 4 THEN
        RAISE_APPLICATION_ERROR(-20001,
        'Salary processing is only allowed in APRIL.');
    END IF;

    /* ----------------------------------------
       CALCULATE NET SALARY USING FUNCTION - THIS IS NEEDED WHILE  I WANT TO STORE OR TO HAVE NET SALARY AS WELL.
    ---------------------------------------- */
    :NEW.NET_SALARY := CALC_NET_SALARY(:NEW.SALARY);

    /* ----------------------------------------
       INSERT INTO PAYMENT TABLE (REPORT)
    ---------------------------------------- */
    INSERT INTO EMPLOYEE_PAYMENT (
        EMPLOYEE_ID,
        FULL_NAME,
        DEPARTMENT_ID,
        GROSS_SALARY,
        NET_SALARY,
        PAYMENT_DATE
    )
    VALUES (
        :NEW.EMPLOYEE_ID,
        :NEW.FIRST_NAME || ' ' || :NEW.LAST_NAME,
        :NEW.DEPARTMENT_ID,
        :NEW.SALARY,
        :NEW.NET_SALARY,
        SYSDATE
    );

END;
/

/* ================================
   STEP 5: TEST DATA INSERT (VALID)
================================ */
INSERT INTO EMPLOYEES (
    FIRST_NAME,
    LAST_NAME,
    EMAIL,
    PHONE_NUMBER,
    ADDRESS,
    HIRE_DATE,
    DEPARTMENT_ID,
    ROLE_ID,
    SALARY,
    STATUS,
    CREATED_AT
)
VALUES (
    'John',
    'Doe',
    'john@gmail.com',
    '0788000000',
    'Kigali',
    SYSDATE,
    10,
    1,
    1000,
    'ACTIVE',
    TO_DATE('2026-04-10','YYYY-MM-DD')
);


/* ================================
   STEP 6: TEST DATA INSERT (INVALID - SHOULD FAIL)
================================ */
/*
INSERT INTO EMPLOYEES (
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    SALARY,
    CREATED_AT
)
VALUES (
    2,
    'Jane',
    'Smith',
    2000,
    TO_DATE('2026-03-10','YYYY-MM-DD')
);
*/


/* ================================
   STEP 7: CHECK DATA
================================ */

-- Employees table
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, NET_SALARY, CREATED_AT
FROM EMPLOYEES;

-- Payroll report table
SELECT * FROM EMPLOYEE_PAYMENT;
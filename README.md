
# **Oracle HR Schema & Employee Managament System PDB (ems_pdb) Setup Guide**

This guide walks you through **creating a Pluggable Database (PDB) in Oracle 23c Free** on Windows, and **setting up the sample HR schema**. Perfect for students or anyone learning PL/SQL and Oracle database management.

---

## **1. Prerequisites**

* Oracle 23c Free / AI Edition installed on Windows.
* Access to **SQL*Plus as SYSDBA**.
* Target folder for the new PDB exists, e.g.:

```
C:\APP\ERICM\PRODUCT\26AI\ORADATA\FREE\ems_pdb\
```

*Recommended:* Oracle SQL Developer for running scripts.

---

## **2. Connect as SYSDBA**

Open **SQL*Plus** and connect:

```sql
sqlplus / as sysdba
```

*You should see a message confirming the connection.*

---

## **3. Check existing PDBs**

```sql
SHOW PDBS;
SHOW CON_NAME;
```

*Notes:*

* `CDB$ROOT` – the root container
* `PDB$SEED` – seed template used to create new PDBs

---

## **4. Verify SYSTEM tablespace location**

```sql
SELECT file_name FROM dba_data_files WHERE tablespace_name='SYSTEM';
```

*This ensures you know where the PDB files will be created.*

---

## **5. Create the Pluggable Database**

```sql
CREATE PLUGGABLE DATABASE ems_pdb
   ADMIN USER admin IDENTIFIED BY admi
   FILE_NAME_CONVERT = (
       'C:\APP\ERICM\PRODUCT\26AI\ORADATA\FREE\',
       'C:\APP\ERICM\PRODUCT\26AI\ORADATA\FREE\ems_pdb\'
   );
```

*What this does:*

* Creates a new PDB called `EMS_PDB`.
* Creates an admin user `admin`.
* Copies seed database files to your target folder.

---

## **6. Open and Save PDB State**

```sql
ALTER PLUGGABLE DATABASE ems_pdb OPEN;
ALTER PLUGGABLE DATABASE ems_pdb SAVE STATE;
```

*This makes sure the PDB opens automatically on startup.*

---

## **7. Switch session to EMS_PDB**

```sql
ALTER SESSION SET CONTAINER = ems_pdb;
SHOW CON_NAME;
```

*Now your session is inside the new PDB.*

---

## **8. Create / Alter Admin User**

```sql
ALTER USER admin IDENTIFIED BY admin;

-- Grant privileges
GRANT CONNECT, RESOURCE TO admin;
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE VIEW, CREATE PROCEDURE, ALTER SESSION TO admin;
GRANT DROP ANY TABLE TO admin;
GRANT UNLIMITED TABLESPACE TO admin;
```

*Grants necessary privileges to manage tables, sequences, and logins.*

---

## **9. Verify PDBs**

```sql
SHOW PDBS;
SELECT name FROM v$pdbs;
```

*Confirm that `EMS_PDB` is listed and ready.*

---

## **10. Download and Prepare HR Schema Scripts**

1. Clone the repository **or** download SQL files manually.
2. Files to run:

| Script | Purpose                        |
| ------ | ------------------------------ |
| 01     | Switch to PDB & create HR user |
| 02     | Create tables                  |
| 03     | Populate tables                |
| 04     | Create indexes & comments      |

---

## **11. Run HR Schema Scripts**

1. Connect as **HR user**.
2. Run scripts in order: **01 → 02 → 03 → 04**.
3. Verify tables and data:

```sql
SELECT * FROM employees;
SELECT * FROM departments;
```

🎉 **The HR schema is now fully set up!**

---

## **12. Diagram**

![Relational Diagram](https://github.com/user-attachments/assets/24a5c16c-9a70-4300-aaa5-799e8e1c124c)


---

## **Summary Checklist**

1. [x] Connected to `CDB$ROOT` as SYSDBA
2. [x] Created PDB `EMS_PDB` and admin user
3. [x] Opened and saved PDB state
4. [x] Switched session to `EMS_PDB`
5. [x] Prepared HR schema scripts
6. [x] Created HR user, tables, and populated sample data

---
*You now have a working PDB with the HR schema for PL/SQL practice or learning.*

---


# **PL/SQL Programming: Complete Guide**

This guide provides a structured roadmap for learning **PL/SQL** in the Oracle Database environment, from fundamentals to advanced concepts and real-world applications.

---

## **1. Introduction to PL/SQL**

* **What is PL/SQL?**
  Understand the procedural extension of SQL that allows you to write complex scripts, business logic, and automation within Oracle.

* **Advantages of PL/SQL over SQL**

  * Supports procedural constructs (loops, conditions)
  * Exception handling
  * Modular code with procedures, functions, and packages
  * Improves performance with blocks and bulk operations

---

## **2. Overview of the Oracle Database Environment**

* **Oracle Installation and Setup**
  Learn how to install and configure Oracle Database for PL/SQL development.

* **System Requirements**
  Hardware and software prerequisites for Oracle Database.

* **Downloading and Installing Oracle Database**
  Step-by-step instructions for Windows or Linux.

* **Configuring Oracle Database**
  Creating and configuring a database instance.

* **Introduction to Oracle SQL Developer**
  Using Oracle’s IDE for writing, testing, and managing PL/SQL code.

* **Troubleshooting Common Installation Issues**
  Solutions for frequent setup problems.

---

## **3. PL/SQL Programming Fundamentals**

* **PL/SQL Block Structure**
  Anatomy of a PL/SQL block: declaration, execution, exception sections.

* **Variables, Constants, and Data Types**
  How to declare and use different types of variables.

* **Operators and Expressions**
  Arithmetic, comparison, and logical operators.

* **Control Structures and Error Handling**

  * Conditional statements (IF, CASE)
  * Loops (FOR, WHILE, simple loops)
  * Exception handling and custom exceptions

---

## **4. Procedures, Functions, and Packages**

* **Creating and Managing Procedures and Functions**
  Writing reusable code blocks for database operations.

* **Parameter Passing Techniques**
  IN, OUT, and IN OUT parameters.

* **Working with Packages**

  * Package specification and body
  * Grouping related procedures, functions, and variables

---

## **5. Cursors and Triggers**

* **Implicit vs. Explicit Cursors**
  Handling query results using cursors.

* **Cursor FOR Loops and Ref Cursors**
  Iterating through datasets efficiently.

* **Introduction to Triggers and Applications**
  Automating database actions in response to table events.

---

## **6. Advanced PL/SQL Concepts**

* **Dynamic SQL using EXECUTE IMMEDIATE**
  Running SQL statements dynamically at runtime.

* **Bulk Collect and FORALL**
  Performance optimization for handling large datasets.

* **Using Collections and Records**
  Arrays, nested tables, VARRAYs, and records for structured data.

* **PL/SQL Performance Tuning**

  * Identifying performance bottlenecks
  * Using tools like TKPROF and EXPLAIN PLAN
  * Best practices for efficient code

---

## **7. Transactions and Concurrency**

* **Managing Transactions in PL/SQL**
  COMMIT, ROLLBACK, SAVEPOINT usage.

* **Locks, Deadlocks, and Concurrency Control**
  Ensuring data integrity in multi-user environments.

---

## **8. Business Intelligence with PL/SQL**

* **Using PL/SQL for ETL Tasks**
  Extract, transform, and load data efficiently.

* **Connecting Oracle with BI Tools**
  Integration with Oracle BI, Power BI, Tableau.

* **Building SQL Reports and Dashboards**
  Automating reports and visualizations using PL/SQL.

---

## **9. Practical Applications and Case Studies**

* **Real-World Scenarios and Examples**
  Apply PL/SQL concepts in business-oriented tasks.

* **Building End-to-End PL/SQL Applications**
  Integrate database logic with front-end applications.

* **Integration with Front-End Applications**
  Connecting PL/SQL back-end with web or desktop interfaces.

---

## **10. Learning Path Recommendations**

1. Start with PL/SQL fundamentals: blocks, variables, and control structures.
2. Practice creating procedures, functions, and packages.
3. Learn cursors and triggers for automated workflows.
4. Explore advanced topics like dynamic SQL and bulk operations.
5. Apply concepts in real-world projects with transactions and concurrency.
6. Integrate PL/SQL with reporting and BI tools for practical applications.

---

## **Next Steps for Students**

Congratulations! 🎉 You now have a working **Pluggable Database (`EMS_PDB`) with the HR schema** and a solid foundation in **PL/SQL**.

To take your skills further and start **turning data into value**, focus on exploring **modern data engineering and analytics tools**:

* **SQL Clients & Query Tools** – Tools like **AqhelSQL**, **DBeaver**, or **SQL Developer** for querying, exploring, and managing your databases.
* **Python for Data Engineering & Analytics** – Use Python libraries like **Pandas, SQLAlchemy, and PySpark** to extract, transform, and analyze data efficiently.
* **ETL & Workflow Automation** – Learn **Apache Airflow** or other orchestration tools to schedule, monitor, and automate data pipelines.
* **DBT (Data Build Tool)** – Build reliable data models, transformations, and version-controlled pipelines.
* **Business Intelligence & Reporting** – Connect your database to **Power BI, Tableau, or Oracle BI** to create dashboards and actionable insights.
* **Advanced Database Concepts** – Explore replication, partitioning, indexing, and performance tuning for large-scale datasets.
* **Data-Driven Projects** – Experiment in your PDB sandbox: create tables, write procedures, integrate multiple sources, and run analytics to extract business value.

💡 *Tip:* Treat this setup as your **sandbox environment**. Every table you create, query you run, and workflow you automate is practice for real-world data engineering and analytics projects.

By combining **SQL, PL/SQL, Python, ETL tools, workflow orchestration, and BI platforms**, you move from learning fundamentals to **becoming a data professional capable of designing, managing, and extracting value from complex datasets**.

---
# oracle-plsql-learning
# test_plsql

-- 00_setup/create_tables.sql
-- Creates the DEPARTMENTS and EMPLOYEES tables with sample data.
-- Safe to re-run: it drops the old tables first.
SET SERVEROUTPUT ON
SET VERIFY OFF

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE employees PURGE';
EXCEPTION
  WHEN OTHERS THEN NULL;  -- table did not exist yet, that's fine
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE departments PURGE';
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE departments (
  dept_id   NUMBER(4)     CONSTRAINT pk_departments PRIMARY KEY,
  dept_name VARCHAR2(50)  NOT NULL
);

CREATE TABLE employees (
  emp_id     NUMBER(6)     CONSTRAINT pk_employees PRIMARY KEY,
  first_name VARCHAR2(30)  NOT NULL,
  last_name  VARCHAR2(30)  NOT NULL,
  salary     NUMBER(10,2),
  hire_date  DATE          NOT NULL,
  dept_id    NUMBER(4)     CONSTRAINT fk_emp_dept REFERENCES departments(dept_id)
);

INSERT INTO departments VALUES (10, 'Human Resources');
INSERT INTO departments VALUES (20, 'Information Technology');
INSERT INTO departments VALUES (30, 'Sales');

-- salary is MONTHLY (RWF)
INSERT INTO employees VALUES (101, 'Alice',    'Uwase',      850000, TO_DATE('2019-03-15','YYYY-MM-DD'), 10);
INSERT INTO employees VALUES (102, 'Jean',     'Habimana',   450000, TO_DATE('2021-07-01','YYYY-MM-DD'), 20);
INSERT INTO employees VALUES (103, 'Grace',    'Mukamana',   280000, TO_DATE('2023-01-10','YYYY-MM-DD'), 30);
INSERT INTO employees VALUES (104, 'Patrick',  'Niyonzima',  120000, TO_DATE('2024-05-20','YYYY-MM-DD'), 10);
INSERT INTO employees VALUES (105, 'Diane',    'Ingabire',    55000, TO_DATE('2025-02-01','YYYY-MM-DD'), 20);
-- the next three are deliberately "bad" rows for the payroll validator (C1)
INSERT INTO employees VALUES (106, 'Olivier',  'Nshuti',        NULL, TO_DATE('2022-09-12','YYYY-MM-DD'), 30);
INSERT INTO employees VALUES (107, 'Chantal',  'Uwimana',     300000, SYSDATE + 180, 10);
INSERT INTO employees VALUES (108, 'Joseph',   'Rukundo',     400000, TO_DATE('2020-11-05','YYYY-MM-DD'), NULL);

COMMIT;

SELECT COUNT(*) AS departments_loaded FROM departments;
SELECT COUNT(*) AS employees_loaded FROM employees;

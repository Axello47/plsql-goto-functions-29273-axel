-- Quick tests for B1 - B4 (expected values in the comments)
SET SERVEROUTPUT ON

BEGIN
  DBMS_OUTPUT.PUT_LINE('--- B1 annual salary ---');
  DBMS_OUTPUT.PUT_LINE('500000 -> ' || fn_annual_salary(500000));   -- 6000000
  DBMS_OUTPUT.PUT_LINE('NULL   -> ' || NVL(TO_CHAR(fn_annual_salary(NULL)), 'NULL'));

  DBMS_OUTPUT.PUT_LINE('--- B2 years of service ---');
  DBMS_OUTPUT.PUT_LINE('hired 2 years ago -> ' || fn_years_of_service(ADD_MONTHS(SYSDATE, -24)));  -- 2

  DBMS_OUTPUT.PUT_LINE('--- B3 tax ---');
  DBMS_OUTPUT.PUT_LINE('50000  -> ' || fn_calculate_tax(50000));    -- 0
  DBMS_OUTPUT.PUT_LINE('60000  -> ' || fn_calculate_tax(60000));    -- 0
  DBMS_OUTPUT.PUT_LINE('100000 -> ' || fn_calculate_tax(100000));   -- 8000
  DBMS_OUTPUT.PUT_LINE('200000 -> ' || fn_calculate_tax(200000));   -- 38000

  DBMS_OUTPUT.PUT_LINE('--- B4 department name ---');
  DBMS_OUTPUT.PUT_LINE('10  -> ' || fn_dept_name(10));    -- Human Resources
  DBMS_OUTPUT.PUT_LINE('999 -> ' || fn_dept_name(999));   -- Unknown Department
END;
/

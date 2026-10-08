SET SERVEROUTPUT ON
SET LINESIZE 160

BEGIN
  FOR r IN (SELECT emp_id FROM employees ORDER BY emp_id) LOOP
    DBMS_OUTPUT.PUT_LINE('Employee ' || r.emp_id || ': ' || fn_validate_payroll(r.emp_id));
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('Employee 999: ' || fn_validate_payroll(999));
END;
/

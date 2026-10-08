SET SERVEROUTPUT ON
SET VERIFY OFF

DECLARE
  v_emp_id NUMBER := &enter_employee_id;
  v_name   VARCHAR2(100);
  v_salary NUMBER;
  v_pct    NUMBER;
BEGIN
  SELECT first_name || ' ' || last_name, salary
    INTO v_name, v_salary
    FROM employees
   WHERE emp_id = v_emp_id;

  DBMS_OUTPUT.PUT_LINE('Employee: ' || v_name);

  IF v_salary IS NULL THEN
    GOTO no_salary;
  END IF;

  DBMS_OUTPUT.PUT_LINE('Monthly salary: ' || v_salary || '  (annual ' || fn_annual_salary(v_salary) || ')');

  IF v_salary < 300000 THEN
    GOTO low_salary;
  ELSIF v_salary < 700000 THEN
    GOTO mid_salary;
  ELSE
    GOTO high_salary;
  END IF;

  <<no_salary>>
  DBMS_OUTPUT.PUT_LINE('No salary on record - cannot review.');
  GOTO review_done;

  <<low_salary>>
  v_pct := 10;
  GOTO show_result;

  <<mid_salary>>
  v_pct := 5;
  GOTO show_result;

  <<high_salary>>
  v_pct := 2;

  <<show_result>>
  DBMS_OUTPUT.PUT_LINE('Raise: ' || v_pct || '%  -> new monthly salary ' || ROUND(v_salary * (1 + v_pct / 100), 2));

  <<review_done>>
  DBMS_OUTPUT.PUT_LINE('Salary review complete.');
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No employee found with ID ' || v_emp_id);
END;
/

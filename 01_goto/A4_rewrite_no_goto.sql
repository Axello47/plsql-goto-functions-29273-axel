SET SERVEROUTPUT ON
SET VERIFY OFF

PROMPT === A1 without GOTO ===
DECLARE
  v_num NUMBER := &enter_a_whole_number;
BEGIN
  IF v_num > 0 THEN
    DBMS_OUTPUT.PUT_LINE(v_num || ' is positive');
  ELSIF v_num < 0 THEN
    DBMS_OUTPUT.PUT_LINE(v_num || ' is negative');
  ELSE
    DBMS_OUTPUT.PUT_LINE('The number is zero');
  END IF;

  IF v_num <> 0 THEN
    IF MOD(v_num, 2) = 0 THEN
      DBMS_OUTPUT.PUT_LINE(v_num || ' is even');
    ELSE
      DBMS_OUTPUT.PUT_LINE(v_num || ' is odd');
    END IF;
  END IF;
  DBMS_OUTPUT.PUT_LINE('Classification finished.');
END;
/

PROMPT === A2 without GOTO ===
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
    DBMS_OUTPUT.PUT_LINE('No salary on record - cannot review.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Monthly salary: ' || v_salary || '  (annual ' || fn_annual_salary(v_salary) || ')');
    IF v_salary < 300000 THEN
      v_pct := 10;
    ELSIF v_salary < 700000 THEN
      v_pct := 5;
    ELSE
      v_pct := 2;
    END IF;
    DBMS_OUTPUT.PUT_LINE('Raise: ' || v_pct || '%  -> new monthly salary ' || ROUND(v_salary * (1 + v_pct / 100), 2));
  END IF;
  DBMS_OUTPUT.PUT_LINE('Salary review complete.');
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No employee found with ID ' || v_emp_id);
END;
/

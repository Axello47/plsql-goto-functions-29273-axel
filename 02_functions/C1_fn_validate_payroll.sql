CREATE OR REPLACE FUNCTION fn_validate_payroll (
  p_emp_id IN NUMBER
) RETURN VARCHAR2 IS
  v_emp employees%ROWTYPE;
BEGIN
  SELECT *
    INTO v_emp
    FROM employees
   WHERE emp_id = p_emp_id;

  IF v_emp.salary IS NULL THEN
    RETURN 'INVALID: salary is missing';
  ELSIF v_emp.salary <= 0 THEN
    RETURN 'INVALID: salary must be greater than zero';
  END IF;

  IF v_emp.hire_date > SYSDATE THEN
    RETURN 'INVALID: hire date is in the future';
  END IF;

  IF v_emp.dept_id IS NULL OR fn_dept_name(v_emp.dept_id) = 'Unknown Department' THEN
    RETURN 'INVALID: no valid department';
  END IF;

  RETURN 'VALID: annual salary ' || fn_annual_salary(v_emp.salary)
         || ', monthly tax ' || fn_calculate_tax(v_emp.salary);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 'INVALID: employee ' || p_emp_id || ' not found';
  WHEN OTHERS THEN
    RETURN 'ERROR: ' || SQLERRM;
END fn_validate_payroll;
/
SHOW ERRORS

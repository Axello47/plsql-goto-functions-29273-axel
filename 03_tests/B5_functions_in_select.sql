-- B5: calling the functions inside a SELECT
SET LINESIZE 160
SET PAGESIZE 50
COLUMN emp_id        FORMAT 999
COLUMN first_name    FORMAT A10
COLUMN department    FORMAT A24
COLUMN monthly_salary FORMAT 999,999,999
COLUMN annual_salary  FORMAT 999,999,999
COLUMN years_service  FORMAT 999.9
COLUMN monthly_tax    FORMAT 999,999,999

SELECT e.emp_id,
       e.first_name,
       fn_dept_name(e.dept_id)         AS department,
       e.salary                        AS monthly_salary,
       fn_annual_salary(e.salary)      AS annual_salary,
       fn_years_of_service(e.hire_date) AS years_service,
       fn_calculate_tax(e.salary)      AS monthly_tax
  FROM employees e
 ORDER BY e.emp_id;

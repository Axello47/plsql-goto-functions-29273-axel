# PL/SQL GOTO Statements and Functions

**Course:** Database Development with PL/SQL (INSY 8311)
**Student:** Axel, ID 29273
**Assignment:** Individual Assignment III

This is my work for the GOTO and functions assignment. I used Oracle Database 21c Express Edition and ran everything in SQL*Plus. The README explains what I made, how to run it, and what I learned along the way.

## What is in this repo

```
00_setup/       create_tables.sql
01_goto/        A1 to A4 (GOTO programs)
02_functions/   B1 to B4 and C1 (functions)
03_tests/       B5 select, function tests, payroll validator test
screenshots/    output screenshots for each task
docs/           REFLECTION.md
```

## The tables

I made two tables, `departments` and `employees`. The salary column is a monthly salary in RWF. I added 3 departments and 8 employees. Employees 106, 107 and 108 are "bad" rows on purpose (missing salary, hire date in the future, no department) so I could test the payroll validator in C1.

## How to run it

Run these in order from the repo folder in SQL*Plus:

1. `@00_setup/create_tables.sql`
2. The functions, in this order because C1 uses the others:
   - `@02_functions/B1_fn_annual_salary.sql`
   - `@02_functions/B2_fn_years_of_service.sql`
   - `@02_functions/B3_fn_calculate_tax.sql`
   - `@02_functions/B4_fn_dept_name.sql`
   - `@02_functions/C1_fn_validate_payroll.sql`
3. The GOTO programs in `01_goto/` (A1 and A2 ask you to type a value)
4. The test files in `03_tests/`

I used `SET SERVEROUTPUT ON` at the start so the output shows up.

## Part A: GOTO

**A1 Number Classifier.** You type a whole number and it uses GOTO to jump to the right label. It says if the number is positive, negative or zero, then jumps to another label to say if it is even or odd.

![A1 output](screenshots/A1_output.png)

**A2 Salary Review.** You type an employee ID. The program looks up the salary and uses GOTO to jump to a low, mid or high salary section. Each section gives a different raise (10%, 5% or 2%). If the salary is empty it jumps to a "no salary" message instead.

![A2 output](screenshots/A2_output.png)

**A3 Illegal GOTO and Fix.** In the first block I tried to jump from outside an IF block to a label inside it. Oracle does not allow that and gives `PLS-00375: illegal GOTO statement`. For the fix I moved the label so it is at the same level as the GOTO, and then it worked.

![A3 error and fix](screenshots/A3_error_and_fix.png)

**A4 Rewrite Without GOTO.** I rewrote A1 and A2 using only IF / ELSIF / ELSE. It gives the same results and is a lot easier to read.

![A4 output](screenshots/A4_output.png)

## Part B: Functions

| Function | What it does |
|---|---|
| `fn_annual_salary` | takes the monthly salary and returns salary x 12 |
| `fn_years_of_service` | takes a hire date and returns the years worked (1 decimal) using `MONTHS_BETWEEN` |
| `fn_calculate_tax` | takes the monthly salary and returns tax using brackets |
| `fn_dept_name` | takes a department ID and returns the name, or `Unknown Department` if it is not found |

For the tax brackets I used 0% up to 60,000, then 20% on the part between 60,000 and 100,000, then 30% on anything above 100,000 (plus the 8,000 from the middle bracket).

**B5 Functions in SQL.** I called all the functions inside one SELECT on the employees table.

![B5 select output](screenshots/B5_select_output.png)

## Part C: Combined task

**C1 Payroll Validator.** `fn_validate_payroll` takes an employee ID and checks the payroll data. It returns a message saying if the employee is valid or what is wrong (missing salary, salary is zero or negative, hire date in the future, no valid department, or employee not found). For valid employees it also uses my other functions to show the annual salary and the tax. It uses exception handling for the not found case.

![C1 output](screenshots/C1_output.png)

**C2 Reflection.** See [docs/REFLECTION.md](docs/REFLECTION.md).

## Problems I ran into

- I tried to type `sqlplus ...` while I was already inside SQL*Plus, which does not work. You use `CONNECT` inside SQL*Plus and `sqlplus` only from the Windows command prompt.
- My password has an `@` in it, and SQL*Plus reads `@` as the start of the database address in a connect string. I fixed it by making a new user with a simpler password.

## Notes (AI use)

I used an AI assistant (Claude) while doing this assignment. It helped me plan the order of the tasks, write the first version of the SQL files, fix my SQL*Plus connection errors, and set up this GitHub repository. I went through the code to understand how each part works and I can explain it. The reflection is meant to be in my own words.

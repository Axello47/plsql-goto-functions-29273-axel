-- A3: an ILLEGAL GOTO, then the fix
SET SERVEROUTPUT ON

PROMPT === PART 1: illegal GOTO (expect PLS-00375) ===
-- You cannot jump INTO an IF block from outside it.
BEGIN
  GOTO inside_if;
  IF 1 = 1 THEN
    <<inside_if>>
    DBMS_OUTPUT.PUT_LINE('Inside the IF block');
  END IF;
END;
/

PROMPT === PART 2: the fix (label moved to the same level as the GOTO) ===
BEGIN
  GOTO show_message;
  DBMS_OUTPUT.PUT_LINE('This line is skipped');

  <<show_message>>
  IF 1 = 1 THEN
    DBMS_OUTPUT.PUT_LINE('Fixed: label now sits outside the IF, so the jump is legal');
  END IF;
END;
/

SET SERVEROUTPUT ON

PROMPT === PART 1: illegal GOTO (expect PLS-00375) ===
BEGIN
  GOTO inside_if;
  IF 1 = 1 THEN
    <<inside_if>>
    DBMS_OUTPUT.PUT_LINE('Inside the IF block');
  END IF;
END;
/

PROMPT === PART 2: the fix ===
BEGIN
  GOTO show_message;
  DBMS_OUTPUT.PUT_LINE('This line is skipped');

  <<show_message>>
  IF 1 = 1 THEN
    DBMS_OUTPUT.PUT_LINE('Fixed: label is outside the IF now');
  END IF;
END;
/

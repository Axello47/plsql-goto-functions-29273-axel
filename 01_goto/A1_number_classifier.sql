SET SERVEROUTPUT ON
SET VERIFY OFF

DECLARE
  v_num NUMBER := &enter_a_whole_number;
BEGIN
  IF v_num > 0 THEN
    GOTO positive_number;
  ELSIF v_num < 0 THEN
    GOTO negative_number;
  ELSE
    GOTO zero_number;
  END IF;

  <<positive_number>>
  DBMS_OUTPUT.PUT_LINE(v_num || ' is positive');
  GOTO check_parity;

  <<negative_number>>
  DBMS_OUTPUT.PUT_LINE(v_num || ' is negative');
  GOTO check_parity;

  <<zero_number>>
  DBMS_OUTPUT.PUT_LINE('The number is zero');
  GOTO finish;

  <<check_parity>>
  IF MOD(v_num, 2) = 0 THEN
    DBMS_OUTPUT.PUT_LINE(v_num || ' is even');
  ELSE
    DBMS_OUTPUT.PUT_LINE(v_num || ' is odd');
  END IF;

  <<finish>>
  DBMS_OUTPUT.PUT_LINE('Classification finished.');
END;
/

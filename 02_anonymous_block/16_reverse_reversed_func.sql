
BEGIN
  FOR  i IN reverse  1..5 LOOP
    DBMS_OUTPUT.PUT_LINE('Countdown: ' || (i-6));
  END LOOP;
END;
/

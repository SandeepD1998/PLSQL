--1. When passing a table name to get the column_names present in the table.

CREATE OR REPLACE PROCEDURE SP_COLL(P_TABLE_NAME VARCHAR2) AS
V_STR VARCHAR2(200);
TYPE T_TAB IS TABLE OF VARCHAR2(20);
COLUMN_NAMES_LIST T_TAB;
BEGIN
V_STR:='SELECT COLUMN_NAME FROM USER_TAB_COLUMNS WHERE TABLE_NAME='||''''||UPPER(P_TABLE_NAME)||'''';
EXECUTE IMMEDIATE V_STR BULK COLLECT INTO COLUMN_NAMES_LIST;
FOR I IN 1..COLUMN_NAMES_LIST.LAST LOOP
DBMS_OUTPUT.PUT_LINE(COLUMN_NAMES_LIST(I));
END LOOP;
END;

EXEC SP_COLL('EMP1');

set serveroutput on

--2. To print the Child_table_name when passing the parent_table_name.


CREATE OR REPLACE PROCEDURE SP1_COLL(P1_TABLE_NAME VARCHAR2) AS
V_STR VARCHAR2(1000);
v1_str varchar2(1000);
TYPE T_TAB IS TABLE OF VARCHAR2(200);
COLUMN_NAMES_LIST T_TAB;
v_cntt int;
BEGIN
v1_str:='select count(*) from user_tables where table_name='||''''||upper(p1_table_name)||'''';
    EXECUTE IMMEDIATE v1_str INTO v_cntt;
    if v_cntt=0 then
        dbms_output.put_line('No tables were present');
    else
        V_STR:='SELECT TABLE_NAME FROM USER_CONSTRAINTS WHERE CONSTRAINT_NAME IN(SELECT R_CONSTRAINT_NAME 
            FROM USER_CONSTRAINTS WHERE TABLE_NAME='||''''||UPPER(P1_TABLE_NAME)||''''||')';
EXECUTE IMMEDIATE V_STR BULK COLLECT INTO COLUMN_NAMES_LIST;
FOR I IN 1..COLUMN_NAMES_LIST.LAST LOOP
DBMS_OUTPUT.PUT_LINE(COLUMN_NAMES_LIST(I));
END LOOP;
end if;
END;

SET SERVEROUTPUT ON

EXEC SP1_COLL('EMP1');

--3. To print the Parent_table_name when passing the Child_table_name.


CREATE OR REPLACE PROCEDURE SP2_COLL(c1_TABLE_NAME VARCHAR2) AS
V_STR VARCHAR2(1000);
v1_str varchar2(1000);
TYPE T_TAB IS TABLE OF VARCHAR2(200);
COLUMN_NAMES_LIST T_TAB;
v_cntt int;
BEGIN
v1_str:='select count(*) from user_tables where table_name='||''''||upper(c1_table_name)||'''';
    EXECUTE IMMEDIATE v1_str INTO v_cntt;
    if v_cntt=0 then
        dbms_output.put_line('No tables were present');
    else
        V_STR:='SELECT TABLE_NAME FROM USER_CONSTRAINTS WHERE R_CONSTRAINT_NAME IN(SELECT CONSTRAINT_NAME 
            FROM USER_CONSTRAINTS WHERE TABLE_NAME='||''''||UPPER(c1_table_name)||''''||')';
EXECUTE IMMEDIATE V_STR BULK COLLECT INTO COLUMN_NAMES_LIST;
FOR I IN 1..COLUMN_NAMES_LIST.LAST LOOP
DBMS_OUTPUT.PUT_LINE(COLUMN_NAMES_LIST(I));
END LOOP;
end if;
END;

exec sp2_coll('DEPT22');
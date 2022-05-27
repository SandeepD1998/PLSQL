create or replace package pkg_emp as
PROCEDURE SP_COLL(P_TABLE VARCHAR2);
procedure sp_refcur(p_tbl_name varchar2);
function fn_cnt return number;
end pkg_emp;

create or replace package body pkg_emp as
PROCEDURE SP_COLL(P_TABLE VARCHAR2) as
V_STR VARCHAR2(200);
V_STR1 VARCHAR2(200);
V_CNT NUMBER;
TYPE T_TAB IS TABLE OF VARCHAR2(20);
COLUMN_NAMES_LIST T_TAB;
TABLE_NOT EXCEPTION;
BEGIN
V_STR1 := 'SELECT COUNT(*)FROM USER_TABLES WHERE TABLE_NAME='||''''||UPPER(P_TABLE)||'''';
EXECUTE IMMEDIATE V_STR1 INTO V_CNT;
IF V_CNT=0 THEN
     RAISE TABLE_NOT;
ELSE
    V_STR :='SELECT COLUMN_NAME FROM USER_TAB_COLUMNS WHERE TABLE_NAME='||''''||UPPER(P_TABLE)||'''';
    EXECUTE IMMEDIATE V_STR BULK COLLECT INTO COLUMN_NAMES_LIST;
    FOR I IN 1..COLUMN_NAMES_LIST.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(COLUMN_NAMES_LIST(I));
    END LOOP;
END IF;
EXCEPTION
WHEN TABLE_NOT THEN
DBMS_OUTPUT.PUT_LINE('TABLE NAME IS NOT VALID');
END;

procedure sp_refcur(p_tbl_name varchar2) as
colname_cur sys_refcursor;
col_nm varchar2(30);
tbl_nm varchar2(20);
begin
open colname_cur for 'select column_name from user_tab_columns where table_name='||''''||upper(p_tbl_name)||'''';
loop
fetch colname_cur into col_nm;
exit when colname_cur%notfound;
dbms_output.put_line('columns are '||col_nm);
end loop;
close colname_cur;
open colname_cur for 'select table_name from user_tables where length(table_name)=6';
loop
fetch colname_cur into tbl_nm;
exit when colname_cur%notfound;
dbms_output.put_line('tables are '||tbl_nm);
end loop;
close colname_cur;
end;

function fn_cnt return number as
v_cnt int;
begin
select count(*) into v_cnt from emp;
return v_cnt;
end;
end;

exec pkg_emp.sp_coll('emp');
exec pkg_emp.sp_refcur('emp');
select pkg_emp.fn_cnt from dual;


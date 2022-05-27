create or replace procedure sp_refcur(p_tbl_name varchar2) as
colname_cur sys_refcursor;
col_nm varchar2(30);
begin
open colname_cur for 'select column_name from user_tab_columns where table_name='||''''||upper(p_tbl_name)||'''';
loop
fetch colname_cur into col_nm;
exit when colname_cur%notfound;
dbms_output.put_line('columns are '||col_nm);
end loop;
close colname_cur;
end;
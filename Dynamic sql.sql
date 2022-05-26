select count(*) from user_tables
where table_name='EMP1';

select count(*) from tab;

dynamic sql scenario

create or replace procedure sp_dyn (p_tbl_name varchar2) as
v_str varchar2(200);
---V_CNT INT;
begin
v_str:='select count(*) from user_tables where table_name='||''''''||p_tbl_name||'''''';
dbms_output.put_line(v_str);
---EXECUTE IMMEDIATE V_STR INTO V_CNT;
---dbms_output.put_line(V_CNT);
end;

exec sp_dyn('EMP1');
SET SERVEROUTPUT ON
select count(*) from user_tables where table_name='EMP1';



create or replace procedure spp_dyn (p_tbll_name varchar2) as
v_str varchar2(200);
V_CNT INT;
begin
v_str:='select count(*) from user_tab_columns where table_name='||''''||p_tbll_name||'''';
dbms_output.put_line(v_str);
EXECUTE IMMEDIATE V_STR INTO V_CNT;
dbms_output.put_line(V_CNT);
end;

exec spp_dyn('AUTHOR');
SET SERVEROUTPUT ON
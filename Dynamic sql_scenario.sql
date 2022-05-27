Write a Stored Procedure by passing a table name at run time and display all its details
No of rows
No of columns
No of constraints
No of triggers
No of detail tables
No of Master tables
Owner of the table
Created date and time of the table
Last DML happened on the table

Also write a stored procedure to fetch all the tablenames and pass these tablenames dynamically to the above procedure.

--1. Number of Rows.

create or replace procedure sp_dyn (p_tbl_name varchar2) as
v_str varchar2(200);
v1_str varchar2(200);
V_CNT INT;
v_cntt int;
begin
    v1_str:='select count(*) from user_tables where table_name='||''''||upper(p_tbl_name)||'''';
    EXECUTE IMMEDIATE v1_str INTO v_cntt;
    if v_cntt=0 then
        dbms_output.put_line('No tables were present');
    else
        v_str:='select count(*) from '||p_tbl_name;
        dbms_output.put_line(v_str);
        EXECUTE IMMEDIATE V_STR INTO V_CNT;
        dbms_output.put_line(V_CNT);
        if V_CNT=0 then
        dbms_output.put_line('No rows were present');
        else
        dbms_output.put_line('Rows were present');
        end if;
end if;
end;

set serveroutput on
exec sp_dyn('EMP1');
exec sp_dyn('EMP111');


--2. Number of Columns.

create or replace procedure sp1_dyn (p_tbl_name varchar2) as
v_str varchar2(200);
v1_str varchar2(200);
V_CNT INT;
v_cntt int;
begin
    v1_str:='select count(*) from user_tables where table_name='||''''||upper(p_tbl_name)||'''';
    EXECUTE IMMEDIATE v1_str INTO v_cntt;
    if v_cntt=0 then
        dbms_output.put_line('No tables were present');
    else
        v_str:='select count(*) from user_tab_columns where table_name='||''''||upper(p_tbl_name)||'''';
        dbms_output.put_line(v_str);
        EXECUTE IMMEDIATE V_STR INTO V_CNT;
        
        if V_CNT=0 then
        dbms_output.put_line('No columns were present');
        else
        dbms_output.put_line('Number of Columns were present  '||v_cnt);
        end if;
end if;
end;

set serveroutput on
exec sp1_dyn('EMP1');
exec sp_dyn('EMP111');


---3. Number of constraints.

create or replace procedure sp1_dyn (p_tbl_name varchar2) as
v_str varchar2(200);
v1_str varchar2(200);
V_CNT INT;
v_cntt int;
begin
    v1_str:='select count(*) from user_tables where table_name='||''''||upper(p_tbl_name)||'''';
    EXECUTE IMMEDIATE v1_str INTO v_cntt;
    if v_cntt=0 then
        dbms_output.put_line('No tables were present');
    else
        v_str:='select constraint_name from user_constraints where table_name='||''''||upper(p_tbl_name)||'''';
        dbms_output.put_line(v_str);
        EXECUTE IMMEDIATE V_STR INTO V_CNT;
         if V_CNT=0 then
        dbms_output.put_line('No Constraints were present');
        else
        dbms_output.put_line('Number of Constraints were present  are  '||v_cnt);
        end if;
end if;
end;

set serveroutput on
exec sp1_dyn('EMP1');
exec sp_dyn('EMP111');


select constraint_name 
from user_constraints
where table_name='DOCTOR';

SELECT * FROM DOCTOR;
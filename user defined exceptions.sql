create or replace procedure sp_raise_pre_defined as
v_cnt int;
no_data exception;
begin
select count(*) into v_cnt
from emp1
where empno=1111;
if v_cnt=0 then
raise no_data;
end if;
dbms_output.put_line('employee exists');
exception
when no_data then
dbms_output.put_line('no employee');
end;

exec sp_raise_pre_defined;



create or replace procedure raise_user_pre_defined as
too_length exception;
v_no number;
begin
select phone into v_no 
from customer
where cust_bkey=1000;
if length(v_no)=10 then
dbms_output.put_line('valid phone no.');
else
    raise too_length;
end if;
exception
when too_length then
dbms_output.put_line('not valid number');
end;

exec raise_user_pre_defined;
select * from customer;

create or replace trigger trg_emp
before insert or update or delete on emp
for each row
begin
dbms_output.put_line('hello');
end;

update emp set sal=sal+1000 where empno=7788;
set serveroutput on

alter trigger trg_emp disable;

desc user_triggers

create or replace trigger trg_emp
after insert or update or delete on emp
for each row
begin
dbms_output.put_line('hello');
end;


create or replace trigger trg_emp_time
before insert or update or delete on emp
begin
if to_char(systimestamp,'hh24') not between 9 and 17 then
raise_application_error(-20010,'not business hrs');
end if;
end;

select to_char(sysdate,'hh24') from dual;

row level triggers only
insert :new
update :new   :old
delete :old

create or replace trigger trg_emp_sal
before update of sal on emp
for each row
begin
if :new.sal<:old.sal then
raise_application_error(-20001,'updated sal should be greater');
end if;
end;

update emp set sal=sal-1000 where empno=7788;

create or replace trigger trg_emp
after insert or update or delete on emp
begin
dbms_output.put_line('hello');
end;

create or replace trigger trg_emp
before insert or update or delete on emp
begin
dbms_output.put_line('hello');
end;

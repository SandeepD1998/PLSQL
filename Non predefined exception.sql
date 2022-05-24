Non Pre defined Exception

create or replace procedure sp_pragma_exception as
child_rec_exc exception;
pragma exception_init(child_rec_exc,-2292);
begin
delete from dept22 where deptno=10;
exception
when child_rec_exc then
--dbms_output.put_line('cannot delete parent records');
--dbms_output.put_line(SQLCODE||','||SQLERRM);
raise_application_error(-20010,'cannot delete');
end;

delete from dept22 where deptno=10;

exec sp_pragma_exception;

set serveroutput on

create or replace procedure sp_pragma_exception as
child_rec_exc exception;
pragma exception_init(child_rec_exc,-2292);
begin
delete from dept22 where deptno=10;
exception
when child_rec_exc then
--dbms_output.put_line('cannot delete parent records');
--dbms_output.put_line(SQLCODE||','||SQLERRM);
raise_application_error(-20010,'cannot delete');
end;

select * from emp1;




Create or replace procedure pro_up as  
   total_rows number(2); 
BEGIN 
   UPDATE emp1 
   SET sal = sal + 1000
   where empno=7521;
   IF sql%found THEN 
      total_rows := sql%rowcount;
      dbms_output.put_line( total_rows || ' employees selected ');  
    ELSIF sql%notfound THEN 
      dbms_output.put_line('no employees selected'); 
   END IF;  
END; 

set serveroutput on

exec pro_up;

select * from emp1;



create or replace procedure pro_var as
total_rows number(6);
begin
insert into emp1 values(7528,'manish','SALESMAN',765,'23-09-13',5676,456,10);
    if sql%found then
        total_rows:=sql%rowcount;
        dbms_output.put_line(total_rows||' '||' record inserted');
    elsif sql%notfound then
        dbms_output.put_line('not inserted');
    end if;
end;

exec pro_var;
select * from source_data;

select * from emp1;
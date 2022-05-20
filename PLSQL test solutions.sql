1. Write a procedure to count all the saturdays dates by passing year at run time.

create or replace procedure pro_sat(pro_year number) as
s_date date;
e_date date;
v_cnt number(30);
begin
s_date:=trunc(sysdate,'yy');
e_date:=add_months(trunc(sysdate,'yy'),12)-1;
v_cnt:=0;
while s_date<e_date loop
    if to_char(s_date,'dy')='sat' then
        dbms_output.put_line(s_date);
        v_cnt:=v_cnt+1;
    end if;
    s_date:=s_date+1;
end loop;
dbms_output.put_line(v_cnt);
end;

exec pro_sat(2020);
set serveroutput on

2. Write a procedure to print the string in a vertical manner with reverse.

create or replace procedure pro_str(str_nm varchar) as
begin
    for i in reverse 1..length(str_nm) loop
        dbms_output.put_line(substr(str_nm,i,1));
    end loop;
end;

exec pro_str('i am fun from today');

select level from dual
connect by level<=10;

3. Write a procedure to insert the records in tgt table from src table but before inserting which whether it exists or not.

Create or replace procedure pro_tgt as
Cursor cur_src is select cust_id,nm,city from src;
v_cnt number(12);
begin
    for i in cur_src loop
        select count(*) into v_cnt
        from tgt
        where cust_id=i.cust_id and nm=i.nm and city=i.city;
        if v_cnt=0 then
            insert into tgt values(i.cust_id,i.nm,i.city);
        else
            dbms_output.put_line('Values already inserted');
        end if;
end loop;
end;

4. write a function to return the factorial of a number.

create or replace function fun_fact(facto in number) return number as
facte number(10);
begin
facte:=1;
    for i in 1..(facto-1) loop
        facte:=facte*i;
    end loop;
    return facte;
end;

select fun_fact(5) result from dual;

5. Write a procedure to print the top 10 products based on sales amount by passing year at runtime.

Create or replace procedure pro_top(pas_y number) as
cursor cur_top is select proname,suamt 
from(select prod_name proname,sum(amount) suamt,dense_rank() over(order by sum(amount) desc)rnk
from product p,sales s
where p.p_id=s.p_id
and to_char(s_date,'yyyy')=pas_y
group by prod_name) d
where rnk<=10;

begin
    for i in cur_top loop
        dbms_output.put_line(i.proname);
end loop;
end;

exec pro_top(2022);


        

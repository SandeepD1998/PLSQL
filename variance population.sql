Create table source_data
(st_id number(5),
St_name varchar2(20),
Marks number(5));

insert into source_data values(100,'ram',45);
insert into source_data values(101,'tim',85);
insert into source_data values(102,'bala',95);
insert into source_data values(103,'sham',98);
insert into source_data values(104,'guru',37);
insert into source_data values(101,'tim',85);
insert into source_data values(100,'ram',45);

Create table target_data
(st_id number(5),
St_name varchar2(20),
Marks number(5),
Top_marks number(5),
Least_marks number(5),
Varience_from_lowest number(5),
Varience_from_highest number(5));

commit;

create or replace procedure var_pro as
cursor cur_proc is select st_id,st_name,marks from source_data;
v_cnt number(10);
begin
for i in cur_proc loop
select count(*) into v_cnt 
from target_data
where st_id=i.st_id and St_name=i.St_name and marks=i.marks;
if v_cnt=0 then
        insert into target_data values(i.st_id,i.St_name,i.marks,
        (select max(i.marks) from source_data),(select min(i.marks) from source_data),
        (i.marks- (select min(i.marks) from source_data)),( i.marks- (select max(i.marks) from source_data)));
end if;
end loop;
end;

exec var_pro;

select * from source_data;

select * from target_data;



SELECT ST_ID,ST_NAME,MARKS,A.TOP,A.LEAST,A.TOP-MARKS VARIENCE_TOP,A.LEAST-MARKS VARIENCE_LEAST
FROM (SELECT MAX(MARKS)TOP,MIN(MARKS)LEAST FROM SOURCE_DATA)A,SOURCE_DATA;

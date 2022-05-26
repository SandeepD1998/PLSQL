create table agency_src		
(agency varchar(20),		
program_name varchar(20),		
fiscal_year int,		
original_appr_amount numeric);

insert into agency_src values('Education','High School Grant',2005,350000);
insert into agency_src values('Education','Middle School Grant',	2005,50000);
insert into agency_src values ('Education','High School Grant',2004,250000);
insert into agency_src values('DEP','Air',2005,50000);
insert into agency_src values('DEP','Air',2004,60000);
insert into agency_src values('DEP','Water',2005,70000);



create table agency_tgt		
(agency varchar(20),		
program_name varchar(20),		
fiscal_year int,		
Original_appr_amount numeric,		
program_amount numeric,		
agency_amount numeric,		
total_amount numeric);		

commit;

select * from agency_src;
select * from agency_tgt;


select * from agency_tgt;
truncate table agency_tgt;


create or replace procedure pro_agency as
cursor get_data is select * from agency_src;
 begin
 for i in get_data loop
            insert into agency_tgt values(i.agency,i.program_name,i.fiscal_year,i.original_appr_amount,
            (select sum(original_appr_amount) from agency_src where program_name=i.program_name),
            (select sum(original_appr_amount) from agency_src where agency=i.agency),
            (select sum(original_appr_amount) from agency_src));
end loop;
end;


select d.agency,d.program_name,d.fiscal_year,d.original_appr_amount,a_tat,p_tat,tat
from(select sum(original_appr_amount) as a_tat,agency
        from agency_src
        group by agency)a,
    (select sum(original_appr_amount)as p_tat,program_name
    from agency_src
    group by program_name)b,
    (select sum(original_appr_amount)as tat
    from agency_src)c,agency_src d
    where a.agency=d.agency and b.program_name=d.program_name;



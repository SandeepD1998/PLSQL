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


create or replace procedure pro_edu_agency as
cursor cur_agency is (select agency,program_name,fiscal_year,original_appr_amount 
                                    from agency_src);
cursor cur_program is (select program_name,sum(original_appr_amount) as sum_pro
                                        from agency_src
                                        group by program_name);
cursor cur_agent is(select agency,sum(original_appr_amount) as sum_agen
                                    from agency_src
                                    group by agency);
                                    
v_sum number;
v_count number;
                                    
begin
            for i in cur_agency loop
                select sum(original_appr_amount) into v_sum
                from agency_src;
                select count(*) into v_count
                from agency_tgt
                where agency=i.agency and program_name=i.program_name and fiscal_year=i.fiscal_year and original_appr_amount=i.original_appr_amount;
                if v_count=0 then
                    insert into agency_tgt values(i.agency,i.program_name,i.fiscal_year,i.original_appr_amount,null,null,v_sum);
                end if;
            end loop; 
            
            for i in cur_program loop
                if v_count=0 then
                    update agency_tgt set program_amount=i.sum_pro
                    where program_name=i.program_name;
                end if;
            end loop;
            
            for i in cur_agent loop
                if v_count=0 then
                    update agency_tgt set agency_amount=i.sum_agen
                    where agency=i.agency;
                end if;
            end loop;
end;
            
        
set serveroutput on

exec pro_edu_agency;

select * from agency_tgt;



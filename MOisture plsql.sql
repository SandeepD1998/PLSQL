create table input	
(specification_mix varchar2(50),	
actual_value int);	

insert into input values('Ash 12345 Mix',12);
insert into input values('Moisture 1234 TY',13);
insert into input values('Protein 12A',	10);
insert into input values('Ash ABC 124',11);
insert into input values('Moisture Winter Wheat',14);

create table output_tbl	
(specification_mix varchar2(50),	
Actual_val int,	
Ash_val int,	
moisture_val int,	
protein_val int);

commit;



create or replace procedure pro_moistore as
cursor cur_moisture is select specification_mix,actual_value 
                                        from input; 
v_cnt number;
begin 
for i in cur_moisture loop
    select count(*) into v_cnt
    from output_tbl
    where specification_mix=i.specification_mix
    and actual_val=i.actual_value;
    if v_cnt=0 then
        if i.specification_mix like 'Ash%' then
            insert into output_tbl values(i.specification_mix,i.actual_value,i.actual_value,0,0);
        elsif i.specification_mix like 'Moisture%' then
            insert into output_tbl values(i.specification_mix,i.actual_value,0,i.actual_value,0);
        elsif i.specification_mix like 'Protein%' then 
            insert into output_tbl values(i.specification_mix,i.actual_value,0,0,i.actual_value);
        else
            dbms_output.put_line('entered the correct values');
        end if;
    end if;
end loop;
end;

exec pro_moistore;

set serveroutput on
            
       select * from output_tbl;     
        


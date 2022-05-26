create table cont_tab(
contract_id number(20),
contract_type varchar2(40),
cont_s_date date,
cont_e_date date,
cpt_id number(20),
cont_amt number(20),
ins_date date,
upd_date date);

select* from cont_tab;

insert into cont_tab values(12345,'government','10-jan-10','10-jan-11',101,700000,'10-jan-10',null);
insert into cont_tab values(12879,'government','03-feb-11','15-feb-12',102,489938,'03-feb-11',null);
insert into cont_tab values(12987,'government','15-feb-11','20-feb-13',103,200000,'15-feb-11',null);
insert into cont_tab values(12346,'government','01-sep-12','10-feb-13',100,400000,'01-Sep-12','10-apr-13');


create table expd_rcv_tab(exp_rec_id number(4),exp_rec_date date,contract_id number(20),amount number(20));

select * from expd_rcv_tab;

create table con_pay_terms(cpt_id number(20),freq_of_pmt varchar2(30));

select * from con_pay_terms;

insert into con_pay_terms values(100,'monthly');
insert into con_pay_terms values(101,'quarterly');
insert into con_pay_terms values(102,'half yearly');
insert into con_pay_terms values(103,'yearly');

commit;


select to_char(sysdate,'mm')+1 from dual;

select * from dict;

select * from cont_tab;

create sequence seq_contract;


create or replace procedure pro_contract as
cursor cur_contract is select  cont_s_date,cont_e_date,cpt_id,cont_amt from cont_tab;
no_of_months number;
last_date date;
v_cnt int;
begin
for i in cur_contract loop
    no_of_months:=months_between(i.cont_e_date,i.cont_s_date);
    last_date:=add_months(i.cont_s_date,no_of_months);
               if i.cpt_id=100 then
                while i.cont_s_date<last_date loop
                    insert into expd_rcv_tab values(seq_contract.nextval,i.cont_s_date,i.cpt_id,i.cont_amt/(no_of_months));
                        i.cont_s_date:=add_months(i.cont_s_date,1);
                end loop;
            end if;
            if i.cpt_id=101 then
                while i.cont_s_date<last_date loop
                     insert into expd_rcv_tab values(seq_contract.nextval,i.cont_s_date,i.cpt_id,i.cont_amt/((no_of_months)/4));
                        i.cont_s_date:=add_months(i.cont_s_date,3);
                end loop;
            end if;
             if i.cpt_id=102 then
                while i.cont_s_date<last_date loop
                     insert into expd_rcv_tab values(seq_contract.nextval,i.cont_s_date,i.cpt_id,i.cont_amt/((no_of_months)/6));
                        i.cont_s_date:=add_months(i.cont_s_date,6);
                end loop;
            end if;
             if i.cpt_id=103 then
                while i.cont_s_date<last_date loop
                     insert into expd_rcv_tab values(seq_contract.nextval,i.cont_s_date,i.cpt_id,i.cont_amt/((no_of_months)/24));
                        i.cont_s_date:=add_months(i.cont_s_date,12);
                end loop;
            end if;
    end loop;
commit;
exception
when others then
dbms_output.put_line(sqlcode||','||sqlerrm);
end;


set serveroutput on
exec pro_contract;
    
    
    select * from expd_rcv_tab;
    
    truncate table expd_rcv_tab;
                        
                    
                        
                        
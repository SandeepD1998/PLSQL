Write a procedure to populate the records from customer denormalized table to normalized tables.

create table tblCustomer(
                         cid int primary key,
                         cname   varchar(20),
                         addr    varchar(50),
                         phone   numeric,
                         dob     date,
                         email   varchar(50),
                         gender  char(2),
                         mart_stat varchar(10),
                         ct_name   varchar(40),
                         st_name  varchar(60) );

select * from tblCustomer
insert into tblCustomer values(1,'Megh','BTM',8544144889,'05-04-1995','mr@gmail.com','M','unmarried','BLR','KA');
insert into tblCustomer values(2,'Raj','Marathalli',7903635071,'15-11-1995','rr@gmail.com','M','unmarried','BLR','KA');
insert into tblCustomer values (3,'Rakesh','e_city',8102742599,'15-01-1995','rk@gmail.com','M','married','BLR','KA');
insert into tblCustomer values (4,'Megha','Rameshwaram',8544144886,'05-04-1996','me@gmail.com','F','unmarried','CHN','TN');
insert into tblCustomer values (5,'Rani','Bodhgaya',8544144889,'25-05-2001','ra@gmail.com','F','married','CHR','AN'); 

create  table tblState(st_id int primary key,st_name varchar(40));
                 
create table tblcity(ct_id int primary key,
                     ct_name varchar(40),
                     st_id int references tblstate(st_id));  
                
create table tblgender(gen_id int primary key,
                       gen char(2)); 

create table mart_stat(mart_id int primary key,
                       m_stat varchar(30));  

create table tblcust(cid int,
                     cname varchar(20),
                     addr varchar(50),
                     phone numeric,
                     dob date,
                     email varchar(50),
                     gen_id int references tblgender(gen_id),
                     mart_id int references mart_stat(mart_id),
                     ct_id int references tblcity(ct_id) );       
                     
                     commit;
                     
select * from tblCustomer;
select * from tblcust;
select * from mart_stat;
select * from tblgender;
select * from tblcity;
select * from tblState;

Create sequence seq_mart
start with 401
increment by 1
minvalue 400
maxvalue 500
cycle;


create or replace procedure pro_tgt as
cursor cur_tgt is select   cid, cname, addr, phone, dob, email,gender,mart_stat,ct_name,st_name from tblcustomer;
v_cnt number;
v_ct number;
v_cct number;
v_ctt number;
begin
    for i in cur_tgt loop
        select count(*) into v_cnt
        from tblState
        where st_name=i.st_name;
        if v_cnt=0 then
            insert into tblState values(seq_st.nextval,i.st_name);
        end if;
        select count(*) into v_ct
        from tblcity
        where ct_name=i.ct_name;
        if v_ct=0 then
            insert into tblcity values(seq_ct.nextval,i.ct_name,(select case when i.ct_name='BLR' then 101
                                                                                                when i.ct_name='CHN' then 102
                                                                                                when i.ct_name='CHR' then 103
                                                                                                end st_id
                                                                                                from tblState));
        end if;
        select count(*) into v_ctt
        from tblgender
        where gen=i.gender;
        if v_ctt=0 then
            insert into tblgender values(seq_gen.nextval,(select distinct(i.gender) from tblcustomer));
        end if;
        select count(*) into v_cct
        from mart_stat
        where m_stat=i.mart_stat;
        if v_cct=0 then
            insert into mart_stat values(seq_mart.nextval,(select distinct(i.mart_stat) from mart_stat));
        end if;
end loop;
exception
when others then
dbms_output.put_line(sqlcode||','||sqlerrm);
end;

set serveroutput on

exec pro_tgt;
            
---SQL------
1. insert into state values(select seq_state.nextval,a.state_name
                                        from(select distinct state_name 
                                        from tblcustomer) a);
                
2. insert into city values(select seq_city.nextval,A.city_name,A.st_id
                                            from(select distinct city_name,distinct st_id
                                            from tblcustomer a,state b
                                            where a.st_name=b.st_name)A);
                                            
3. insert into tblgender values(select seq_gender.nextval,a.gender
                                                    from(select distinct gender 
                                                    from tblcustomer)a);
                                                    
4. insert into tblmart values(select seq_mart.nextval,a.mart_stat
                                                from(select distinct mat_stat from tblcustomer)a);
                                                
5. insert into tbl_cust values(select c_name,addr,phone,dob,email,distinct gen_id,distinct mart_id,distinct city_id
                                                    from tblcustomer a,tblgender b,tblmart c,tblcity d
                                                    where a.city_name=d.city_name and
                                                    a.gender=b.gender
                                                    a.mart_stat=c.mart_stat);
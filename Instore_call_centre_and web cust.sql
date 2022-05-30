create table instore(cust_id number,cust_name varchar(20),city varchar(20),store_name varchar(20));
INSERT INTO INSTORE VALUES ('1', 'TIM', 'BANGALORE', 'COSTA COFEE');
INSERT INTO INSTORE VALUES ('2', 'BIM', 'MANGALORE', 'BIG BAZAR');
INSERT INTO INSTORE VALUES ('3', 'RICK', 'TEXAS', 'MORE');
INSERT INTO INSTORE VALUES ('4', 'SMITH', 'LONDON', 'SHOPER STOP');

create table web_cust(cust_id number,cust_name varchar(20),cust_city varchar(20),email varchar(30),status varchar(20));
INSERT INTO WEB_CUST VALUES ('11', 'RAM', 'KOLAR', 'RAM@GMAIL.COM', 'BOUNCED');
INSERT INTO WEB_CUST VALUES ('12', 'SHAM', 'MYSORE', 'COMPLETED');
INSERT INTO WEB_CUST VALUES ('13', 'SMITHA', 'TEXAS', 'SMITHA@GMAIL.COM', 'COMPLETED');
INSERT INTO WEB_CUST VALUES ('14', 'SMITH', 'LONDON', 'SMITH@YAHOO.COM', 'PROCESSED'); 
INSERT INTO WEB_CUST VALUES ('15', 'TIM', 'BANGALORE', 'TIM@YAHOO.COM', 'PROCESSED'); 

create table call_center_cust(cust_id number,cust_name varchar(20),city varchar(20),rep_name varchar(20),phone number);
INSERT INTO CALL_CENTER_CUST VALUES ('21', 'RAM', 'KOLAR', 'RAJESH', '8876543345');
INSERT INTO CALL_CENTER_CUST VALUES ('22', 'TIM', 'BANGALORE', 'RAMESH', '2323245678');
INSERT INTO CALL_CENTER_CUST VALUES ('23', 'MICK', 'TEXAS', 'NASREEN',null);
INSERT INTO CALL_CENTER_CUST VALUES ('24', 'DAVID', 'MAGALORE', 'THRUPA', '4576988999'); 

CREATE TABLE TARGET_TABLE_CUST_DIM(cust_id number,cust_name varchar(20),city varchar(20),email varchar(30),phone number,rep_name varchar(20),SRC_CUST_ID NUMBER,SOURCE VARCHAR(20));
CREATE TABLE REJECT_CUST_TABLE(REJ_ID NUMBER,SRC_REC VARCHAR(20),REASON VARCHAR(100));

COMMIT;
select * from call_center_cust;

select cust_id,cust_name,city,null,null
from instore
union
select cust_id,cust_name,cust_city,email,null
from web_cust
union
select cust_id,cust_name,city,rep_name,phone
from call_center_cust;


create sequence seq_target;
create sequence seq_rej;

create or replace procedure pro_call as
cursor cur_instore is (select cust_id,cust_name,city,store_name 
                                    from instore);
cursor cur_web is (select cust_id,cust_name,cust_city,email,status
                                from web_cust);
cursor cur_call is (select cust_id,cust_name,city,rep_name,phone
                                from call_center_cust);
v_cnt number;
v_ct number;
begin
    for i in cur_instore loop
        if i.store_name != null then
             insert into TARGET_TABLE_CUST_DIM(cust_id,cust_name,city,SRC_CUST_ID,SOURCE) values (seq_target.nextval,i.cust_name,i.city,i.cust_id,'INSTORE');
        end if;
    end loop;
    for i in cur_call loop
        select count(*) into v_cnt
        from target_table_cust_dim
        where cust_name=i.cust_name and
        city=i.city;
            if v_cnt=1 then
                if i.phone=null then
                    update target_table_cust_dim set rep_name=i.rep_name,phone=i.phone where cust_name=i.cust_name;
                else
                     insert into REJECT_CUST_TABLE(REJ_ID,SRC_REC,REASON) values (seq_rej.nextval,i.cust_id,'Phone is null');
                end if;
            else
                    insert into target_table_cust_dim(cust_id,cust_name,city,phone,rep_name,src_cust_id,source) values (seq_target.nextval,i.cust_name,i.city,i.phone,i.rep_name,i.cust_id,'CALL_CENTER');
            end if;
    end loop;
    for i in cur_web loop
        select count(*) into v_ct 
        from target_table_cust_dim
        where cust_name=i.cust_name and
        city=i.cust_city;
        if v_ct=1 then
            update target_table_cust_dim set email=i.email where cust_name=i.cust_name and city=i.cust_city;
        else
                if i.status !='Bounced' then
                    if i.email != null then
                        insert into target_table_cust_dim(cust_id,cust_name,city,email,src_cust_id,source) values (seq_target.nextval,i.cust_name,i.cust_city,i.email,i.cust_id,'Web_cust');
                    else
                        insert into REJECT_CUST_TABLE(REJ_ID,SRC_REC,REASON) values (seq_rej.nextval,i.cust_id,'Email is Empty');
                    end if;
                else
                    insert into reject_cust_table(rej_id,src_rec,reason) values (seq_rej.nextval,i.cust_id,'Bounced');
                end if;
        end if;
    end loop;
end;

set serveroutput on

exec pro_call;

select * from target_table_cust_dim;

select * from reject_cust_table;
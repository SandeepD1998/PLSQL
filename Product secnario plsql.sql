Create table store_product
(s_prod_id number,
S_p_code varchar2(20),
S_p_name varchar(20),
Sku_id number,
Cost number,
Price number
);


insert into store_product values(1101,'A1234','laptop',9456,30000,32000);
insert into store_product values(1102,'A1235','headphone',9457,5000,4000);
insert into store_product values(1103,'A1236','monitor',9458,1000,2000);
insert into store_product values(1104,'A1237','earphone',9459,500,600);
insert into store_product values(1105,'A1238','cpu',9460,6000,7000);

Create table online_product
(o_prod_id number,
prod_name varchar(20),
Sku_id number,
Online_Price number,
discount number,
Online_cost number,
Launch_dt date
);

insert into online_product values(1501,'Dell laptop',9456,35000,1000,40000,'21-jun-19');
insert into online_product values(1502,'headphone',9457,4000,500,3000,'11-mar-19');
insert into online_product values(1503,'Chair',9461,2000,200,1500,'13-jan-19');
insert into online_product values(1504,'Table',9462,8000,1200,7000,'26-feb-19');
insert into online_product values(1505,'Sofa',9463,70000,5000,75000,'09-sep-19');

Create table product_master
(p_id number,
Sku_id number,
P_name varchar(20),
P_cost number, 
Store_price number,
Online_price number,
P_code varchar2(20),
Launch_date date
);

commit;

create sequence seq_product;


create or replace procedure pro_product as
cursor cur_sales is select * from store_product;
cursor cur_online is select * from online_product;
v_cnt number;
v_ctt number;
begin
    for i in cur_sales loop
        select count(*) into v_cnt
        from product_master
        where SKU_ID=i.SKU_ID;
        if v_cnt=0 then 
            insert into product_master (P_ID,SKU_ID,P_NAME,P_COST,STORE_PRICE,P_CODE) values (seq_product.nextval,i.SKU_ID,i.s_p_name,i.cost,i.price,i.s_p_code);
        end if;
    end loop;
    for i in cur_online loop
        select count(*) into v_ctt
        from product_master
        where SKU_ID=i.SKU_ID;
        if v_ctt=0 then
            insert into product_master (P_ID,SKU_ID,P_NAME,ONLINE_PRICE,launch_date) values (seq_product.nextval,i.SKU_ID,i.prod_name,i.online_price,i.launch_dt);
        else
            update product_master set online_price=i.online_price,launch_date=i.launch_dt where SKU_ID=i.SKU_ID;
            update product_master set p_cost=i.online_cost where p_cost<i.online_cost and SKU_ID=i.SKU_ID;
        end if;
    end loop;
    commit;
end;
     
set serveroutput on

exec pro_product;

select * from product_master;

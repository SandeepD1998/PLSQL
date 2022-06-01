create table store_sales
(store varchar(20),
product varchar(20),
sales numeric);

insert into store_sales values('s1','tv',456);
insert into store_sales values('s1','tv',654);
insert into store_sales values('s1','tv',849);
insert into store_sales values('s2','tv',849);
insert into store_sales values('s2','tv',345);
insert into store_sales values('s2','mouse',45);
insert into store_sales values('s2','dvd',213);

select * from store_sales
select * from store_summary

create table store_summary
(store varchar(20),
AvgSalesTV numeric,
AvgSalesDVD numeric,
others numeric);

commit;

create or replace procedure pro_store as
cursor cur_tv is select store,avg(sales) a_sel
                            from store_sales   
                            where product='tv' 
                            group by store
                            order by store;
cursor cur_dvd is select store,avg(sales) a_sal
                                from store_sales
                                where product not in ('tv','mouse')
                                group by store
                                order by store;
cursor cur_mouse is select store,avg(sales) a_saal
                                from store_sales
                                where product not in ('tv','dvd')
                                group by store
                                order by store;
v_cnt number;
v_ctt number;
v_t number;
begin
    for i in cur_tv loop
        select count(*) into v_cnt
        from store_summary
        where store=i.store;
            if v_cnt=0 then
                insert into store_summary (store,avgsalestv) values (i.store,i.a_sel);
            end if;
    end loop;
    for i in cur_dvd loop
        select count(*) into v_ctt
        from store_summary
        where store=i.store;
            if v_ctt=1 then
                update store_summary set avgsalesdvd=i.a_sal where store=i.store;
            end if;
    end loop;
    for i in cur_mouse loop
        select count(*) into v_t
        from store_summary
        where store=i.store;
            if v_t=1 then
                update store_summary set others=i.a_saal where store=i.store;
            end if;
    end loop;
commit;
end;

set serveroutput on

exec pro_store;

select * from store_summary;
truncate table store_summary;

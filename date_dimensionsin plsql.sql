create table date_dimension
(DATE_KEY int Primary key,
ACCURATE_DATE date,
DAY_NUMBER_OF_WEEK int,
DAY_NUMBER_OF_MONTH int,
DAY_NUMBER_OF_YEAR int,
WEEK_NO_OF_MONTH int,
WEEK_NO_YEAR int,
MONTH_NO int,
MONTH_SHORT_NAME varchar(20),
MONTH_FULL_NAME varchar(20),
QTR_NO int,
SEMESTER_NO int,
CALENDER_YEAR int,
FISCAL_MONTH int,
FISCAL_WEEK int,
FISCAL_QTR int,
FISCAL_YEAR varchar(20),
WEEK_DAY_FLAG varchar(10));

commit;

select add_months(trunc(sysdate,'yy'),3) from dual;

select add_months(trunc(sysdate,'yy'),12)-1  from dual;

create or replace procedure pro_date(pro_dates date) as
s_date date;
e_date date;
begin
    s_date:=trunc(pro_dates,'yyyy');
    e_date:=add_months(trunc(sysdate,'yy'),12)-1;
        while s_date<e_date loop
            insert into date_dimension(select seq_dates.nextval,
                                                            to_char(pro_dates,'dd-mm-yyyy'),
                                                             to_char(pro_dates,'d'),
                                                            to_char(pro_dates,'dd'),
                                                            to_char(pro_dates,'ddd'),
                                                            to_char(pro_dates,'w'),
                                                            to_char(pro_dates,'ww'),
                                                            to_char(pro_dates,'mm'),
                                                            to_char(pro_dates,'mon'),
                                                            to_char(pro_dates,'month'),
                                                            to_char(pro_dates,'q'),
                                                            (case when to_char(pro_dates,'mm') in (1,2,3,4,5,6) then 1
                                                                      when to_char(pro_dates,'mm') in (7,8,9,10,11,12) then 2
                                                             end),
                                                             to_char(pro_dates,'dd-mm-yyyy'),
                                                             (to_char(add_months(pro_dates,'yy'),3),'mm'),
                                                             (to_char(add_months(pro_dates,'yy'),3),'w'),
                                                             (to_char(add_months(pro_dates,'yy'),3),'q'),
                                                             (to_char(add_months(pro_dates,'yy'),3),'yyyy'),
                                                             (case when to_char(pro_dates,'dy') in ('sat','sun') then 'N'
                                                                     else 'Y'
                                                                     end)) from dual;
                s_date:=s_date+1;
        end loop;
end;
    
    
    create sequence seq_dates;
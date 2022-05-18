Create or replace procedure pro_val as 
   e_id emp1.empno%type; 
   e_name emp1.ename%type; 
   e_comm emp1.comm%type; 
   CURSOR cur_emp is 
      SELECT empno, ename, comm FROM emp1; 
BEGIN 
   OPEN cur_emp; 
   LOOP 
   FETCH cur_emp into e_id, e_name, e_comm; 
      EXIT WHEN cur_emp%notfound; 
      dbms_output.put_line(e_id || ' ' || e_name || ' ' || e_comm); 
   END LOOP; 
   CLOSE cur_emp; 
END; 

exec pro_val;
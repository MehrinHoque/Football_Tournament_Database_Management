SPOOL solution2
SET ECHO ON
SET FEEDBACK ON
SET LINESIZE 100
SET PAGESIZE 200



ALTER TABLE DEPARTMENT ADD total_emp VARCHAR(20) NULL;

ALTER TABLE DEPARTMENT
    ADD CONSTRAINT emp_count CHECK (total_emp >= 0);


/* ALTER TABLE DEPARTMENT DROP COLUMN emp_count; */

UPDATE DEPARTMENT 
  set total_emp = 
    (select count(DName)
    from employee 
    WHERE DEPARTMENT.DName = employee.DName 
    group by DName);
    
    
    
    
    
CREATE OR REPLACE PROCEDURE INSERT_employee ( emp#       IN char,                                                   
                                              emp_name       IN VARCHAR,  
                                              date_of_birth    IN date, 
                                              sup#       IN CHAR,
                                              dept_name     IN VARCHAR) IS 
                                              
 BEGIN 
 
 
 INSERT INTO employee VALUES( emp#, emp_name, date_of_birth, sup#, dept_name);
 
 UPDATE department 
 SET total_emp = total_emp + 1
 WHERE DName = dept_name;
 
 EXCEPTION 
     WHEN no_data_found THEN
        dbms_output.put_line('no data inserted');
    WHEN OTHERS THEN 
        dbms_output.put_line(SQLERRM);
 
 COMMIT; 
 
 
 END INSERT_employee;
 /
 
 

    
CREATE OR REPLACE PROCEDURE DELETE_emp ( emp#       IN char,                                                   
                                              emp_name       IN VARCHAR,  
                                              date_of_birth    IN date, 
                                              sup#       IN CHAR,
                                              dept_name     IN VARCHAR) IS 
                                              
 BEGIN 
 
 
  
DELETE FROM EMPLOYEE WHERE E# = emp#;
 
 UPDATE department 
 SET total_emp = total_emp - 1
 WHERE DName = dept_name;
 
 EXCEPTION 
     WHEN no_data_found THEN
        dbms_output.put_line('no data inserted');
    WHEN OTHERS THEN 
        dbms_output.put_line(SQLERRM);
 
 COMMIT; 
 
 
 END DELETE_emp;
 /
 
 
select * from DEPARTMENT;



EXECUTE INSERT_employee(12345, 'Mosammat', TO_DATE('1959-01-13','YYYY-MM-DD'), 22222, 'Engineering');

select * from DEPARTMENT;





EXECUTE DELETE_emp(12345, 'Mosammat', TO_DATE('1959-01-13','YYYY-MM-DD'), 22222, 'Engineering');

select * from DEPARTMENT;

SPOOL OFF
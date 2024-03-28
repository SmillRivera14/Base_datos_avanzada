/*Cree estas Tablas
CREATE TABLE emp
AS select * FROM employees;
CREATE TABLE dept
AS select * FROM departments;*/

CREATE TABLE emp
AS select * FROM employees;

CREATE TABLE dept
AS select * FROM departments;

select * from dept


/*Escriba la Consulta
� Problem: 
� Cree un informe que muestre el nombre de restricci�n, el tipo, 
el nombre de columna y la posici�n de columna de todas las 
restricciones de la tabla JOB_HISTORY, adem�s de las 
restricciones no nulas.
� Tablas Usadas:
� user_constraints, user_cons_columns*/

select userCons.constraint_name, userCons.constraint_type, 
userConsCol.column_name, userConsCol.position
from 
user_constraints userCons full join user_cons_columns userConsCol
on userCons.owner = userConsCol.owner
where userCons.table_name = 'JOB_HISTORY' and userConsCol.position is not null;


/*Cree la Sentencia
� Cree una restricci�n de clave primaria en la columna 
employee_id de la tabla emp.*/

ALTER TABLE emp
ADD constraint emp_employee_id_pk PRIMARY KEY (employee_id);

select constraint_name, constraint_type, table_name, status, index_name 
from user_constraints
where table_name = upper ('emp') and constraint_type = 'p'

/*� Cree una clave primaria en la columna department_id 
de la tabla dept.*/

Alter table dept 
add constraint dept_department_id_pk primary key (department_id);

select constraint_name, constraint_type, table_name, status, index_name from user_constraints
where table_name = upper ('dept') and constraint_type = 'p';

/*Corrija el C�digo
� Problem: 
� Agregue una restricci�n ajena entre DEPT y EMP, para que en la 
tabla EMP solo se puedan introducir departamentos v�lidos, 
pero aseg�rese de que puede suprimir cualquier fila de la 
tabla DEPT.
� Sentencia:
ALTER TABLE emp
CREATE CONSTRAINT FOREIGN KEY (dept_id) REFS dept(deptid) 
on del cascade*/

ALTER table emp ADD CONSTRAINT emp_dept_department_td_fk FOREIGN KEY (department_id)
references dept (department_id) on delete cascade;


/*Cree el C�digo
� Pruebe la restricci�n de clave ajena que acaba de 
crear siguiendo los ejemplos de esta diapositiva.*/

select count (*) as "numero emps" from emp

/*
� Examine el n�mero de filas de la tabla EMP. Elimine 
los detalles del departamento 10 de la tabla dept.*/

delete dept where deparment_id = 10;

/*
� Ahora cuente emps de nuevo y compruebe si 
tambi�n hay menos empleados.
SELECT COUNT(*) AS "Num emps"
FROM emp;
DELETE dept
WHERE department_id = 10;
SELECT COUNT(*) AS "Num emps"
FROM emp;*/

select count (*) as "numero emps" from emp

/*Escriba la Consulta
� Problem:
� Genere un informe que devuelva el apellido, el salario, el 
n�mero de departamento y el salario medio de todos los 
departamentos en los que el salario es mayor que el salario 
medio.
� Tablas Usadas:
� Employees, Departments*/



/*Escriba el C�digo
� Problem:
� Cree una vista denominada V2 que devuelve el salario m�s 
alto, el salario m�s bajo, el salario medio y el nombre del 
departamento.
� Tablas Usadas:
� emp, dept SELECT * FROM v2;*/

 create view V2
 AS 
 select department_name as "Nombre del departamento",  round( min (salary)) as "Salario m�nimo",
    round(avg(nvl(salary,0))) as "salario promedio",  round(max(salary)) as "Salario mayor"
        from employees e join departments d on e.department_id = d.department_id
            group by department_name
 
 select * from V2
 
/*Escriba el C�digo
� Problem:
� Cree una vista denominada Dept_Managers_view que 
devuelva una lista de nombres de departamento junto con las 
iniciales y el apellido del jefe para dicho departamento. 
� Pruebe la vista devolviendo todas sus filas. 
� Aseg�rese de que no se pueda actualizar ninguna fila a trav�s 
de la vista.
� Vuelva a ejecutar una sentencia 
UPDATE en la vista.
� Tablas Usadas:
� Employees, departments*/
create view Dept_Managers_view
AS select  department_name as "Nombre del departamento", substr (first_name, 1, 1) || '.' || last_name "Jefe"
        from employees e join departments d on e.department_id = d.department_id
            where e.employee_id = d.manager_id

select * from Dept_Managers_view


/*Corrija el C�digo
� Problem:
� La siguiente sentencia contiene errores.
� Corr�jalos y ejecute el c�digo para obtener el resultado que 
se muestra.
� C�digo:
DROP V3 views;*/

drop view v2

/*Cree una Secuencia y Corrija el C�digo
� Problem:

� Cree una secuencia denominada ct_seq con todos los valores 
por defecto. Ejecute las sentencias y corrija el error. 
� Corrija la sentencia para que devuelva el n�mero posterior.
� C�digo:
CREATE SEQUENCE ct_seq;
SELECT ct_seq.currval
FROM dual;*/


CREATE SEQUENCE ct_seq;
SELECT ct_seq.nextval, ct_seq.currval
FROM dual;


/*Corrija el C�digo
� Problem:
� Observe la sentencia INSERT y corrija el error.
� C�digo:
INSERT emp
(employee_id,first_name,last_name,email,phone_number,
hire_date,job_id,salary,commission_pct,manager_id,department_id)
VALUS
(currval.ct_seq,'Kaare','Hansen','KHANSEN','44965 832123',sysdate, 
'Manager',6500,null,100,10)*/


INSERT INTO emp
(employee_id,first_name,last_name,email,phone_number,
hire_date,job_id,salary,commission_pct,manager_id,department_id)
VALUES
(ct_seq.nextval,'Kaare','Hansen','KHANSEN','44965 832123',sysdate,
'Manager',6500,null,100,20)


/*Corrija el C�digo
� Problem:
� Corrija el error en la sentencia SQL para crear el �ndice como se 
muestra en la captura de pantalla.
� C�digo:
CREATE INX emp indx FOR TABLE emp(employee_id DESC, 
UPPR(SUBST(firstname,1.1 ||" "||astname)*/


CREATE INDEX EMP_INDEX 
ON EMP(employee_id DESC, UPPER(SUBSTR("FIRST_NAME",1,1)||' 
'||"LAST_NAME"));


/*Escriba el C�digo
� Problem:
� Escriba la sentencia 
SQL para mostrar 
todas las tablas 
de usuario que 
contienen 
el nombre PRIV. 
� Tablas Usadas:
� dictionary*/

select table_name from dictionary where table_name like '%PRIV%'

/*Corrija el C�digo
� Problem:
� Conceda acceso de selecci�n a p�blico en la tabla EMP y 
verifique que se ha otorgado mediante la ejecuci�n esta 
consulta. La consulta contiene errores que debe corregir antes 
de poder ejecutar la sentencia SELECT.
� C�digo:
GRANT SELECT ON emp TO PUBLIC
SELECT *
FROM usr_tab_privs
WHERE tablename = "emp"*/

select * from user_tab_privs where table_name = 'EMP'

GRANT SELECT ON emp TO PUBLIC

/*Escriba el C�digo
� Problem:
� Mediante las uniones propiedad de Oracle, construya una 
instrucci�n que devuelva todos los employee_id unidos a todos 
los department_names.
� Tablas Usadas:
� Employees, departments*/

select e.employee_id, d.department_name from employees e, departments d

/*Escriba el C�digo
� Problem:
� Vuelva a utilizar las Uniones 
Oracle para corregir la sentencia 
anterior de modo que devuelva 
solo el nombre del departamento 
en el que est� trabajando el 
empleado actualmente.
� Tablas Usadas:
� Employees, departments*/

SELECT employees.employee_id, departments.department_name
FROM employees, departments
WHERE employees.department_id = departments.department_id;

/*Escriba el C�digo
� Problem:
� Vuelva a utilizar las Uniones 
Oracle para crear una consulta 
que muestre el apellido de los 
empleados, el nombre de 
departamento, el salario y el 
nombre del pa�s de todos los 
empleados.
� Tablas Usadas:
� Employees, departments, 
locations y countries*/

SELECT employees.last_name, departments.department_name,employees.salary, countries.country_name
FROM employees, departments, locations, countries
WHERE employees.department_id = departments.department_id
and departments.location_id = locations.location_id
and locations.country_id = countries.country_id

/*Escriba el C�digo
� Problem:
� Vuelva a utilizar la sintaxis de 
uni�n de Oracle para modificar la 
consulta anterior de modo que 
incluya tambi�n incluye el 
registro de empleado del 
empleado sin department_id, 
'Grant'.
� Tablas Usadas:
� Employees, departments, 
locations y countries*/

SELECT e.last_name, d.department_name, e.salary, c.country_name
from employees e, departments d, locations l , countries c
where  e.department_id = d.department_id (+)
and d.location_id = l.location_id
and l.country_id = c.country_id;


SELECT e.last_name, d.department_id, 
d.department_name
FROM employees e, departments d
WHERE e.department_id = 
d.department_id(+);

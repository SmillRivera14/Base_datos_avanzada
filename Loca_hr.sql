Select * from hr.DEPARTMENTS
Select * from hr.employees 



/*Ejercicio 1*/
select 
first_name ||' '|| last_name as "Nombre_empleados",
job_id as "Puesto de tabajo"
from hr.employees
where department_id = 110;

/*Ejercicio 2
Se requiere un reporte que muestre apellido, salario y departamento de todos los empleados que iniciaron su labor en la empresa en el año 2003.*/

select 
 LAST_NAME as "Apellido", Salary, department_name AS "NOMBRE DE DEPARTAMENTO", HIRE_DATE "fecha de contratación"
from hr.employees join hr.DEPARTMENTS on hr.employees.department_id = hr.DEPARTMENTS.DEPARTMENT_ID
Where hire_date between '01/01/2003' and '31/12/03';

/*Ejercicio 3
El Gerente de la empresa ha decidió incluir en el presupuesto del próximo año un aumento salarial de un 30% para todos aquellos empleados que no ganan comisión,
por lo tanto, ha solicitado que un informe donde se vea el nombre del empleado, apellido, el salario actual, y la proyección del salario con el aumento.*/

select 
first_name "nombre", last_name "apellido", Salary "salario actual", Salary + ((30/100)*salary ) as "Proyección"
from hr.employees 
where commission_pct is NULL;

/* ejercicio 4
A causa de la crisis financiera que ha provocado la pandemia del Covid-19 la empresa ha decidido reducir 500 US al salario de todo el personal, 
excepto a los que trabajan en el departamento de informática, ya que estos han sido el sostén de la compañía en el comercio electrónico que ha tenido que innovar.*/

select first_name "nombre", last_name "apellido", JOB_ID as "puesto de trabajo", Salary "salario actual", Salary - 500 as "Salario reducido"
from hr.employees 
where JOB_ID <> 'IT_PROG';

/*ejercicio 5
Se está haciendo una re-estructuración del personal de la compañía, y se necesita un reporte de los nombres de todas las posiciones que tiene la empresa,
en este reporte no deben de aparecer posiciones duplicadas, y el mismo debe estar ordenado alfabéticamente.*/

Select distinct JOB_ID "Posiciones de la empresa" from hr.employees order by JOB_ID

/*6.Genere una consulta que liste solo los nombres y el salario de los empleados que trabajan en los departamentos 
60 y 80 que ganan una comisión no menor de 20% y cuyo nombre o apellido comienza con la letra ‘D’*/

select first_name "nombre", last_name "apellido", Salary "salario", COMMISSION_PCT "Comición"
from hr.employees 
where   department_id in (60,80) and (COMMISSION_PCT < .20 and
first_name like 'D%' or last_name like 'D%')

/*7.Genere un reporte donde se muestre el código, nombre, apellido y salario de los empleados que se apellidan Cambrault y Grant. 
Este reporte debe estar organizado por la fecha de contratación.*/

select EMPLOYEE_ID, first_name "nombre", last_name "apellido", Salary "salario",  HIRE_DATE "fecha de contratación"
from hr.employees 
where   last_name like 'Cambrault' or last_name like 'Grant'
order by  HIRE_DATE 

/*8. Se está haciendo una auditoria en la empresa para identificar si hay algún empleado con botellas. 
Dentro de las informaciones que pidieron los auditores es necesario generar una lista de los empleados que no tienen un departamento asignado.*/

select EMPLOYEE_ID "ID", first_name "nombre", last_name "apellido", Salary "salario", DEPARTMENT_ID "departamento"
from hr.employees 
where  DEPARTMENT_ID IS NULL


/*9.El presidente de la empresa ha decidido conceder a todos los empleados un aumento del 5 % de su salario y un incentivo de 100 USD por cumplimiento de la meta. 
Sin embargo, al ver los resultados, no podía entender por qué los nuevos aumentos no eran los que había previsto. \
El sr. King debería de tener un nuevo salario de 25,300$, el de Sr. John Chen debería ser de 8,710$ y el de la Sra. Mikkilineni de 2,935 $. 
Ha utilizado la siguiente consulta. SELECT last_name, salary *.05 +100 FROM hr.employees. ¿Qué debería haber hecho?  */


select first_name "nombre", last_name "apellido", Salary "salario actual", Salary + ((5/100)*salary ) as "Aumento", 
Salary + ((5/100)*salary ) + 100 as "Salario más incentivo"
from hr.employees 


/*10. En el siguiente ejemplo, identifique las palabras clave, las cláusulas y las sentencias:  

SELECT employee_id, last_name FROM employees*/

/*Sentencias 
Select 

palabras clave
from

Clausulas
employee_id
last_name

*/

/*11.          Si el impuesto = 8,5% * costo_vehículo y el permiso_conducir = costo_vehículo * 0,01%, ¿qué valor generará el pago de vehículo más alto?
a.       Pago = (costo_vehículo * 1,25) + 5,00 - (impuesto) - (permiso_conducir)
b.      Pago = costo_vehículo * 1,25 + 5,00 - (impuesto - permiso_conducir)  
*/
costo_vehículo = 888
impuesto = 8,5% * costo_vehículo
permiso_conducir = costo_vehículo * 0,01

a.  Pago = (costo_vehículo * 1,25) + 5,00 - (impuesto) - (permiso_conducir)

select (888*1.25)+5.00 - (8.5*888 - 888*0.01)
from dual

/*12.          ¿Cómo se van a etiquetar las cabeceras de columna en el siguiente ejemplo?
 SELECT bear_id bears, color AS Color, age “age” FROM animals;
 */
---a.      bears, color, age
---b.       BEARS, COLOR, AGE
c.        BEARS, COLOR, age (DE ESTA MANERA)
---d.      Bears, Color, Age


/*13.Necesito que me proporcione el número telefónico de Alexander khoo*/

Select first_name "nombre", last_name "apellido", PHONE_NUMBER from hr.employees 
where first_name like 'Alexander' and last_name like 'Khoo'

/*14.Solo necesito la columna manager_id y ninguna otra columna de la tabla de empleado.*/

select manager_id from hr.employees

/*15.Los manager id diferentes que existen en la tabla de empleados.*/

select distinct manager_id from hr.employees

/*16. ¿Cuáles de las siguientes afirmaciones son verdaderas?
      a. null * 25 = 0; resultado nulo
      
       b. null * 6.00 = 6.00 resultado nulo
       
      c. null * .05 = null resultado nulo
      
      d. (null + 1.00) + 5.00 = 5.00 resultado nulo
      
*/

SELECT FIRST_NAME "Primer nombre", LAST_NAME "Apellido", hire_date "Fecha de contratacion"
FROM employees
where hire_date >(select hire_date
                    from employees
                    where first_name = 'Peter'
                    and last_name = 'Vargas' )
                    

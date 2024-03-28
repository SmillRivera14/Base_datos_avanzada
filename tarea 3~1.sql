
/*1. Genere una consulta que liste solo los nombres y el salario de los empleados que trabajan en los departamentos 100 y 80, y que fueron contratados hace m�s de 365
d�as, que ganan una comisi�n no menor de 20% y cuyo nombre o apellido comienza con la letra �D�.*/

select last_name , salary, hire_date from hr.employees 
where department_id in (100,80) and (COMMISSION_PCT > .20 and
first_name like 'D%' or last_name like 'D%') and MONTHS_BETWEEN (SYSDATE, hire_date) > 12


/*2.       Escriba una consulta donde seleccione el c�digo del empleado cuyo alias ser� C�digo, el apellido concatenado con el nombre de empleado pero separados por coma(,)
cuyo alias ser� Nombre, el email donde su inicial este en may�scula y todos posean el dominio de @itla.edu.do, es decir debe ir concatenado con ese dominio cuyo alias es
Correo, el tel�fono  que deber� aparecer, si el n�mero telef�nico est� almacenado  en este formato 515.123.4567 convertirlo al formato siguiente (515)-123-4567 y llamar esta
columna Tel�fono, al final solo deber�  mostrar los empleados cuyo n�mero telef�nico  tenga una longitud de 12 y que comenzaron a trabajar en la empresa en el a�o 2003.
Est� consulta deber� estar ordenada por el C�digo. Funciones que puede hacer uso para este ejercicio LENGTH, SUBSTR, TO_CHAR, INITCAP.*/

select employee_id as "C�digo", first_name || ', ' || last_name as "Nombre", 
concat(initcap(email), '@itla.edu.do') as "Correo", 
 replace( '(' || substr(phone_number, 1, 3) || ')' || substr (phone_number, 4), '.', '-') as "Tel�fono", hire_date "Fecha"
from hr.employees 
where LENGTH(phone_number) = 12 and TO_CHAR(hire_date, 'yyyy') = 2003
order by employee_id

/*3. Desarrolle una consulta que permita mostrar en may�scula todas las ciudades, su c�digo de pa�s teniendo en cuenta que si es de United States of America (US) 
lo debes cambia por (EE. UU.), no deber� aparecer ninguna ciudad que contenga la letra 'o' en su nombre o aquellas ciudades que no tengan estado(provincia).*/

select  UPPER(city) "Ciudadd", replace (country_id, 'US', 'EE. UU.') "Estado/provincia"
from hr.locations
where state_province is not null and city not like '%o%'


/*4.       Escriba una consulta que muestre el nombre, apellido, y el mes completo de entrada de los empleados que ganan menos de 2500 d�lares 
y que entraron a trabajar durante el a�o 2007, el resultado deber� ordenarse por el mes de entrada iniciando por enero.*/

select * from hr.employees

select first_name "Nombre", last_name "Apellido", hire_date "Fecha", salary "Salario" 
from hr.employees
where salary < 2500 and TO_CHAR(hire_date, 'yyyy') = 2007
order by hire_date


/*5.       Escriba una consulta que muestre la cantidad de a�os que duraron trabajando en la empresa aquellos empleados que no laboran en la empresa, 
o que cambiaron de puesto de trabajo. La cantidad de a�o deber�a ser truncada a una sola posici�n decimal.*/

select trunc (months_between (end_date, start_date)/12,1) as "Cantidad de a�os"
from hr.job_history


/*6.       Desarrolle una consulta que liste el nombre del empleado, el c�digo del departamento y la fecha de inicio que empez� a trabajar, ordenando el resultado por
departamento y por fecha de inicio, el ultimo que entro a trabajar va de primero.*/

select first_name, department_id, hire_date 
from hr.employees
order by hire_date desc, department_id asc

/*7.       Escriba una consulta que divida cada salario de empleado por 3. Muestre solo los apellidos y salarios de los empleados que ganan un salario que es un m�ltiplo de 3.*/

select last_name, salary/3
from hr.employees
where mod (salary, 3) = 0


/*8.       Escriba una consulta que muestra �Cu�l es la posici�n de la �I� en �Oracle Internet Academy�*/

select instr ('Oracle Internet Academy', 'I') as "posici�n" from DUAL

/*9.       Utilice la tabla DUAL para procesar los n�meros siguientes:
845.553: redondear a un decimal
30695.348: redondear a dos decimales
30695.348: redondear a -2 decimales
2.3454: truncar 454 desde el decimal*/

select round (845.553, 1)  from DUAL
select round (30695.348, 2)  from DUAL
select round (30695.348, -2)  from DUAL
select round (2.3454, 4)  from DUAL

/*10.   A partir de la cadena �Oracle Internet Academy�, rellene la cadena para crear ****Oracle****Internet****Academy*****/

select rpad(lpad(replace ('Oracle Internet Academy', ' ', '****'), 33, '****' ),37, '****'  ) "Nombre"from dual

/*11.   Utilice la tabla employees de la base de datos Oracle y la expresi�n CASE para descodificar el ID de departamento. Muestre el ID de departamento, el apellido, el salario y
una columna denominada �Salario Nuevo� cuyo valor se basa en las siguientes condiciones:
�         Si el ID de departamento es 10, se multiplica el salario por 1.5
�          Si el ID de departamento es 90, se multiplica el salario por 2.5
�          Si el ID de departamento es 110, se multiplica el salario por 2.75
�          De lo contrario, se muestra el antiguo salario*/

select last_name, department_id, salary,
case
when department_id= 10 then salary* 1.5
when department_id= 90 then salary* 2.5
when department_id= 110 then salary* 2.75
else salary end as "Salario nuevo"
from hr.employees


/*12.   Muestre el nombre, el apellido, el ID de jefe y el porcentaje de comisi�n de todos los empleados de los departamentos 80 y 90. En la quinta columna denominada
�Review�, vuelva a mostrar el ID de jefe. Si no tienen un jefe, muestre el porcentaje de comisi�n.  Si no tienen una comisi�n, muestre 99999.*/

select FIRST_NAME, last_name, manager_id, COMMISSION_PCT, coalesce(manager_id, COMMISSION_PCT, 99999) as "REVIEW"
from hr.employees
where department_id = 80 or department_id = 90


/*13.   Valli Pataballa es una empleada que ha recibido un aumento de 3,000 $. Muestre su nombre y apellido, su sueldo actual y su nuevo salario. Muestre ambos salarios con
un signo $ y dos decimales. Etiquete su nueva columna de salario como AS Salario Nuevo*/

select first_name, last_name, to_char(salary, '$9999.99')as "salario actual", to_char(salary + 3000, '$9999.99') as "Salario Nuevo" 
from hr.employees
where first_name = 'Valli' or last_name = 'Pataballa'

/*14.   Cree un informe que muestre el nombre y apellido y el mes de contrataci�n de todos los empleados de la tabla EMPLOYEES*/

select first_name, last_name, to_char (hire_date, 'Month') as "Meses"
from hr.employees


/*15.    Modifique el informe anterior para mostrar un valor nulo si el mes de contrataci�n es enero.*/

select first_name, last_name, nullif(to_char(hire_date, 'Month'), to_char(hire_date, 'Month')) "Fecha"
from hr.employees


/*16.   Crea un informe utilizando DECODE que muestre el grado de todos los empleados bas�ndote en el puesto de trabajo, usa la siguiente informaci�n:*/

select first_name, 
decode (job_id,
    'AD_PRES', 'A',
    'ST_MAN', 'B',
    'SAP_REP', 'C',
    'ST_CLERK', 'D',
    'IT_PROG', 'E',
    '0') AS "PUESTO DE TRABAJO"
    FROM HR.EMPLOYEES
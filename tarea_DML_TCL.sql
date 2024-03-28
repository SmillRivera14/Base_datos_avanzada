/*1.       Crear una tabla de respaldo de la tabla de employees y póngale de nombre copia_employees
*/

create table copia_employees as (select * from employees)

select * from employees


/*2.       Inserte en la tabla de employees lo siguiente:

a.       Ana Perez, ingreso a trabajar el 01-feb-2021, con el puesto de Programador, 

y su jefe será el encargado del departamento de tecnología, por lo tanto, Ana también estará en ese departamento. 

Ana devengará inicialmente un salario de 10,000 y tendrá comisión de un 0.20%*/

insert into employees values ('207', 'Ana', 'Perez', 'Ana.Perez@gamil.com', '665.548.554', '01-02-2001', 'IT_PROG', '10000', '0.2', '103', '60')

select * from employees

/*3.       Actualice el nombre del empleado 109 y póngale sus datos (El dato suyo como estudiante)*/
update hr.employees set 
first_name = 'Smill Emmanuel',
last_name = 'Rivera Diaz',
Email = 'Smill.Rivera@gamil.com',
phone_number = '444.550.888',
hire_date = '25/2/2025',
job_id = 'IT_PROG',
salary = '30000',
Commission_PCT = 0.5,
manager_id = 103,
department_id = 60
where employee_id = 109

select * from hr.employees
where  employee_id = 109

/*4.       Use merge para actualizar la tabla backup creada con las modificaciones realizadas en el punto 2 y 3
*/

merge into copia_employees c
using employees e
    on (c.employee_id = e.employee_id)
    WHEN MATCHED THEN UPDATE SET
        c.first_name = e.first_name, c.last_name = e.last_name, c.Email = e.Email, c.phone_number = e.phone_number, c.hire_date = e.hire_date, c.job_id = e.job_id,
        c.salary = e.salary, c.Commission_PCT = e.Commission_PCT, c.manager_id = e.manager_id, c.department_id = e.department_id

    WHEN NOT MATCHED THEN
        insert (c.employee_id, c.last_name, c.Email, c.phone_number, c.hire_date, c.job_id,  c.salary, c.Commission_PCT, c.manager_id, c.department_id)
        values (e.employee_id, e.last_name, e.Email, e.phone_number, e.hire_date, e.job_id,  e.salary, e.Commission_PCT, e.manager_id, e.department_id)

select * from copia_employees
where employee_id in (109, 207)
/*5.	Realice rollback a todas las transacciones realizadas.*/

rollback

select * from copia_employees
where employee_id in (109,207)

select * from copia_employees
where employee_id = 109

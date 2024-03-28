select * from hr.employees
select * from hr.departments


/* Genere un informe que devuelva el apellido, el salario, el 
número de departamento y el salario medio de todos los 
departamentos en los que el salario es mayor que el salario 
medio.

 Employees, Departments*/

select round( avg (salary), 2) from employees where department_id = 50


 select last_name, salary, department_id, avg(salary) as "salario promedio"
 from hr.employees
 where salary > (
                    select avg (salary) from hr.employees)
group by department_id, last_name, salary
 
 /*– Cree una vista denominada V2 que devuelve el salario más 
alto, el salario más bajo, el salario medio y el nombre del 
departamento.  EJERCICIO 12*/
 
 create view V2
 AS select department_name as "Nombre del departamento",  round( min (salary)) as "Salario mínimo",
    round(avg(salary)) as "salario promedio",  round(max(salary)) as "Salario mayor"
        from employees e join departments d on e.department_id = d.department_id
            group by department_name
 
 select * from V2
 
 /*Problem:
– Cree una vista denominada Dept_Managers_view que 
devuelva una lista de nombres de departamento junto con las 
iniciales y el apellido del jefe para dicho departamento. 
– Pruebe la vista devolviendo todas sus filas. 
– Asegúrese de que no se pueda actualizar ninguna fila a través 
de la vista.
– Vuelva a ejecutar una sentencia 
UPDATE en la vista.*/

create view Dept_Managers_view
AS select  department_name as "Nombre del departamento", substr (first_name, 1, 1) || '.' || last_name "Jefe"
        from employees e join departments d on e.department_id = d.department_id
            where e.employee_id = d.manager_id

select * from Dept_Managers_view




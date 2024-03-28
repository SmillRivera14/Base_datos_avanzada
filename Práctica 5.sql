use Ciudadania;

--CREACIÓN DE TABLAS.

create table Ciudadanos3(
    ID int PRIMARY KEY,
    personas varchar (150),
    IDsexo int,
    IDedad VARCHAR (177),
    IDprovincias int,
    IDmunicipios int,
    IDsectores int
);

CREATE TABLE Provincias(
    id int PRIMARY KEY,
    provincias varchar (175)
);

CREATE TABLE Sexo(
    id int PRIMARY KEY,
    sexo VARCHAR (10)
);

CREATE TABLE Edad(
    id  int PRIMARY KEY,
    Edad int
);

CREATE TABLE Municipios(
    id int PRIMARY KEY,
    municipios VARCHAR (175)
);

CREATE TABLE Sectores (
    id int PRIMARY KEY,
    sectores varchar (177)
);

--CREACIÓN DE TABLAS.

--Unión de tablas.

select p.provincias, COUNT (c.IDprovincias) as Cantidad
from Ciudadanos3 c 
join Provincias p on c.IDprovincias = p.id
GROUP BY p.provincias

select m.municipios, COUNT (c.IDsectores) as 'Cantidad de sectores'
from Ciudadanos3 c 
join Municipios m on c.IDmunicipios = m.id
GROUP BY m.municipios

select s.sectores, COUNT (c.IDsectores) as Cantidad
from Ciudadanos3 c 
join Sectores s on c.IDsectores = s.id
GROUP BY s.sectores

--Unión de tablas.

--Número de personas entre 18 y 25 años dentro de los municipios x, en los sectores x y su cantidad.

SELECT m.municipios, s.sectores, e.Edad, count( e.id) as 'Cantidad de personas'
from Ciudadanos3 c join Edad e on c.IDedad = e.id 
join Municipios m on c.IDmunicipios = m.id
join Sectores s on c.IDsectores= s.id
GROUP by m.municipios, s.sectores, c.IDedad, e.Edad 
HAVING edad <=25 and edad >= 18

--Número de personas entre 18 y 25 años dentro de los municipios x, en los sectores x y su cantidad.

SELECT m.municipios, s.sectores, e.Edad, count( e.id) as 'Cantidad de personas'
from Ciudadanos3 c join Edad e on c.IDedad = e.id 
join Municipios m on c.IDmunicipios = m.id
join Sectores s on c.IDsectores= s.id
GROUP by m.municipios, s.sectores, c.IDedad, e.Edad 
HAVING edad <=25 and edad >= 18








--Unión de tablas.

--RECUERDO.

/* Select {columna} from {tabla}{t1} inner join {tabla}{t2} on t1.id=t2.id*/

--RECUERDO.

select personas, s.sexo
from Ciudadanos3 c join Sexo s on c.IDsexo= s.id
select personas, e.Edad, m.municipios
from Ciudadanos3 c join Edad e on c.IDedad = e.id join Municipios m on c.IDmunicipios= m.id
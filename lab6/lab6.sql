--task1
create database lab6;

--task2
create table locations(
    location_id serial primary key,
    street_address varchar(25),
    postal_code varchar(12),
    city varchar(30),
    state_province varchar(12)
);
create table departments(
    department_id serial primary key,
    department_name varchar(50) unique,
    budget integer,
    location_id integer references locations
);
create table employees(
    employee_id serial primary key,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(50),
    phone_number varchar(20),
    salary integer,
    department_id integer references departments
);

insert into locations(street_address, postal_code, city, state_province)
values( '123 Main Street','12345','New York','NY'),
      ('456 Oak Avenue','67890','Los Angeles','CA'),
      ('789 Elm Street','56789','Chicago','IL'),
      ('1234 Second Street','54321','Houston','TX'),
      ('654 Third Street','09876','Olympia','WA');

insert into departments(department_id,department_name, budget, location_id)
values (40,'Sales',10000,1),
       (41,'Marketing',75000,2),
       (42,'Engineering',125000,3),
       (60,'IT',125000,4),
       (80,'Factory',9000000,5);

insert into employees(first_name, last_name, email, phone_number, salary, department_id)
values ('John','Doe','john.doe@gmail.com','555-123-4567',50000,40),
       ('Jane','Smith','jane.smith@gmail.com','555-234-5678',60000,41),
       ('Alice','Johnson','alice.johnson@gmail.com','555-345-6789',70000,42),
       ('Hannah','Mckay','hannah.mckay@gmail.com','555-987-9876',40000,60),
       ('Jessie','Pinkman','jessie@email.com','555-876-1234',200000,80);

--task3
select
    e.first_name,
    e.last_name,
    e.department_id,
    d.department_name
from
    employees e
inner join departments d on d.department_id = e.department_id;

--task4
SELECT
    e.first_name,
    e.last_name,
    e.department_id,
    d.department_name
FROM
    employees e
INNER JOIN
    departments d ON e.department_id = d.department_id
WHERE
    d.department_id IN (80, 40);

--task5
select
    e.first_name,
    e.last_name,
    d.department_name,
    l.city,
    l.state_province
from
    employees e
inner join
    departments d on e.department_id = d.department_id
inner join
    locations l on d.location_id = l.location_id;

--task6
select d.department_name,
       count(e.employee_id) as employee_count
from
    departments d
left join employees e on d.department_id = e.department_id
group by d.department_name;

--task7
select
    e.first_name,
    e.last_name,
    e.department_id,
    d.department_name
from
    employees e
left join departments d on d.department_id = e.department_id;
create database lab7;
--creating tables
create table countries(
    id serial primary key,
    name varchar(100)
);
create table department(
    department_id serial primary key,
    budget int
);
create table employees(
    name varchar(100),
    surname varchar(100),
    salary int,
    value1 int,
    value2 int,
    department_id int references department
);

insert into countries(id,name) values(1,'USA'),
                                     (2,'Russia'),
                                     (3,'Kazakhstan'),
                                     (4,'Japan');


insert into department(department_id,budget)
values(1,100000),
      (2,250000),
      (3,300000),
      (4,400000);

insert into employees(name,surname,salary,value1,value2,department_id)
values('John','Johnson',50000,52000,53000,1),
     ('Alex','Rubkin',70000,72000,71000,2),
     ('Tolen','Tolenov',38000,32000,33000,3),
     ('Kitoyama','Uchiha',78000,80000,81000,4);

--task1
create index countries_name_index on countries(name);

--task2
create index idx_employees_name_surname on employees(name,surname);

--task3
create index idx_employees_salary on employees((salary<value1),(salary>value2));

--task4
CREATE INDEX idx_employees_name_substring ON employees (substring(name FROM 1 FOR 4));

--task5
create index idx_department_department_salary
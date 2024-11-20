--task1
create database lab8;

--task2
create table salesman(
    salesman_id serial primary key,
    name varchar(50),
    city char(50),
    commision double precision
);

create table customers(
    customer_id serial primary key,
    cust_name varchar(50),
    city char(50),
    grade int,
    salesman_id serial references salesman
);

create table orders(
    ord_no serial primary key,
    purch_amt double precision,
    ord_date date,
    customer_id serial references customers,
    salesman_id serial references salesman
);

insert into salesman(salesman_id,name,city,commision)
values (5001,'James Hoog', 'New York',0.15),
       (5002,'Nail Knite', 'Paris', 0.13),
       (5005,'Pit Alex', 'London', 0.11),
       (5006,'MC Lyon', 'Paris', 0.14),
       (5003,'Lauson Hen','', 0.12),
       (5007,'Paul Adam', 'Rome', 0.13);

insert into customers(customer_id,cust_name, city, grade,salesman_id)
values (3002,'Nick Rimando','New York',100,5001),
       (3005,'Graham Zusi', 'California', 200,5002),
       (3001,'Brad Guzan','London',null,5005),
       (3004,'Fabian Johns','Paris',300,5006),
       (3007,'Brad Davis','New York',200,5001),
       (3009,'Geoff Camero','Berlin',100,5003),
       (3008,'Julian Green', 'London',300,5002);

insert into orders(ord_no,purch_amt, ord_date,customer_id,salesman_id)
values (700001,150.5,'2012-10-05',3005,5002),
       (70009,270.65,'2012-09-10',3001,5005),
       (70002,65.26,'2012-10-05',3002,5001),
       (70004,110.5,'2012-08-17',3009,5003),
       (70007,948.5,'2012-09-10',3005,5002),
       (70005,2400.6,'2012-07-27',3007,5001),
       (70008,5760,'2012-09-10',3002,5001);

--task3
create role junior_dev with login;

--task4
create view new_york_salesman as
    select * from salesman where city = 'New York';

--task5
create view order_details as
select
    o.ord_no,
    s.name as salesman_name,
    c.cust_name as customer_name
from orders o
join salesman s on o.salesman_id = s.salesman_id
join customers c on c.customer_id = o.customer_id;

--GRANT ALL PRIVILEGES ON VIEW order_details TO junior_dev;

--task6
create view top_customers as
select * from customers
where grade = (select max(grade) from customers);

--grant select on view top_customers to junior_dev;

--task7
create view salesmen_count_by_city as
select city,count(salesman_id) as number_of_salesmen
from salesman
group by city;

--task8
create view salesmen_with_multiple_customers as
select s.salesman_id, s.name, count(c.customer_id) as customer_count
from salesman s
join customers c on s.salesman_id = c.salesman_id
group by s.salesman_id, s.name
having count(customer_id) > 1;

--task9
create role intern with login;

grant junior_dev to intern;
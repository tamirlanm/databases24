--1
create database lab5;
--2
create table salesman(
    salesman_id int primary key,
    name varchar(250),
    city varchar(250),
    commission double precision
);
create table customers(
    costumer_id int primary key ,
    cust_name varchar(250),
    city text,
    grade int ,
    salesman_id int
);
create table orders(
    ord_no int ,
    purch_amt double precision,
    ord_date date,
    costumer_id int,
    salesman_id int
);
insert into salesman(salesman_id, name, city, commission) values(5001,'James Hoog', 'New York',0.15),
                                                                (5002,'Nail Knite', 'Paris', 0.13),
                                                                (5005,'Pit Alex', 'London', 0.11),
                                                                (5006,'Mc Lyon', null,0.12),
                                                                (5007,'Paul Adam', 'Rome', 0.13);
insert into customers(costumer_id, cust_name, city, grade, salesman_id) values(3002,'Nick Rimando', 'New York', 100, 5001),
                                                                              (3005,'Graham Zusi','California',200,5002),
                                                                              (3001,'Brad Guzan','London',null,5005),
                                                                              (3004,'Fabian Johns','Paris',300,5006),
                                                                              (3007,'Brad Davis', 'New York', 200,5001),
                                                                              (3009,'Geoff Camero','Berlin',100,5003),
                                                                              (3008,'Julian Green','London',300,5002);
insert into orders(ord_no, purch_amt, ord_date, costumer_id, salesman_id) values(70001,150.5, '2012-10-05',3005,5002),
                                                                                (70009,270.65,'2012-09-10',3001,5005),
                                                                                (70002,65.26,'2012-10-05',3002,5001),
                                                                                (70004,110.5,'2012-08-17',3009,5003),
                                                                                (70007,948.5,'2012-09-10',3005,5002),
                                                                                (70005,2400.6,'2012-07-27',3007,5001),
                                                                                (70008,5760,'2012-09-10',3002,5001);

--3
select sum(purch_amt) from orders;

--4
select avg(orders.purch_amt) from orders;

--5
select count(customers.cust_name) as total_costumers from customers;

--6
select min(orders.purch_amt) from orders;

--7
select cust_name from customers where cust_name like 'k%';

--8
select o.* from orders o join customers c on o.costumer_id = c.costumer_id
where c.city <> 'New York';

--9
select c.* from customers c join orders o on c.costumer_id = o.costumer_id
where o.purch_amt > 100;

--10
select sum(customers.grade) from customers;

--11
select cust_name from customers where cust_name is not null;

--12
select max(customers.grade) from customers;
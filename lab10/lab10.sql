--task0
--create database lab10;

--tables
create table books(
    book_id integer primary key,
    title varchar,
    author varchar,
    price decimal,
    quantity integer
);
create table orders(
    order_id integer primary key,
    book_id integer,
    customer_id integer,
    order_date date,
    quantity integer,
    foreign key (book_id) references books(book_id),
    foreign key (customer_id) references customers(customer_id)
);
create table customers(
    customer_id integer primary key,
    name varchar,
    email varchar
);

insert into books(book_id, title, author, price, quantity)
values (1,'Database 101', 'A.Smith',40.00,10),
       (2,'Learn SQL','B.Johnson',35.00,15),
       (3,'Advanced DB','C.Lee',50.00,5);

--insert into orders(order_id, book_id, customer_id, order_date, quantity)
--values (1,2,102,'2024-09-19',3),
--       (2,3,103,'2024-12-02',2),
--       (3,1,101,'2024-11-24',4);

insert into customers(customer_id, name, email)
values (101,  'John Doe','johndoe@example.com'),
       (102,  'Jane Doe','janedoe@example.com'),
       (103,  'Josh Doe','joshdoe@example.com');

--task1

begin;
insert into orders(order_id,customer_id, book_id,quantity, order_date)
values (1,101,1,2,current_date);
update books
set quantity = quantity - 2
where book_id = 1;

commit;

--task2
begin;
do $$
declare
    available_quantity int;
begin
    select books.quantity into available_quantity
    from books
    where book_id = 3;
    if available_quantity < 10 then
        raise exception 'Not enough stock available for book_id 3. Transaction will be rolled back';
    end if;
end $$;
insert into orders (order_id, book_id, customer_id, order_date, quantity)
values (2,3,102,10,current_date);
update books
set quantity = quantity - 10
where book_id = 3;
commit;

--task3
--1
set transaction isolation level read committed;
begin;
update books
set price = 45.00
where book_id = 1;

--2
set transaction isolation level read committed;
begin;
select books.price
from books where book_id = 1;

--1
commit;

--2
select price
from books where book_id = 1;

commit;

--task4
begin;
update customers
set email = 'newwwemail@example.com'
where customer_id = 101;
commit;


select customers.customer_id,customers.name,customers.email
from customers where customer_id = 101;

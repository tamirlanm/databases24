/*Laboratory work #2*/
/*task1*/
create database lab2;

/*task2*/
create table countries(
    country_id   serial primary key,
    country_name text,
    region_id    int,
    population   int
);

/*task3*/
insert into countries(country_name, region_id, population) values('Switzerland',2, 8962300);

/*task4*/
insert into countries(country_id,country_name) values(3,'Mexico');

/*task5*/
insert into countries(country_name,region_id,population) values('vatican',NULL,764);

/*task6*/
insert into countries(country_name, population) values('Brazil',212187734),
                                                                 ('Japan',125100000),
                                                                 ('Spain',49910526);
/*task7*/
alter table countries alter column country_name set default 'Kazakhstan';

/*task8*/
insert into countries(country_name) values(default);

/*task9*/
insert into countries default values;

/*task10*/
create table countries_new (like countries);

/*task11*/
insert into countries_new (country_id,country_name, region_id, population)
select countries.country_id,countries.country_name,countries.region_id,countries.population
from countries;

/*task12*/
update countries set region_id = 1 where region_id IS NULL;

/*task13*/
select countries.country_name, countries.population *1.1 as "new_population" from countries;

/*task14*/
delete from countries where population<100000;

/*task15*/
delete from countries_new where exists(select country_id from countries) returning*;

/*task16*/
delete from countries returning *;

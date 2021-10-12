--DML commands deal with Data
--INSERT insert data into a table
--UPDATE updates an existing table
--update tablename set columnname='' where id='';
--DELETE delete a row of a table
--TRUNCATE completely removes the data from a table. It does not accept the where clause
-- truncate table tablename
-- bigserial increments by itself
--\l -- list database 
--\c -- switch databases
--\dt --  listing tables
--\d tablename --  details of a table
--\di -- list of all indexes defined in your database

select * from information_schema.tables where table_schema = 'stackoverflow';
SELECT table_schema, table_name, table_type FROM information_schema.tables;
----------------Describe table-----------------------
SELECT 
   table_name, 
   column_name, 
   data_type 
FROM 
   information_schema.columns

WHERE 
   table_name = 'person';




create schema persondata;

create table person(
id bigserial not null primary key,
first_name varchar(50) not null,




last_name varchar(50) not null,
gender varchar(7) not null,
date_of_birth date not null, --yyyy-mm-dd
email varchar(150),
country_of_birth varchar(50)
);
--https://www.postgresql.org/docs/13/datatype.html

--Mockaroo-- data generator (https://mockaroo.com)

ASC--1 2 3 4 5
DESC--5 4 3 2 1

----------------------Groupby------------------
--Group by Column
--how many we have for each of this countries by sorting the country of  birth?
select country_of_birth, count(*) from person group by country_of_birth order by country_of_birth;

------------import car table--------------------
select make, model, MAX(price) from car group by make, model;
select make, model, MIN(price) from car group by make, model;

--Age function(starting date, actual date)
select first_name, last_name, gender, country_of_birth, date_of_birth, age(now(), date_of_birth) as age from person;

--------------inserting into the table-----------
---primary Key
insert into person (id,first_name, last_name, email, gender, date_of_birth, country_of_birth) values (1,'Cherilynn', 'Dri', 'cdri0@meetup.com', 'Male', '2021-02-28', 'Ukraine');

--Error: Duplicate Key Value violates unique constraint
--Correct it by:
alter table person drop constraint person_pkey;
--Now there is no primary key

insert into person (id,first_name, last_name, email, gender, date_of_birth, country_of_birth) values (1,'Cherilynn', 'Dri', 'cdri0@meetup.com', 'Male', '2021-02-28', 'Ukraine'); -- now works and we cannot identify these two people.


--------------------add a primary key--------------------------
alter table person add primary key (id)---------- Won't work because we cannot add a primary when the rows are unique in the table


----------------How to fix this is to delete------------------
delete from person where id = 1;

select * from person where id=1; -- Zero rows

-- insert the data again
insert into person (id,first_name, last_name, email, gender, date_of_birth, country_of_birth) values (1,'Cherilynn', 'Dri', 'cdri0@meetup.com', 'Male', '2021-02-28', 'Ukraine');

-- add the primary key again and it worked
alter table person add primary key (id);

-----------------------------------Unique Constraints-----------------------------------
-- Primary keys are used to identify a unique row in a table
--Unique Constraint allows you to have a unique value per column
insert into person (id,first_name, last_name, email, gender, date_of_birth, country_of_birth) values (1004,'Cherilynn', 'Dri', 'cdri0@meetup.com', 'Male', '2021-02-28', 'Ukraine');

--Add Unique constraint
alter table person add constraint unique unique_email_address unique(email); -- this won't work

-- How to resolve it
delete from person where id=1004;

select * from person where email='cdri0@meetup.com'; -- confirm

--Add Unique constraint again
alter table person add constraint unique unique_email_address unique(email);

insert into person (first_name, last_name, email, gender, date_of_birth, country_of_birth) values ('Cherilynn', 'Dri', 'cdri0@meetup.com', 'None', '2021-02-28', 'Ukraine');

select distinct gender from person;

--Add Unique constraint
alter table person add constraint gender_constraint check 
(gender = 'Female' or gender='Male' or gender='Agender',
or gender='Genderqueer' or gender='Bigender'or gender='Genderfluid'
or gender='Non-binary' or gender='Polygender'); -- this won't work because gender_constraint is violating the row


delete from person where gender='None';

--Add constraint again
alter table person add constraint gender_constraint check 
(gender = 'Female' or gender='Male' or gender='Agender',
or gender='Genderqueer' or gender='Bigender'or gender='Genderfluid'
or gender='Non-binary' or gender='Polygender'); -- this will work 

alter table person add constraint gender_constraint check (gender = 'Female' or gender='Male'); -- this won't work because gender_constraint is being violated

----------------Delete---------------------
delete from person where gender='male' and country_of_birth='england';
delete from person; ----- delete all the rows 


------------------Insert-------------------
insert into person (id, first_name, last_name, email, gender, date_of_birth, country_of_birth) values (2017,'Leland', 'Eakley', 'lelande@meetup.gov', 'Male', '2021-05-09', 'Philippines') on conflict(id) do nothing;

----Update------On Conflict do Update---( helps you to perform an update or insert UpSet and help you to overwrite existing data present otherwise insert a new row )

Update person set email='elande@meetup.gov.gh' where id='2017';

insert into person (id, first_name, last_name, email, gender, date_of_birth, country_of_birth) values (2017,'Leland', 'Eakley', 'lelande@meetup.gov', 'Male', '2021-05-09', 'Philippines') on conflict (id) do update set email= excluded.email; --- no update was done because the email was excluded.

insert into person (id, first_name, last_name, email, gender, date_of_birth, country_of_birth) values (2017,'Leland', 'Eakley', 'lelande@meetup.gov.gh', 'Male', '2021-05-09', 'Philippines') on conflict (id) do update set email= excluded.email, last_name=excluded.last_name, first_name=excluded.first_name; --- update will done because the email was excluded but there has been a change.

--------------Foreign Keys and Joins------------------
--A Person has a car
--A person can only have one car
--A Car can belong to one person only
--To achieve that we need to have a realtionship
Person Table -> Car_id bigint references car(id) unique (car_id)-->FK
--A foreign Key column that references a primary key in another table and the datatypes need to be the same.

---Adding the relationships between the tables----
drop table person;
drop table car;
--A person can only have one car
--A Car can belong to one person only

----Assign a car to someone-----
update person set car_id=2 where id = 1;
    -- car_id == car and id == person id

update person set car_id=2 where id = 2; -- car is already taken meaning the constraint is working

----Inner Join------ gives out those who have foreign key constraint
--combining both tables and taking what is common in both tables base on the foreign keys from both tables, then a new record will be called C.
select * from person;
select * from car;
select * from person join car on person.car_id = car.id;
select person.first_name, car.make, car.model, car.price from person join car on person.car_id = car.id;

------Left Join------- gives out those who have foreign key constraint and those who don't
--selecting someone that does not have a car
select * from person left join car on car.id = person.car_id;
select * from person left join car on car.id = person.car_id where car.* is null;

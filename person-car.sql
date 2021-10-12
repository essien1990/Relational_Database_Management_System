--A person can only have one car
--A Car can belong to one person only
---------------------------------------------------------------------------
create table car (
    id bigserial not null primary key,
    make VARCHAR(50) not null,
    model VARCHAR(50) not null,
    price numeric(19, 2) not null
);

insert into car (make, model, price) values ('Chevrolet', 'Tahoe', '$0.77');
insert into car (make, model, price) values ('BMW', 'M5', '$3.45');
insert into car (make, model, price) values ('Bentley', 'Azure', '$6.85');

----------------------------------------------------------------------------
create table person (
    id bigserial not null primary key,
    first_name VARCHAR(50) not null,
    last_name VARCHAR(50) not null,
    email VARCHAR(50),
    gender VARCHAR(50) not null,
    date_of_birth DATE not null,
    country_of_birth VARCHAR(50) not null,
    car_id bigint references car(id),
    --A car can only be owned by one person
    UNIQUE(car_id)
);
insert into person (first_name, last_name, email, gender, date_of_birth, country_of_birth) values ('Cherilynn', 'Dri', 'cdri0@meetup.com', 'Male', '2021-02-28', 'Ukraine');
insert into person (first_name, last_name, email, gender, date_of_birth, country_of_birth) values ('Leland', 'Eakley', 'LelandEakley@ucoz.com', 'Male', '2021-05-09', 'Philippines');
insert into person (first_name, last_name, email, gender, date_of_birth, country_of_birth) values ('Urban', 'Pechacek', 'upechacek2@nytimes.com', 'Bigender', '2021-08-02', 'China');
insert into person (first_name, last_name, email, gender, date_of_birth, country_of_birth) values ('Sylvia', 'Tremmil', null, 'Bigender', '2021-08-02', 'Croatia');
insert into person (first_name, last_name, email, gender, date_of_birth, country_of_birth) values ('Florri', 'Wasbey', null, 'Polygender', '2021-04-07', 'Portugal');
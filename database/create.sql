
drop view if exists v_room_occupancy;

drop table if exists roomoccupant;
drop table if exists roomassignment;
drop table if exists reservationoccupant;
drop table if exists occupant;
drop table if exists reservationroomtype;
drop table if exists reservation;
drop table if exists guest;
drop table if exists guestcategory;
drop table if exists servicecharge;
drop table if exists bill;
drop table if exists price;
drop table if exists room;
drop table if exists roomtypefeature;
drop table if exists roomtype;
drop table if exists hotelseason;
drop table if exists season;
drop table if exists hotelfeature;
drop table if exists hotelphone;
drop table if exists hotel;

create table hotel (
    hotel_id int primary key,
    name varchar(255),
    address varchar(255)
);

create table hotelphone (
    hotel_id int,
    phone_num varchar(32),
    primary key (hotel_id, phone_num)
);

create table hotelfeature (
    hotel_id int,
    feature varchar(64),
    primary key (hotel_id, feature)
);

create table season (
    season_id int primary key,
    name varchar(64),
    start_date date,
    end_date date
);

create table hotelseason (
    hotel_id int,
    season_id int,
    primary key (hotel_id, season_id)
);

create table roomtype (
    type_id int primary key,
    room_name varchar(64),
    size int,
    capacity int,
    hotel_id int
);

create table roomtypefeature (
    type_id int,
    feature varchar(64),
    primary key (type_id, feature)
);

create table room (
    room_num int primary key,
    floor int,
    type_id int
);

create table price (
    price_id int primary key,
    day_of_week varchar(16),
    amount decimal(10,2),
    type_id int,
    season_id int
);

create table guestcategory (
    category_id int primary key,
    name varchar(64),
    discount decimal(5,2)
);

create table guest (
    guest_id int primary key,
    id_type varchar(32),
    id_num varchar(64),
    address varchar(255),
    home_phone varchar(32),
    mobile_phone varchar(32),
    category_id int
);

create table reservation (
    res_id int primary key,
    check_in_date date,
    check_out_date date,
    guest_id int,
    hotel_id int
);

create table reservationroomtype (
    res_id int,
    type_id int,
    quantity int,
    primary key (res_id, type_id)
);

create table occupant (
    occupant_id int primary key,
    first_name varchar(64),
    last_name varchar(64)
);

create table reservationoccupant (
    res_id int,
    occupant_id int,
    primary key (res_id, occupant_id)
);

create table roomassignment (
    assignment_id int primary key,
    res_id int,
    room_num int,
    check_in date,
    check_out date
);

create table roomoccupant (
    assignment_id int,
    occupant_id int,
    primary key (assignment_id, occupant_id)
);

create table bill (
    bill_id int primary key,
    issue_date date,
    total_amount decimal(10,2),
    is_paid boolean,
    res_id int
);

create table servicecharge (
    service_id int primary key,
    res_id int,
    service_type varchar(64),
    amount decimal(10,2),
    charge_date date
);

create index idx_room_type_id
on room (type_id);

create index idx_price_type_season_day
on price (type_id, season_id, day_of_week);

create index idx_reservation_hotel_dates
on reservation (hotel_id, check_in_date, check_out_date);

create index idx_reservationroomtype_type_res
on reservationroomtype (type_id, res_id);

create index idx_roomassignment_room_dates
on roomassignment (room_num, check_in, check_out);

create index idx_roomassignment_res
on roomassignment (res_id);

create index idx_servicecharge_res
on servicecharge (res_id);

create view v_room_occupancy as
select
    room_num,
    check_in,
    coalesce(check_out, 'infinity'::date) as check_out
from roomassignment;

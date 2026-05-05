begin;

insert into guestcategory (category_id, name, discount)
select 2, 'Gold', 10.00
where not exists (select 1 from guestcategory where category_id = 2);

insert into guest (guest_id, id_type, id_num, address, home_phone, mobile_phone, category_id)
select 1, 'passport', 'P1001', '10 Main St, Miami, FL', '305-111-0001', '305-222-0001', 2
where not exists (select 1 from guest where guest_id = 1);

commit;

select roomtype.type_id, roomtype.room_name, season.name as season_name,
    avg(price.amount * (1 - guestcategory.discount / 100.0)) as avg_cost_per_night
from roomtype
join price on price.type_id = roomtype.type_id
join season on season.season_id = price.season_id
join hotelseason on hotelseason.season_id = season.season_id and hotelseason.hotel_id = roomtype.hotel_id
join guestcategory on guestcategory.name = 'Gold'
where roomtype.hotel_id = 1
  and date '2025-07-15' >= season.start_date and date '2025-07-16' <= season.end_date
  and price.day_of_week in ('tuesday', 'wednesday')
  and (select count(*) from room where room.type_id = roomtype.type_id)
    > (select coalesce(sum(rrt.quantity), 0)
       from reservationroomtype rrt
       join reservation on reservation.res_id = rrt.res_id
       where rrt.type_id = roomtype.type_id
         and reservation.hotel_id = 1
         and reservation.check_in_date < '2025-07-17'
         and reservation.check_out_date > '2025-07-15')
group by roomtype.type_id, roomtype.room_name, season.name
order by avg_cost_per_night;


begin;

update price set amount = 50
where type_id = 1 and season_id = 1 and day_of_week = 'wednesday';

update price set amount = 100
where type_id = 2 and season_id = 1 and day_of_week = 'wednesday';

commit;

begin;

insert into reservation (res_id, check_in_date, check_out_date, guest_id, hotel_id)
values (13, '2025-07-15', '2025-07-17', 1, 1);

insert into reservationroomtype (res_id, type_id, quantity)
values (13, 2, 3);

commit;

begin;

insert into guest (guest_id, id_type, id_num, address, home_phone, mobile_phone, category_id)
values (11, 'passport', 'P111111', '1 Main St', '111-1111', '222-2222', 2);

insert into reservation (res_id, check_in_date, check_out_date, guest_id, hotel_id)
values (14, '2025-07-15', '2025-07-17', 11, 1);

insert into reservationroomtype (res_id, type_id, quantity)
values (14, 1, 1);

commit;

select reservation.check_in_date, reservation.check_out_date,
    roomtype.room_name,
    roomtypefeature.feature,
    sum(price.amount * (1 - guestcategory.discount / 100.0)) as room_total,
    (select sum(amount) from servicecharge where res_id = 15) as extras_total,
    sum(price.amount * (1 - guestcategory.discount / 100.0)) +
        (select sum(amount) from servicecharge where res_id = 15) as grand_total
from reservation
join guest on guest.guest_id = reservation.guest_id
join guestcategory on guestcategory.category_id = guest.category_id
join roomassignment on roomassignment.res_id = reservation.res_id
join room on room.room_num = roomassignment.room_num
join roomtype on roomtype.type_id = room.type_id
join roomtypefeature on roomtypefeature.type_id = roomtype.type_id
join price on price.type_id = roomtype.type_id
    and price.season_id = 3
    and price.day_of_week in ('thursday', 'friday')
where reservation.res_id = 15
group by reservation.check_in_date, reservation.check_out_date, roomtype.room_name, roomtypefeature.feature;


begin;

update guest set category_id = 2 where guest_id = 12;

update reservation set check_in_date = '2025-07-03', check_out_date = '2025-07-05' where res_id = 15;

update roomassignment set check_in = '2025-07-03', check_out = '2025-07-05' where assignment_id = 8;

commit;

begin;

insert into servicecharge (service_id, res_id, service_type, amount, charge_date)
values (7, 15, 'room service', 25.00, '2025-07-04');

commit;

begin;

update roomassignment set check_out = '2025-07-05' where assignment_id = 8;

insert into bill (bill_id, issue_date, total_amount, is_paid, res_id)
values (5, '2025-07-05', 353.50, true, 15);

commit;

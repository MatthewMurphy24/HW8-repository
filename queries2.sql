

select roomtype.type_id, roomtype.room_name,
    avg(price.amount * (1 - guestcategory.discount / 100.0)) as avg_cost_per_night
from roomtype
join price on price.type_id = roomtype.type_id
join guestcategory on guestcategory.name = 'Gold'
where roomtype.hotel_id = 1
  and price.season_id = 1
  and price.day_of_week in ('tuesday', 'wednesday')
  and (select count(*) from room where room.type_id = roomtype.type_id)
    > (select count(*) from reservationroomtype
       join reservation on reservation.res_id = reservationroomtype.res_id
       where reservationroomtype.type_id = roomtype.type_id
         and reservation.hotel_id = 1
         and reservation.check_in_date < '2025-07-17'
         and reservation.check_out_date > '2025-07-15')
group by roomtype.type_id, roomtype.room_name
order by avg_cost_per_night;


select room.room_num
from room
where room.type_id = 4
and room.room_num not in (
    select roomassignment.room_num from roomassignment
    where roomassignment.check_in <= '2026-05-04'
    and roomassignment.check_out > '2026-05-04'
);


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


select guest.id_num as reserver_id, 'reserver' as role, null as first_name, null as last_name
from reservation
join guest on guest.guest_id = reservation.guest_id
join roomassignment on roomassignment.res_id = reservation.res_id
where roomassignment.room_num = 205
  and roomassignment.check_in <= '2025-07-03'
  and roomassignment.check_out > '2025-07-03'

union

select null, 'occupant', occupant.first_name, occupant.last_name
from roomassignment
join roomoccupant on roomoccupant.assignment_id = roomassignment.assignment_id
join occupant on occupant.occupant_id = roomoccupant.occupant_id
where roomassignment.room_num = 205
  and roomassignment.check_in <= '2025-07-03'
  and roomassignment.check_out > '2025-07-03';


select guest.id_num, sum(bill.total_amount) as total_spent
from guest
join reservation on reservation.guest_id = guest.guest_id
join bill on bill.res_id = reservation.res_id
where guest.guest_id = 12
  and bill.issue_date >= '2025-01-01'
  and bill.issue_date < '2026-01-01'
group by guest.id_num;

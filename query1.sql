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

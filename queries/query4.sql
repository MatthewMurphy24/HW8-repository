select g.id_num as reserver_id, g.id_num as reserver_name, 'reserver' as role
from reservation
join guest g on g.guest_id = reservation.guest_id
join roomassignment on roomassignment.res_id = reservation.res_id
where roomassignment.room_num = 205
  and roomassignment.check_in <= '2025-07-03'
  and roomassignment.check_out > '2025-07-03'

union

select null as reserver_id, occupant.first_name || ' ' || occupant.last_name as reserver_name, 'occupant' as role
from roomassignment
join roomoccupant on roomoccupant.assignment_id = roomassignment.assignment_id
join occupant on occupant.occupant_id = roomoccupant.occupant_id
where roomassignment.room_num = 205
  and roomassignment.check_in <= '2025-07-03'
  and roomassignment.check_out > '2025-07-03';

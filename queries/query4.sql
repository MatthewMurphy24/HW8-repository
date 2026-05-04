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

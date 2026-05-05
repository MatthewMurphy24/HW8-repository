select room.room_num
from room
where room.type_id = 4
and room.room_num not in (
    select v_room_occupancy.room_num from v_room_occupancy
    where v_room_occupancy.check_in <= '2026-05-04'
    and v_room_occupancy.check_out > '2026-05-04'
);


begin;

insert into occupant (occupant_id, first_name, last_name)
values (1, 'john', 'smith');

insert into reservation (res_id, check_in_date, check_out_date, guest_id, hotel_id)
values (16, '2026-05-03', '2026-05-06', 1, 2);

insert into roomassignment (assignment_id, res_id, room_num, check_in, check_out)
values (7, 16, 204, '2026-05-03', '2026-05-06');

commit;

begin;

insert into roomassignment (assignment_id, res_id, room_num, check_in, check_out)
values (8, 15, 205, '2026-05-04', '2026-05-06');

insert into roomoccupant (assignment_id, occupant_id) values (8, 1);
insert into roomoccupant (assignment_id, occupant_id) values (8, 2);

commit;

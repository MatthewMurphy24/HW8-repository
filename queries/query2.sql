select room.room_num
from room
where room.type_id = 4
and room.room_num not in (
    select v_room_occupancy.room_num from v_room_occupancy
    where v_room_occupancy.check_in <= '2026-05-04'
    and v_room_occupancy.check_out > '2026-05-04'
);


insert into guest (guest_id, id_type, id_num, address, home_phone, mobile_phone, category_id)
values (12, 'passport', 'P222222', '2 Oak St', '333-3333', '444-4444', 1);

insert into reservation (res_id, check_in_date, check_out_date, guest_id, hotel_id)
values (15, '2026-05-04', '2026-05-06', 12, 2);

insert into reservationroomtype (res_id, type_id, quantity)
values (15, 4, 1);

insert into reservation (res_id, check_in_date, check_out_date, guest_id, hotel_id)
values (16, '2026-05-03', '2026-05-06', 1, 2);

insert into roomassignment (assignment_id, res_id, room_num, check_in, check_out)
values (7, 16, 204, '2026-05-03', '2026-05-06');

insert into roomassignment (assignment_id, res_id, room_num, check_in, check_out)
values (8, 15, 205, '2026-05-04', '2026-05-06');

insert into roomoccupant (assignment_id, occupant_id) values (8, 1);
insert into roomoccupant (assignment_id, occupant_id) values (8, 2);



update price set amount = 50
where type_id = 1 and season_id = 1 and day_of_week = 'wednesday';

update price set amount = 100
where type_id = 2 and season_id = 1 and day_of_week = 'wednesday';

insert into reservation (res_id, check_in_date, check_out_date, guest_id, hotel_id)
values (13, '2025-07-15', '2025-07-17', 1, 1);

insert into reservationroomtype (res_id, type_id, quantity)
values (13, 2, 3);

insert into guest (guest_id, id_type, id_num, address, home_phone, mobile_phone, category_id)
values (11, 'passport', 'P111111', '1 Main St', '111-1111', '222-2222', 2);

insert into reservation (res_id, check_in_date, check_out_date, guest_id, hotel_id)
values (14, '2025-07-15', '2025-07-17', 11, 1);

insert into reservationroomtype (res_id, type_id, quantity)
values (14, 1, 1);


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


update guest set category_id = 2 where guest_id = 12;

update reservation set check_in_date = '2025-07-03', check_out_date = '2025-07-05' where res_id = 15;

update roomassignment set check_in = '2025-07-03', check_out = '2025-07-05' where assignment_id = 8;

insert into servicecharge (service_id, res_id, service_type, amount, charge_date)
values (7, 15, 'room service', 25.00, '2025-07-04');

update roomassignment set check_out = '2025-07-05' where assignment_id = 8;

insert into bill (bill_id, issue_date, total_amount, is_paid, res_id)
values (5, '2025-07-05', 353.50, true, 15);


insert into reservation (res_id, check_in_date, check_out_date, guest_id, hotel_id)
values (17, '2025-07-10', '2025-07-12', 12, 1);

insert into reservationroomtype (res_id, type_id, quantity)
values (17, 1, 1);

insert into bill (bill_id, issue_date, total_amount, is_paid, res_id)
values (6, '2025-07-12', 193.50, true, 17);

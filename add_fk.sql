
alter table hotelphone
    add constraint fk_hotelphone_hotel
    foreign key (hotel_id) references hotel(hotel_id);

alter table hotelfeature
    add constraint fk_hotelfeature_hotel
    foreign key (hotel_id) references hotel(hotel_id);

alter table hotelseason
    add constraint fk_hotelseason_hotel
    foreign key (hotel_id) references hotel(hotel_id),
    add constraint fk_hotelseason_season
    foreign key (season_id) references season(season_id);

alter table roomtype
    add constraint fk_roomtype_hotel
    foreign key (hotel_id) references hotel(hotel_id);

alter table roomtypefeature
    add constraint fk_roomtypefeature_roomtype
    foreign key (type_id) references roomtype(type_id);

alter table room
    add constraint fk_room_roomtype
    foreign key (type_id) references roomtype(type_id);

alter table price
    add constraint fk_price_roomtype
    foreign key (type_id) references roomtype(type_id),
    add constraint fk_price_season
    foreign key (season_id) references season(season_id);

alter table guest
    add constraint fk_guest_category
    foreign key (category_id) references guestcategory(category_id);

alter table reservation
    add constraint fk_reservation_guest
    foreign key (guest_id) references guest(guest_id),
    add constraint fk_reservation_hotel
    foreign key (hotel_id) references hotel(hotel_id);

alter table reservationroomtype
    add constraint fk_reservationroomtype_res
    foreign key (res_id) references reservation(res_id),
    add constraint fk_reservationroomtype_type
    foreign key (type_id) references roomtype(type_id);

alter table reservationoccupant
    add constraint fk_reservationoccupant_res
    foreign key (res_id) references reservation(res_id),
    add constraint fk_reservationoccupant_occupant
    foreign key (occupant_id) references occupant(occupant_id);

alter table roomassignment
    add constraint fk_roomassignment_res
    foreign key (res_id) references reservation(res_id),
    add constraint fk_roomassignment_room
    foreign key (room_num) references room(room_num);

alter table roomoccupant
    add constraint fk_roomoccupant_assignment
    foreign key (assignment_id) references roomassignment(assignment_id),
    add constraint fk_roomoccupant_occupant
    foreign key (occupant_id) references occupant(occupant_id);

alter table bill
    add constraint fk_bill_reservation
    foreign key (res_id) references reservation(res_id);

alter table servicecharge
    add constraint fk_servicecharge_reservation
    foreign key (res_id) references reservation(res_id);

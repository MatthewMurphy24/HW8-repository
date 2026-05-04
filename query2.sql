select room.room_num
from room
where room.type_id = 4
and room.room_num not in (
    select roomassignment.room_num from roomassignment
    where roomassignment.check_in <= '2026-05-04'
    and roomassignment.check_out > '2026-05-04'
);

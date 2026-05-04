select guest.id_num, sum(bill.total_amount) as total_spent
from guest
join reservation on reservation.guest_id = guest.guest_id
join bill on bill.res_id = reservation.res_id
where guest.guest_id = 12
  and bill.issue_date >= '2025-01-01'
  and bill.issue_date < '2026-01-01'
group by guest.id_num;

-- Query 1
SELECT
  bookings.booking_id,
  users.name AS customer_name,
  vehicles.name AS vehicle_name,
  bookings.start_date,
  bookings.end_date,
  bookings.status
FROM
  bookings
  JOIN users ON bookings.booking_id = users.user_id
  JOIN vehicles ON bookings.booking_id = vehicles.vehicle_id

-- Query 2
SELECT * FROM vehicles WHERE NOT EXISTS (SELECT * FROM bookings WHERE bookings.vehicle_id = vehicles.vehicle_id)

-- Query 3
SELECT * FROM vehicles WHERE type = 'car' AND status = 'available'

-- Query 4
SELECT v.name AS vehicle_name, count(*) AS total_bookings FROM bookings b JOIN vehicles v ON b.vehicle_id = v.vehicle_id GROUP BY vehicle_name HAVING count(*) > 2
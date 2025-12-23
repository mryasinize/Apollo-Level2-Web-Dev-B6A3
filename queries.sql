-- Query for creating tables

CREATE TABLE IF NOT EXISTS users (
  user_id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  phone VARCHAR(20) NOT NULL,
  password TEXT NOT NULL,
  role VARCHAR(20) NOT NULL CHECK (role IN ('Admin', 'Customer'))
)

CREATE TABLE IF NOT EXISTS vehicles (
  vehicle_id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  type VARCHAR(20) NOT NULL CHECK (type IN ('car', 'bike', 'truck')),
  model VARCHAR(255) NOT NULL,
  registration_number VARCHAR(255) NOT NULL UNIQUE,
  rental_price INT NOT NULL,
  status VARCHAR(20) CHECK (status IN ('available', 'rented', 'maintenance'))
)

CREATE TABLE IF NOT EXISTS bookings (
  booking_id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users (user_id),
  vehicle_id INT REFERENCES vehicles (vehicle_id),
  start_date DATE NOT NULL,
  end_date DATE NOT NULL CHECK (end_date > start_date),
  status VARCHAR(20) NOT NULL CHECK (
    status IN ('pending', 'confirmed', 'completed', 'cancelled')
  ),
  total_cost INT NOT NULL
)

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
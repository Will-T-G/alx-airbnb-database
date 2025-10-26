-- =============================================
-- Airbnb Database: Sample Data (Seed Script)
-- =============================================

-- NOTE: Assumes schema.sql has already been executed

-- =============================================
-- USERS
-- =============================================
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
    (gen_random_uuid(), 'John', 'Doe', 'john@example.com', 'hashed_pw_1', '+12025550111', 'guest'),
    (gen_random_uuid(), 'Alice', 'Smith', 'alice@example.com', 'hashed_pw_2', '+12025550112', 'host'),
    (gen_random_uuid(), 'Michael', 'Brown', 'mike@example.com', 'hashed_pw_3', '+12025550113', 'guest'),
    (gen_random_uuid(), 'Sarah', 'Johnson', 'sarah@example.com', 'hashed_pw_4', '+12025550114', 'host'),
    (gen_random_uuid(), 'Admin', 'User', 'admin@example.com', 'hashed_pw_admin', NULL, 'admin');

-- =============================================
-- PROPERTIES
-- =============================================
INSERT INTO properties (property_id, host_id, name, description, location, price_per_night)
SELECT
    gen_random_uuid(), user_id, name, description, location, price_per_night
FROM (
    VALUES
        ('Alice''s Loft', 'Cozy studio apartment with city view', 'New York', 150.00),
        ('Sarah''s Beach House', 'Modern beach house near the coast', 'Miami', 250.00)
) AS p(name, description, location, price_per_night)
JOIN users u ON u.email IN ('alice@example.com', 'sarah@example.com');

-- =============================================
-- BOOKINGS
-- =============================================
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, status)
SELECT
    gen_random_uuid(), p.property_id, u.user_id, s.start_date, s.end_date, s.status
FROM (
    VALUES
        ('john@example.com', 'Alice''s Loft', '2025-10-01', '2025-10-05', 'confirmed'),
        ('mike@example.com', 'Sarah''s Beach House', '2025-11-10', '2025-11-15', 'pending')
) AS s(email, property_name, start_date, end_date, status)
JOIN users u ON u.email = s.email
JOIN properties p ON p.name = s.property_name;

-- =============================================
-- PAYMENTS
-- =============================================
INSERT INTO payments (payment_id, booking_id, amount, payment_method)
SELECT
    gen_random_uuid(), b.booking_id,
    CASE WHEN b.status = 'confirmed' THEN (p.price_per_night * (b.end_date - b.start_date)) ELSE 0 END,
    'credit_card'
FROM bookings b
JOIN properties p ON b.property_id = p.property_id;

-- =============================================
-- REVIEWS
-- =============================================
INSERT INTO reviews (review_id, property_id, user_id, rating, comment)
SELECT
    gen_random_uuid(), p.property_id, u.user_id,
    r.rating, r.comment
FROM (
    VALUES
        ('john@example.com', 'Alice''s Loft', 5, 'Amazing stay! Very clean and comfortable.'),
        ('mike@example.com', 'Sarah''s Beach House', 4, 'Loved the location and view!')
) AS r(email, property_name, rating, comment)
JOIN users u ON u.email = r.email
JOIN properties p ON p.name = r.property_name;

-- =============================================
-- MESSAGES
-- =============================================
INSERT INTO messages (message_id, sender_id, recipient_id, message_body)
SELECT
    gen_random_uuid(), s.user_id, r.user_id, m.message_body
FROM (
    VALUES
        ('john@example.com', 'alice@example.com', 'Hi Alice, is your loft available next weekend?'),
        ('alice@example.com', 'john@example.com', 'Hi John! Yes, it is available.')
) AS m(sender_email, recipient_email, message_body)
JOIN users s ON s.email = m.sender_email
JOIN users r ON r.email = m.recipient_email;

-- =============================================
-- END OF SEED SCRIPT
-- =============================================


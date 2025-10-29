-- 1️⃣ Initial (non-optimized) query
-- This query retrieves all bookings with user, property, and payment details
EXPLAIN ANALYZE
SELECT 
    b.id AS booking_id,
    b.booking_date,
    b.start_date,
    b.end_date,
    u.name AS user_name,
    u.email AS user_email,
    p.title AS property_title,
    p.location AS property_location,
    pay.amount AS payment_amount,
    pay.status AS payment_status
FROM 
    bookings b
JOIN 
    users u ON b.user_id = u.id
JOIN 
    properties p ON b.property_id = p.id
JOIN 
    payments pay ON pay.booking_id = b.id
ORDER BY 
    b.booking_date DESC;


-- ⚠️ Potential inefficiencies:
-- - SELECT * (or many columns) increases I/O cost
-- - ORDER BY without index slows down sorting
-- - Joining all tables when not all data is needed
-- - Missing indexes on user_id, property_id, booking_id


-- 2️⃣ Refactored (optimized) query
-- Improvements:
-- - Select only required fields
-- - Use proper indexing (see database_index.sql)
-- - Use LEFT JOIN if not all bookings have payments
-- - Avoid ORDER BY unless needed for output

EXPLAIN ANALYZE
SELECT 
    b.id AS booking_id,
    u.name AS user_name,
    p.title AS property_title,
    pay.amount AS payment_amount
FROM 
    bookings b
INNER JOIN 
    users u ON b.user_id = u.id
INNER JOIN 
    properties p ON b.property_id = p.id
LEFT JOIN 
    payments pay ON pay.booking_id = b.id;


-- ✅ Expected improvements:
-- - Reduced execution time due to fewer columns and indexed joins
-- - Lower CPU and memory usage
-- - Faster response on large datasets


-- ============================================
-- 3️⃣ Notes for Report:
-- - Use EXPLAIN ANALYZE output to compare total cost and execution time
-- - After indexing, query performance can improve by 60–80% depending on dataset size
-- ============================================


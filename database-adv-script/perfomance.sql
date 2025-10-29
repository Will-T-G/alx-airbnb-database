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
WHERE 
    b.status = 'confirmed'
    AND pay.status = 'completed'
ORDER BY 
    b.booking_date DESC;


-- ⚠️ Potential inefficiencies:
-- - SELECT many columns increases I/O
-- - ORDER BY without index slows down sorting
-- - Unnecessary joins on large tables
-- - Missing indexes on foreign keys


-- 2️⃣ Refactored (optimized) query
-- Improvements:
-- - Select only necessary fields
-- - Apply proper indexes
-- - Use LEFT JOIN for optional relationships
-- - Maintain WHERE + AND for filtered access

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
    payments pay ON pay.booking_id = b.id
WHERE 
    b.status = 'confirmed'
    AND (pay.status = 'completed' OR pay.status IS NULL);


-- ✅ Expected Improvements:
-- - Reduced execution time
-- - Better use of indexes on (status), (user_id), (property_id)
-- - Lower I/O load


-- ============================================
-- 3️⃣ Notes for Report:
-- - Compare EXPLAIN ANALYZE total cost & execution time
-- - Indexing columns in WHERE clause improves performance drastically
-- ============================================

-- ============================================
-- File: database_index.sql
-- Purpose: Create indexes to improve query performance
-- Author: Matthew B. Kollie, III
-- ============================================

-- 1️⃣ Create indexes on high-usage columns in Users, Bookings, and Properties

-- Index for Users table (commonly used in WHERE or JOIN conditions)
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_id ON users(id);

-- Index for Bookings table (frequently joined and filtered)
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_booking_date ON bookings(booking_date);

-- Index for Properties table (used in search and filters)
CREATE INDEX idx_properties_location ON properties(location);
CREATE INDEX idx_properties_price ON properties(price);
CREATE INDEX idx_properties_id ON properties(id);

-- ============================================
-- 2️⃣ Example query performance measurement
-- ============================================

-- Before creating index
EXPLAIN ANALYZE 
SELECT * 
FROM bookings 
WHERE user_id = 42;

-- After creating index
EXPLAIN ANALYZE 
SELECT * 
FROM bookings 
WHERE user_id = 42;

-- Expected result:
-- Execution time should drop significantly after adding the index.

-- ============================================
-- 3️⃣ Notes:
-- - Indexes improve SELECT performance but slightly slow down INSERT/UPDATE/DELETE.
-- - Always index columns used frequently in WHERE, JOIN, and ORDER BY clauses.
-- ============================================

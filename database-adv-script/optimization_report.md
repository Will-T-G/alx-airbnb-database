Initial Query Analysis

Retrieved all bookings with user, property, and payment details via multiple joins
Used EXPLAIN to identify performance bottlenecks

Issues Identified

Missing indexes on foreign keys (user_id, property_id, payment_id)
Full table scans on all tables
Using SELECT * instead of specific columns
No pagination or result limiting

Optimizations Applied
1. Added Indexes
sqlCREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_payment_id ON bookings(payment_id);
2. Query Improvements

Selected only required columns
Optimized join order
Added LIMIT for pagination
Used INNER JOIN explicitly

Results

Before: High execution cost, full table scans
After: Reduced execution time by ~X%, index seeks instead of scans

Key Takeaways

Index foreign keys used in joins
Avoid SELECT * in production queries
Always use pagination for large datasets
Monitor performance with EXPLAIN ANALYZE

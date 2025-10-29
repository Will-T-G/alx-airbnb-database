Index Performance Analysis
High-Usage Columns Identified
User Table

email - WHERE clauses (login/search)
created_at - ORDER BY

Booking Table

user_id - JOIN operations
property_id - JOIN operations
booking_date - WHERE, ORDER BY
status - WHERE clauses

Property Table

location - WHERE clauses
price_per_night - WHERE, ORDER BY

Indexes Created (database_index.sql)
sqlCREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_date ON bookings(booking_date);
CREATE INDEX idx_bookings_status ON bookings(status);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_properties_location ON properties(location);
CREATE INDEX idx_properties_price ON properties(price_per_night);
Performance Impact
Before Indexes: Full table scans, high execution times
After Indexes: Index seeks used, execution time reduced by ~X%

JOIN queries significantly faster with foreign key indexes
WHERE clause filters improved with column indexes
ORDER BY operations more efficient

Recommendations

Monitor index usage regularly
Consider composite indexes for multi-column filters
Avoid over-indexing (impacts writes)

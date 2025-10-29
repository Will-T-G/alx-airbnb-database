-- 1️⃣ Step 1: Create a partitioned version of the bookings table
-- Partition by RANGE based on the start_date column

-- Drop the table if it already exists (for testing)
DROP TABLE IF EXISTS bookings CASCADE;

-- Create the parent table
CREATE TABLE bookings (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(20),
    total_amount DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
PARTITION BY RANGE (start_date);


-- 2️⃣ Step 2: Create partitions for different time periods

CREATE TABLE bookings_2023 PARTITION OF bookings
FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE bookings_2024 PARTITION OF bookings
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE bookings_2025 PARTITION OF bookings
FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Optional: Add indexes on key columns for better performance
CREATE INDEX idx_bookings_2023_user_id ON bookings_2023(user_id);
CREATE INDEX idx_bookings_2024_user_id ON bookings_2024(user_id);
CREATE INDEX idx_bookings_2025_user_id ON bookings_2025(user_id);

CREATE INDEX idx_bookings_2023_start_date ON bookings_2023(start_date);
CREATE INDEX idx_bookings_2024_start_date ON bookings_2024(start_date);
CREATE INDEX idx_bookings_2025_start_date ON bookings_2025(start_date);


-- 3️⃣ Step 3: Test query performance before and after partitioning

-- Non-partitioned query example (before)
EXPLAIN ANALYZE
SELECT * FROM bookings
WHERE start_date BETWEEN '2024-05-01' AND '2024-05-31';

-- Expected: Slow scan across entire bookings table


-- Partitioned query example (after)
EXPLAIN ANALYZE
SELECT * FROM bookings
WHERE start_date BETWEEN '2024-05-01' AND '2024-05-31';

-- Expected: PostgreSQL scans only bookings_2024 partition

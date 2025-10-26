
---

## 🧠 Objective
This directory defines the core **SQL schema** for the Airbnb database project.

It includes:
- Table definitions for Users, Properties, Bookings, Payments, Reviews, and Messages.
- Relationships and constraints enforcing referential integrity.
- Indexes for optimized performance on key queries.

---

## 🧩 Schema Overview
Each entity in the database represents a real-world Airbnb concept.

| Entity | Description |
|---------|--------------|
| **User** | Stores guest, host, and admin data. |
| **Property** | Lists the accommodations added by hosts. |
| **Booking** | Records user reservations and their status. |
| **Payment** | Tracks payments for bookings. |
| **Review** | Contains ratings and feedback from users. |
| **Message** | Handles direct communication between users. |

---

## ⚙️ Setup Instructions

1. Open your SQL client (e.g. **MySQL**, **PostgreSQL**, or **SQLite**).
2. Copy the contents of `schema.sql` into your SQL terminal.
3. Run the script to create all database tables.

Example (for PostgreSQL):
```bash
psql -U your_username -d airbnb_db -f schema.sql


# Normalization Analysis — Airbnb ERD

## Summary
This document reviews the ERD for the Airbnb database and recommends changes to satisfy Third Normal Form (3NF) where appropriate. It explains detected redundancies, normalization violations, and the corrective actions.

---

## Observed schema items (from ERD)
- Entities: `User`, `Property`, `Booking`, `Payment`, `Review`, `Message`.
- Notable attributes visible in the diagram:
  - `Booking.total_price`
  - `Payment.amount`
  - `Review` references `property_id`, `user_id` (no `booking_id`)
  - `Property.location` (freeform)
  - `Message` references `sender_id` and `recipient_id`

---

## Normalization issues & recommendations

### 1) Booking.total_price (derived)
- **Issue:** `total_price` is derived from `Property.price_per_night` and booking dates. Storing it creates a transitive dependency (not 3NF).
- **Recommendation:** Remove `total_price` from `Booking` and compute it when needed:

total_price = price_per_night * number_of_nights

Optionally, store a `snapshot_price_per_night` in Booking if historical price capture is required.

### 2) Payment.amount (transaction record)
- **Issue:** Could duplicate `Booking.total_price`.
- **Recommendation:** Keep `Payment.amount` as the authoritative transaction amount (payments can be partial, include fees, or differ). Do **not** assume equality; treat Payment as the financial record.

### 3) Review linkage to Booking
- **Issue:** Review references `property_id` and `user_id` but there is no guarantee the reviewer booked the property.
- **Recommendation:** Add `booking_id` to Review (nullable if you permit unverified reviews). Prefer `NOT NULL` if reviews must be tied to bookings. Optionally enforce unique review-per-booking.

### 4) Location field normalization
- **Issue:** `location` as a freeform string limits useful queries and causes duplication.
- **Recommendation (optional):** Normalize to `Location`/`Address` table if you need structured data (city, country, lat/long).

### 5) Message threading
- **Issue:** Messages have sender and recipient only.
- **Recommendation (optional):** Add `Conversation` and `ConversationParticipant` tables for threading.

---

## Proposed adjusted schema (3NF-friendly)
(Truncated DDL — see code in the repository for full details)
- `User(user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)`
- `Property(property_id, host_id -> User, name, description, location, price_per_night, created_at, updated_at)`
- `Booking(booking_id, property_id -> Property, user_id -> User, start_date, end_date, status, created_at)`
- `total_price` removed (compute at runtime) or replace with `snapshot_price_per_night` if historical capture required.
- `Payment(payment_id, booking_id -> Booking, amount, payment_date, payment_method)`
- `Review(review_id, booking_id -> Booking NULL|NOT NULL, property_id -> Property, user_id -> User, rating, comment, created_at)`
- `Message(message_id, sender_id -> User, recipient_id -> User, message_body, sent_at, conversation_id NULL)`

---

## Business rules to implement in application/DB
- Enforce referential integrity (FK constraints) and cascading behaviors as appropriate.
- If reviews are only for verified guests, require `Review.booking_id NOT NULL` and validate booking ownership.
- Store transaction `amount` on Payment as authoritative.
- When denormalizing (storing `total_price`), document and justify the trade-off (performance vs. normalization).

---

## Conclusion
- The diagram is structurally sound for 1NF/2NF.
- The main 3NF concerns are derived values (Booking.total_price) and business constraints for Review.
- Apply the recommendations above to reach 3NF or intentionally document denormalizations that are kept for practical reasons (performance, audit history).

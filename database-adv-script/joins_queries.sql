(1.) Write a query using an INNER JOIN to retrieve all bookings and the respective users who made those bookings.

SELECT 
    users.id AS user_id,
    users.first_name,
    users.last_name,
    bookings.id AS booking_id,
    bookings.property_id,
    bookings.check_in,
    bookings.check_out,
    bookings.status
FROM 
    users
INNER JOIN 
    bookings
ON 
    users.id = bookings.user_id;


(2.) Write a query using aLEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.

SELECT 
    properties.id AS property_id,
    properties.title,
    properties.location,
    reviews.id AS review_id,
    reviews.rating,
    reviews.comment
FROM 
    properties
LEFT JOIN 
    reviews
ON 
    properties.id = reviews.property_id;

(3.) Write a query using a FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.

SELECT 
    users.id AS user_id,
    users.first_name,
    users.last_name,
    bookings.id AS booking_id,
    bookings.property_id,
    bookings.check_in,
    bookings.check_out,
    bookings.status
FROM 
    users
FULL OUTER JOIN 
    bookings
ON 
    users.id = bookings.user_id;



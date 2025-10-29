Write a query to find all properties where the average rating is greater than 4.0 using a subquery.

SELECT 
    id,
    title,
    location
FROM 
    properties
WHERE 
    id IN (
        SELECT 
            property_id
        FROM 
            reviews
        GROUP BY 
            property_id
        HAVING 
            AVG(rating) > 4.0
    )
ORDER BY 
    id;


Write a correlated subquery to find users who have made more than 3 bookings.


SELECT 
    id,
    name,
    email
FROM 
    users u
WHERE 
    (
        SELECT 
            COUNT(*) 
        FROM 
            bookings b 
        WHERE 
            b.user_id = u.id
    ) > 3
ORDER BY 
    id;


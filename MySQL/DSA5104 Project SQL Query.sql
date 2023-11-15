-- Query 4.1
SELECT 
    u.user_id, 
    u.username, 
    t.*
FROM 
    user u
JOIN 
    transaction t ON u.user_id = t.user_id
WHERE 
    u.username = 'Jason Law';
		
-- Query 4.2		
SELECT 
    name, 
    review_scores_rating
FROM 
    Listing
WHERE 
    city = 'Singapore'
ORDER BY 
    review_scores_rating DESC
LIMIT 10;

-- Query 4.3
SELECT 
    U.user_id, 
    U.username, 
    U.email, 
    U.join_date, 
    U.location, 
    COUNT(R.reviewer_id) AS number_of_reviews
FROM 
    User U
JOIN 
    Review R ON U.user_id = R.reviewer_id
GROUP BY 
    U.user_id
ORDER BY 
    number_of_reviews DESC
LIMIT 1;

-- Query 4.4
SELECT 
    H.host_id, 
    H.host_name, 
    H.host_since, 
    H.host_location, 
    H.host_about, 
    H.host_response_rate, 
    H.host_acceptance_rate, 
    H.host_is_superhost, 
    H.host_neighbourhood, 
    H.host_listings_count, 
    H.host_identity_verified,
    COUNT(L.id) AS number_of_listings
FROM 
    Host H
LEFT JOIN 
    Listing L ON H.host_id = L.host_id
GROUP BY 
    H.host_id, 
    H.host_name, 
    H.host_since, 
    H.host_location, 
    H.host_about, 
    H.host_response_rate, 
    H.host_acceptance_rate, 
    H.host_is_superhost, 
    H.host_neighbourhood, 
    H.host_listings_count, 
    H.host_identity_verified
ORDER BY 
    number_of_listings DESC
LIMIT 1;

-- Query 4.5.1
SELECT 
    L.id,
    L.name,
    L.description,
    C.price,
    L.accommodates
FROM 
    Listing L
JOIN 
    Calendar C ON L.id = C.listing_id
JOIN 
    Neighbourhood N ON L.neighbourhood_cleansed = N.neighbourhood
WHERE 
    N.city = 'Singapore' AND 
    N.neighbourhood_group = 'Central Region' AND 
    L.accommodates >= 4 AND 
    L.pets_allowed = 1 AND 
    L.wifi = 1 AND 
    C.price < 300 AND 
    C.available > 0 AND 
    C.year = 2024 AND 
    C.month = 5
GROUP BY 
    L.id

-- Query 4.5.3
SELECT 
    L.id,
    L.name,
    L.description,
    L.accommodates
FROM 
    Listing L
JOIN 
    calendar_date C ON L.id = C.listing_id
JOIN 
    Neighbourhood N ON L.neighbourhood_cleansed = N.neighbourhood
WHERE 
    N.neighbourhood_group = 'Central Region' AND 
		N.city = 'Singapore' AND
    L.accommodates >= 4 AND 
    L.pets_allowed = 1 AND 
    L.wifi = 1 AND 
    C.price < 300 AND 
    C.available = 1 AND 
    C.date BETWEEN '2024-05-01' AND '2024-05-05'
GROUP BY 
    L.id
HAVING 
    COUNT(C.date) >= 4
Limit 5;

-- Query 4.6
SELECT 
    L.id,
    L.name,
    C.price,
    L.instant_bookable
FROM 
    Listing L
JOIN 
    Calendar C ON L.id = C.listing_id
WHERE 
    L.instant_bookable = 't' AND 
    C.price < 50
GROUP BY 
    L.id,
    L.name,
    C.price,
    L.instant_bookable
Limit 5;

-- Query 4.7
SELECT 
    L.host_id,
    H.host_name,
    SUM(L.number_of_reviews) AS total_reviews
FROM 
    Listing L
JOIN 
    Host H ON L.host_id = H.host_id
GROUP BY 
    L.host_id, H.host_name
ORDER BY 
    total_reviews DESC
LIMIT 1;

-- Query 4.8
SELECT 
    L.name,
    L.description,
    N.neighbourhood_group AS region,
    L.accommodates,
    C.price
FROM 
    Listing L
JOIN 
    Neighbourhood N ON L.neighbourhood_cleansed = N.neighbourhood
JOIN 
    Calendar C ON L.id = C.listing_id
WHERE 
    N.neighbourhood_group = 'Central Region' AND
		N.city = 'Singapore' AND
    C.year = 2023 AND 
    C.month = 11 AND
    C.available > 0
GROUP BY 
    L.id
ORDER BY 
    L.id ASC
LIMIT 10;

-- Query 4.9
START TRANSACTION;

INSERT INTO transaction (transaction_id, user_id, listing_id, booking_date, check_in_date, price_per_night, total_price)
VALUES (1234512345, 100001332, 10001507, CURRENT_DATE(), '2024-04-21', 31.36, 31.36);

UPDATE calendar_date
SET available = 0
WHERE listing_id = 10001501 AND date = '2024-04-21';

COMMIT;





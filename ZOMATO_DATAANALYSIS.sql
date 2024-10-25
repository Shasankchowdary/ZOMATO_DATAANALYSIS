create database zomato_dataanalysis;
use zomato_dataanalysis;
CREATE TABLE Restaurants (
    restaurant_id INT PRIMARY KEY,
    name VARCHAR(100),
    cuisine VARCHAR(50),
    average_cost_for_two DECIMAL(10, 2),
    has_table_booking BOOLEAN,
    has_online_delivery BOOLEAN,
    rating DECIMAL(3, 1),
    location VARCHAR(100)
);
CREATE TABLE Reviews (
    review_id INT PRIMARY KEY,
    restaurant_id INT,
    user_id INT,
    rating DECIMAL(3, 1),
    comment TEXT,
    date_of_review DATE,
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id)
);

INSERT INTO Restaurants (restaurant_id, name, cuisine, average_cost_for_two, has_table_booking, has_online_delivery, rating, location)
VALUES
(1, 'Tasty Bites', 'Indian', 500, true, true, 4.5, 'Mumbai'),
(2, 'Pizza Paradise', 'Italian', 600, false, true, 4.2, 'Delhi'),
(3, 'Sushi Express', 'Japanese', 800, true, false, 4.7, 'Bangalore'),
(4, 'Burger Bliss', 'American', 400, false, true, 3.9, 'Mumbai'),
(5, 'Spice Garden', 'Indian', 550, true, false, 4.1, 'Delhi'),
(6, 'Altaj', 'Indian', 420, true, false, 4.5, 'Chennai'),
(7, 'Paradise', 'Russian', 950, false, false, 3.1, 'Guntur'),
(8, 'Gunturkaram', 'Chinese', 230, false, false, 3.6, 'Kerala'),
(9, 'Eatsure', 'Greek', 650, true, true, 3.2, 'Karnataka'),
(10, 'Classic', 'Spanish', 370, false, true, 2.5, 'oddisa');


INSERT INTO Reviews (review_id, restaurant_id, user_id, rating, comment, date_of_review)
VALUES
(1, 1, 101, 4.5, 'Great food and ambiance!', '2023-01-15'),
(2, 1, 102, 4.0, 'Delicious but a bit pricey', '2023-02-20'),
(3, 2, 103, 4.5, 'Best pizza in town', '2023-03-10'),
(4, 3, 104, 5.0, 'Outstanding sushi, highly recommended', '2023-04-05'),
(5, 4, 105, 3.5, 'Decent burgers, service could be better', '2023-05-12'),
(6, 5, 106, 4.2, 'Authentic Indian flavors, loved it!', '2023-06-18'),
(7, 2, 107, 3.8, 'Good pizza, but delivery was late', '2023-07-22'),
(8, 3, 108, 4.6, 'Fresh sushi and great variety', '2023-08-30'),
(9, 1, 109, 4.7, 'Exceptional service and tasty food', '2023-09-14'),
(10, 4, 110, 3.2, 'Improved a lot since last time', '2023-05-15');

SELECT * FROM Restaurants; 
SELECT * FROM Reviews;

SELECT name, cuisine, rating
FROM Restaurants
ORDER BY rating DESC
LIMIT 5;

SELECT cuisine, COUNT(*) as restaurant_count
FROM Restaurants
GROUP BY cuisine
ORDER BY restaurant_count DESC;

SELECT AVG(average_cost_for_two) as avg_cost
FROM Restaurants;

SELECT name, cuisine, rating
FROM Restaurants
WHERE has_online_delivery = true
ORDER BY rating DESC;

SELECT r.name, AVG(rv.rating) as avg_review_rating
FROM Restaurants r
JOIN Reviews rv ON r.restaurant_id = rv.restaurant_id
GROUP BY r.restaurant_id, r.name
ORDER BY avg_review_rating DESC;

SELECT r.name, COUNT(rv.review_id) as review_count
FROM Restaurants r
LEFT JOIN Reviews rv ON r.restaurant_id = rv.restaurant_id
GROUP BY r.restaurant_id, r.name
ORDER BY review_count DESC;

SELECT r.name, rv.rating, rv.comment, rv.date_of_review
FROM Reviews rv
JOIN Restaurants r ON rv.restaurant_id = r.restaurant_id
ORDER BY rv.date_of_review DESC
LIMIT 5;

WITH avg_rating AS (
    SELECT AVG(rating) as overall_avg
    FROM Restaurants
)
SELECT name, cuisine, rating
FROM Restaurants, avg_rating
WHERE rating > overall_avg
ORDER BY rating DESC;

SELECT 
    CASE 
        WHEN average_cost_for_two < 500 THEN 'Budget'
        WHEN average_cost_for_two BETWEEN 500 AND 700 THEN 'Mid-range'
        ELSE 'Expensive'
    END AS price_category,
    COUNT(*) as restaurant_count
FROM Restaurants
GROUP BY price_category
ORDER BY restaurant_count DESC;

-- #########################################################
-- Strategic Subqueries, Filtering and Campaign Targeting 🎯
-- #########################################################

-- ========================================================
-- SECTION 1: Filter rentals and movie selection 🎬
-- ========================================================

-- Rentals on specific dates and periods
SELECT *
FROM renting
WHERE date_renting BETWEEN '2018-04-01' AND '2018-08-31'
   OR date_renting = '2018-10-09'
ORDER BY date_renting DESC;

-- Select specific movies excluding dramas
SELECT *
FROM movies
WHERE genre <> 'Drama'
   OR title IN ('Showtime', 'Love Actually', 'The Fighter')
ORDER BY renting_price;

-- ========================================================
-- SECTION 2: Ratings and filtering by year ⭐
-- ========================================================

-- Rentals with ratings in 2018
SELECT *
FROM renting
WHERE date_renting BETWEEN '2018-01-01' AND '2018-12-31'
  AND rating IS NOT NULL;

-- Ratings of movie ID 25
SELECT MIN(rating) AS min_rating, 
       MAX(rating) AS max_rating, 
       AVG(rating) AS avg_rating, 
       COUNT(rating) AS number_ratings
FROM renting
WHERE movie_id = '25';

-- ========================================================
-- SECTION 3: Customer demographics and summaries 👥
-- ========================================================

SELECT COUNT(*) AS customers_born_80s
FROM customers
WHERE date_of_birth BETWEEN '1980-01-01' AND '1989-12-31';

SELECT COUNT(*) AS customers_from_germany
FROM customers
WHERE country = 'Germany';

SELECT COUNT(DISTINCT country) AS total_countries
FROM customers;

-- First customer account by country
SELECT country, 
       MIN(date_account_start) AS first_account
FROM customers
GROUP BY country
ORDER BY first_account ASC;

-- ========================================================
-- SECTION 4: Movie and customer rating summaries ⭐
-- ========================================================

-- Average rating per movie
SELECT movie_id, 
       AVG(rating) AS avg_rating,
       COUNT(rating) AS number_ratings,
       COUNT(*) AS number_renting
FROM renting
GROUP BY movie_id
ORDER BY avg_rating DESC;

-- Average rating per customer with >7 rentals
SELECT customer_id, 
       AVG(rating) AS avg_rating,
       COUNT(rating) AS number_ratings,
       COUNT(renting_id) AS number_renting
FROM renting
GROUP BY customer_id
HAVING COUNT(renting_id) > 7
ORDER BY avg_rating ASC;

-- ========================================================
-- SECTION 5: Country-level KPIs and regional behavior 🌍
-- ========================================================

-- Revenue, ratings, rentals per country since 2019
SELECT c.country,                    
       COUNT(m.runtime) AS number_renting,
       AVG(r.rating) AS average_rating,
       SUM(m.renting_price) AS revenue
FROM renting AS r
LEFT JOIN customers AS c ON c.customer_id = r.customer_id
LEFT JOIN movies AS m ON m.movie_id = r.movie_id
WHERE date_renting >= '2019-01-01'
GROUP BY c.country;

-- ========================================================
-- SECTION 6: Behavioral segments and top performers 🔍
-- ========================================================

-- Favorite movie for 1970s customers
SELECT m.title, 
       COUNT(*) AS views,
       AVG(r.rating) AS avg_rating
FROM renting AS r
LEFT JOIN customers AS c ON c.customer_id = r.customer_id
LEFT JOIN movies AS m ON m.movie_id = r.movie_id
WHERE c.date_of_birth BETWEEN '1970-01-01' AND '1979-12-31'
GROUP BY m.title
HAVING COUNT(m.runtime) > 1
ORDER BY avg_rating DESC;

-- Favorite actors for Spanish customers
SELECT a.name,  c.gender,
       COUNT(*) AS number_views, 
       AVG(r.rating) AS avg_rating
FROM renting AS r
LEFT JOIN customers AS c ON r.customer_id = c.customer_id
LEFT JOIN actsin AS ai ON r.movie_id = ai.movie_id
LEFT JOIN actors AS a ON ai.actor_id = a.actor_id
WHERE c.country = 'Spain' 
GROUP BY a.name, c.gender
HAVING AVG(r.rating) IS NOT NULL 
  AND COUNT(*) > 5
ORDER BY avg_rating DESC, number_views DESC;

-- ========================================================
-- SECTION 7: Movie revenue and actor mapping 💸
-- ========================================================

-- Total income per movie
SELECT m.title,  
       SUM(m.renting_price) AS income_movie
FROM renting AS r
LEFT JOIN movies AS m ON r.movie_id = m.movie_id
GROUP BY m.title
ORDER BY income_movie DESC;

-- Actor and movie mapping
SELECT m.title, a.name
FROM actsin AS ai
LEFT JOIN movies AS m ON m.movie_id = ai.movie_id
LEFT JOIN actors AS a ON ai.actor_id = a.actor_id;

-- Age range of US actors
SELECT gender,  
       MAX(year_of_birth) AS youngest,
       MIN(year_of_birth) AS oldest
FROM actors
WHERE nationality = 'USA'
GROUP BY gender;

-- ========================================================
-- SECTION 8: User targeting and platform segmentation 🎯
-- ========================================================

-- Customers with <5 rentals
SELECT *
FROM customers AS c
WHERE 5 > (
  SELECT COUNT(*)
  FROM renting AS r
  WHERE r.customer_id = c.customer_id
);

-- Customers with low ratings
SELECT *
FROM customers AS c
WHERE 4 > (
  SELECT MIN(rating)
  FROM renting AS r
  WHERE r.customer_id = c.customer_id
);

-- Customers with at least one rating
SELECT *
FROM customers AS c 
WHERE EXISTS (
  SELECT 1
  FROM renting AS r
  WHERE rating IS NOT NULL 
    AND r.customer_id = c.customer_id
);

-- ========================================================
-- SECTION 9: Content selection and high performers 🏆
-- ========================================================

-- Movies with more than 5 views or rating > 8
SELECT *
FROM movies AS m
WHERE movie_id IN (
    SELECT movie_id
    FROM renting
    GROUP BY movie_id
    HAVING COUNT(rating) > 5
  )
   OR movie_id IN (
    SELECT movie_id
    FROM renting
    GROUP BY movie_id
    HAVING AVG(rating) > 8
);

-- Movies rated above platform average
SELECT m.title
FROM movies AS m
WHERE movie_id IN (
  SELECT movie_id
  FROM renting
  GROUP BY movie_id
  HAVING AVG(rating) > (
    SELECT AVG(rating)
    FROM renting
  )
);

-- Frequently renting customers
SELECT *
FROM customers
WHERE customer_id IN (
  SELECT customer_id
  FROM renting
  GROUP BY customer_id
  HAVING COUNT(date_renting) > 10
);

-- Frequently rented movies
SELECT *
FROM movies
WHERE movie_id IN (
  SELECT movie_id
  FROM renting
  GROUP BY movie_id
  HAVING COUNT(*) > 5
);

-- ========================================================
-- SECTION 10: Actor & genre diversity 🎬
-- ========================================================

-- Actors in comedy movies
SELECT a.nationality,   
       COUNT(*) AS comedy_actors
FROM actors AS a
WHERE EXISTS (
  SELECT 1
  FROM actsin AS ai
  LEFT JOIN movies AS m ON m.movie_id = ai.movie_id
  WHERE m.genre = 'Comedy'
    AND ai.actor_id = a.actor_id
)
GROUP BY a.nationality;

-- Young non-US actors
SELECT name, nationality, year_of_birth
FROM actors
WHERE nationality <> 'USA'
  AND year_of_birth > 1990;

-- Highly-rated drama movies
SELECT *
FROM movies
WHERE movie_id IN (
  SELECT movie_id
  FROM movies
  WHERE genre = 'Drama'
  INTERSECT
  SELECT movie_id
  FROM renting
  GROUP BY movie_id
  HAVING AVG(rating) > 9
);

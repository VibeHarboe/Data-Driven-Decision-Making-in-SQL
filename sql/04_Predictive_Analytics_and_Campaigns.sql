-- ############################################################
-- Predictive Analytics and Campaign Performance in SQL 🔮📊
-- ############################################################

-- ==========================================================
-- SECTION 1: Customers with predictive value (ratings, habits)
-- ==========================================================

-- Customers who gave at least one rating
SELECT *
FROM customers AS c 
WHERE EXISTS (
  SELECT 1
  FROM renting AS r
  WHERE rating IS NOT NULL 
    AND r.customer_id = c.customer_id
);

-- Customers who gave low ratings (MIN < 4)
SELECT *
FROM customers AS c
WHERE 4 > (
  SELECT MIN(rating)
  FROM renting AS r
  WHERE r.customer_id = c.customer_id
);

-- Customers with fewer than 5 rentals
SELECT *
FROM customers AS c
WHERE 5 > (
  SELECT COUNT(*)
  FROM renting AS r
  WHERE r.customer_id = c.customer_id
);

-- ==========================================================
-- SECTION 2: Content performance and ratings
-- ==========================================================

-- Movies with more than 5 views
SELECT *
FROM movies
WHERE movie_id IN (
  SELECT movie_id
  FROM renting
  GROUP BY movie_id
  HAVING COUNT(*) > 5
);

-- Movies with rating above platform average
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

-- Movies with > 5 ratings OR average rating > 8
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

-- Dramas with avg. rating > 9
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

-- ==========================================================
-- SECTION 3: Customer segmentation and marketing targets
-- ==========================================================

-- Customers who rented > 10 movies
SELECT *
FROM customers
WHERE customer_id IN (
  SELECT customer_id
  FROM renting
  GROUP BY customer_id
  HAVING COUNT(date_renting) > 10
);

-- Young non-US actors
SELECT name, nationality, year_of_birth
FROM actors
WHERE nationality <> 'USA'
  AND year_of_birth > 1990;

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

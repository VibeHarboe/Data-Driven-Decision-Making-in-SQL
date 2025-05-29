-- #########################################################
-- Business KPIs and Foundational SQL Filters for Decision Making
-- #########################################################

-- =========================================================
-- SECTION 1: Filter rentals on specific dates and ranges
-- =========================================================
-- Rentals on a specific date
SELECT *
FROM renting
WHERE date_renting = '2018-10-09';

-- Rentals between April and August 2018
SELECT *
FROM renting
WHERE date_renting BETWEEN '2018-04-01' AND '2018-08-31';

-- All rentals ordered by most recent first
SELECT *
FROM renting
ORDER BY date_renting DESC;

-- =========================================================
-- SECTION 2: Movie selection and filtering
-- =========================================================
-- Movies that are not classified as 'Drama'
SELECT *
FROM movies
WHERE genre <> 'Drama';

-- Specific movie titles
SELECT *
FROM movies
WHERE title IN ('Showtime', 'Love Actually', 'The Fighter');

-- All movies ordered by renting price
SELECT *
FROM movies
ORDER BY renting_price ASC;

-- =========================================================
-- SECTION 3: Rentals with ratings in a specific year
-- =========================================================
SELECT *
FROM renting
WHERE date_renting BETWEEN '2018-01-01' AND '2018-12-31'
  AND rating IS NOT NULL;

-- =========================================================
-- SECTION 4: Customer segmentation and demographics
-- =========================================================
-- Customers born in the 1980s
SELECT COUNT(*) AS customers_born_in_80s
FROM customers
WHERE date_of_birth BETWEEN '1980-01-01' AND '1989-12-31';

-- Customers located in Germany
SELECT COUNT(*) AS customers_from_germany
FROM customers
WHERE country = 'Germany';

-- Distinct countries with MovieNow customers
SELECT COUNT(DISTINCT country) AS number_of_customer_countries
FROM customers;

-- =========================================================
-- SECTION 5: Summary statistics for specific movie ratings
-- =========================================================
SELECT 
  MIN(rating) AS min_rating, 
  MAX(rating) AS max_rating, 
  AVG(rating) AS avg_rating, 
  COUNT(rating) AS number_ratings
FROM renting
WHERE movie_id = 25;

-- =========================================================
-- SECTION 6: Aggregated rental KPIs since 2019
-- =========================================================
SELECT 
  COUNT(*) AS number_renting,
  AVG(rating) AS average_rating,
  COUNT(rating) AS number_ratings
FROM renting
WHERE date_renting >= '2019-01-01';


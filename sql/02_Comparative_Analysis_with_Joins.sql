-- #########################################################
-- Comparative Analysis with Advanced Joins and Unions
-- #########################################################


-- =========================================================
-- SECTION 1: First customer account per country
-- =========================================================

SELECT 
  country, 
  MIN(date_account_start) AS first_account
FROM 
  customers
GROUP BY 
  country
ORDER BY 
  first_account ASC;


-- =========================================================
-- SECTION 2: Movie performance – average rating and rentals
-- =========================================================

SELECT 
  movie_id, 
  AVG(rating) AS avg_rating,
  COUNT(rating) AS number_ratings,
  COUNT(*) AS number_renting
FROM 
  renting
GROUP BY 
  movie_id
ORDER BY 
  avg_rating DESC;


-- =========================================================
-- SECTION 3: Customer behavior – active raters
-- =========================================================

SELECT 
  customer_id, 
  AVG(rating) AS avg_rating,
  COUNT(rating) AS number_ratings,
  COUNT(renting_id) AS number_renting
FROM 
  renting
GROUP BY 
  customer_id
HAVING 
  COUNT(renting_id) > 7
ORDER BY 
  avg_rating ASC;


-- =========================================================
-- SECTION 4: Belgium-specific rental behavior
-- =========================================================

-- Ratings for Belgian customers
SELECT 
  AVG(r.rating) AS avg_rating
FROM 
  renting AS r
LEFT JOIN 
  customers AS c ON r.customer_id = c.customer_id
WHERE 
  c.country = 'Belgium';

-- =========================================================
-- SECTION 5: Overall KPIs – revenue, rentals, active customers
-- =========================================================

-- All-time
SELECT 
  SUM(m.renting_price) AS total_revenue, 
  COUNT(r.renting_id) AS total_rentals, 
  COUNT(DISTINCT r.customer_id) AS active_customers
FROM 
  renting AS r
LEFT JOIN 
  movies AS m ON r.movie_id = m.movie_id;

-- For 2018
SELECT 
  SUM(m.renting_price) AS revenue_2018, 
  COUNT(*) AS rentals_2018, 
  COUNT(DISTINCT r.customer_id) AS active_customers_2018
FROM 
  renting AS r
LEFT JOIN 
  movies AS m ON r.movie_id = m.movie_id
WHERE 
  date_renting BETWEEN '2018-01-01' AND '2018-12-31';


-- =========================================================
-- SECTION 6: Country-level KPIs since 2019
-- =========================================================

SELECT 
  c.country,                   
  COUNT(r.renting_id) AS number_renting,
  AVG(r.rating) AS average_rating,
  SUM(m.renting_price) AS revenue     
FROM 
  renting AS r
LEFT JOIN 
  customers AS c ON c.customer_id = r.customer_id
LEFT JOIN 
  movies AS m ON m.movie_id = r.movie_id
WHERE 
  date_renting >= '2019-01-01'
GROUP BY 
  c.country;


-- =========================================================
-- SECTION 7: Actor-movie relationships
-- =========================================================

SELECT 
  m.title, 
  a.name AS actor_name
FROM 
  actsin AS ai
LEFT JOIN 
  movies AS m ON m.movie_id = ai.movie_id
LEFT JOIN 
  actors AS a ON a.actor_id = ai.actor_id;


-- =========================================================
-- SECTION 8: Movie-level revenue
-- =========================================================

SELECT 
  m.title,  
  SUM(m.renting_price) AS income_movie
FROM 
  renting AS r
LEFT JOIN 
  movies AS m ON r.movie_id = m.movie_id
GROUP BY 
  m.title
ORDER BY 
  income_movie DESC;


-- =========================================================
-- SECTION 9: US actor age range by gender
-- =========================================================

SELECT 
  gender,  
  MAX(year_of_birth) AS youngest_year,
  MIN(year_of_birth) AS oldest_year
FROM
  actors
WHERE 
  nationality = 'USA'
GROUP BY 
  gender;


-- =========================================================
-- SECTION 10: Favorite movies of 1970s-born customers
-- =========================================================

SELECT 
  m.title, 
  COUNT(*) AS rental_count,
  AVG(r.rating) AS avg_rating
FROM 
  renting AS r
LEFT JOIN 
  customers AS c ON c.customer_id = r.customer_id
LEFT JOIN 
  movies AS m ON m.movie_id = r.movie_id
WHERE 
  c.date_of_birth BETWEEN '1970-01-01' AND '1979-12-31'
GROUP BY 
  m.title
HAVING 
  COUNT(*) > 1
ORDER BY 
  avg_rating DESC;


-- =========================================================
-- SECTION 11: Most popular actors in Spain
-- =========================================================

SELECT 
  a.name AS actor_name,
  c.gender,
  COUNT(*) AS number_views, 
  AVG(r.rating) AS avg_rating
FROM 
  renting AS r
LEFT JOIN 
  customers AS c ON r.customer_id = c.customer_id
LEFT JOIN 
  actsin AS ai ON r.movie_id = ai.movie_id
LEFT JOIN 
  actors AS a ON ai.actor_id = a.actor_id
WHERE 
  c.country = 'Spain'
GROUP BY 
  a.name, c.gender
HAVING 
  AVG(r.rating) IS NOT NULL 
  AND COUNT(*) > 5
ORDER BY 
  avg_rating DESC, number_views DESC;

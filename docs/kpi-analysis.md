# KPI Analysis in SQL

## 🎯 Purpose

This document summarizes all key performance indicator (KPI) queries and performance analyses conducted in the "Data-Driven Decision Making in SQL" course. It outlines how SQL can be leveraged to track business success through revenue, customer activity, ratings, and churn indicators across dimensions like time, geography, and customer segments.

---

## 📊 Total KPI Analysis: 2018 and Onward

The following query calculates total revenue, number of rentals, and number of active customers for the entire platform since 2018:

```sql
SELECT
  SUM(m.renting_price) AS total_revenue,
  COUNT(r.renting_id) AS total_rentals,
  COUNT(DISTINCT r.customer_id) AS active_customers
FROM renting AS r
LEFT JOIN movies AS m ON r.movie_id = m.movie_id
WHERE date_renting >= '2018-01-01';
```

---

## 🌍 KPI Breakdown by Country

This query enables geographic performance comparisons by calculating total rentals, average rating, and revenue per country:

```sql
SELECT
  c.country,
  COUNT(r.renting_id) AS number_renting,
  AVG(r.rating) AS average_rating,
  SUM(m.renting_price) AS revenue
FROM renting AS r
LEFT JOIN customers AS c ON r.customer_id = c.customer_id
LEFT JOIN movies AS m ON r.movie_id = m.movie_id
WHERE date_renting >= '2019-01-01'
GROUP BY c.country;
```

---

## 🎥 KPI Breakdown by Genre

Track platform success across genres using this example:

```sql
SELECT
  m.genre,
  COUNT(r.renting_id) AS rentals,
  AVG(r.rating) AS avg_rating,
  SUM(m.renting_price) AS revenue
FROM renting AS r
LEFT JOIN movies AS m ON r.movie_id = m.movie_id
WHERE date_renting >= '2019-01-01'
GROUP BY m.genre;
```

---

## 👤 KPI Analysis by Customer Segment

Use SQL to target specific customer groups based on demographics or behavior. For example, this query identifies key movie preferences among customers born in the 1970s:

```sql
SELECT
  m.title,
  COUNT(*) AS rental_count,
  AVG(r.rating) AS avg_rating
FROM renting AS r
LEFT JOIN customers AS c ON c.customer_id = r.customer_id
LEFT JOIN movies AS m ON m.movie_id = r.movie_id
WHERE c.date_of_birth BETWEEN '1970-01-01' AND '1979-12-31'
GROUP BY m.title
HAVING COUNT(*) > 1
ORDER BY avg_rating DESC;
```

---

## 🧠 Functional Summary: SQL for Success Measurement

* **Revenue Tracking**: `SUM(renting_price)` gives total revenue per unit (genre, country, etc.).
* **Customer Engagement**: `COUNT(DISTINCT customer_id)` measures reach.
* **Churn Detection**: Segment by inactive or low-activity customers.
* **Rating Insights**: `AVG(rating)` reveals satisfaction and quality.
* **Granular Filters**: Time periods, customer groups, countries, genres.

---

## 📌 Key Business Insights

* Performance varies by **country** and **genre**.
* Targeting **highly rated dramas** or **frequent renters** increases ROI.
* **Churn-prone users** can be detected by activity gaps or low ratings.

---

## ✅ TL;DR

SQL enables precise and scalable KPI tracking across multiple business dimensions. From calculating total revenue to evaluating customer engagement by country or genre, these queries empower strategic decision-making rooted in data.

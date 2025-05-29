# Business Insight Queries in SQL

## 📊 Purpose

This document consolidates queries that generate actionable business insights using SQL. These queries are designed to support data-driven decision-making by uncovering customer preferences, behavioral segments, and performance patterns across various dimensions.

---

## 🎥 Audience-Focused Favorites

### Favorite Movies Among Customers Born in the 1970s

```sql
SELECT m.title,
       COUNT(*) AS number_views,
       AVG(r.rating) AS avg_rating
FROM renting AS r
LEFT JOIN customers AS c ON c.customer_id = r.customer_id
LEFT JOIN movies AS m ON m.movie_id = r.movie_id
WHERE c.date_of_birth BETWEEN '1970-01-01' AND '1979-12-31'
GROUP BY m.title
HAVING COUNT(*) > 1
ORDER BY avg_rating DESC;
```

**Insight**: Helps marketing teams highlight nostalgic or well-rated titles for Gen X users.

---

## 🌟 Actor Popularity by Country

### Popular Actors in Spain

```sql
SELECT a.name,  c.gender,
       COUNT(*) AS number_views,
       AVG(r.rating) AS avg_rating
FROM renting AS r
LEFT JOIN customers AS c ON r.customer_id = c.customer_id
LEFT JOIN actsin AS ai ON r.movie_id = ai.movie_id
LEFT JOIN actors AS a ON ai.actor_id = a.actor_id
WHERE c.country = 'Spain'
GROUP BY a.name, c.gender
HAVING AVG(r.rating) IS NOT NULL AND COUNT(*) > 5
ORDER BY avg_rating DESC, number_views DESC;
```

**Insight**: Identifies local audience preferences for potential regional promotions or casting strategies.

---

## 🛋️ Customer Segmentation by Behavior

### Less Active Customers for Re-engagement

```sql
SELECT *
FROM customers AS c
WHERE 5 > (
    SELECT COUNT(*)
    FROM renting AS r
    WHERE r.customer_id = c.customer_id
);
```

**Insight**: Targets low-engagement users for win-back campaigns.

### Customers Who Gave Low Ratings

```sql
SELECT *
FROM customers AS c
WHERE 4 > (
    SELECT MIN(rating)
    FROM renting AS r
    WHERE r.customer_id = c.customer_id
);
```

**Insight**: Flags potentially dissatisfied users for quality checks or support outreach.

---

## 📊 Integrated Insights Across Tables

### Revenue and Engagement per Country (Post-2019)

```sql
SELECT
    c.country,                   
    COUNT(r.renting_id) AS number_renting,
    AVG(r.rating) AS average_rating,
    SUM(m.renting_price) AS revenue
FROM renting AS r
LEFT JOIN customers AS c ON c.customer_id = r.customer_id
LEFT JOIN movies AS m ON m.movie_id = r.movie_id
WHERE date_renting >= '2019-01-01'
GROUP BY c.country;
```

**Insight**: Enables country-specific performance reviews to inform international strategy.

---

## 📈 Summary

These queries represent core pillars of business intelligence:

* Identifying high-performing content
* Understanding customer preferences
* Segmenting user bases for targeted strategies
* Measuring cross-dimensional KPIs

SQL enables stakeholders to move from raw data to refined, strategic insight with precision and speed.

# Set Operations in SQL

## 📋 Overview

SQL set operations allow you to combine the results of two or more SELECT statements. The primary operations are:

* `UNION`: Combines and removes duplicate records.
* `UNION ALL`: Combines all records including duplicates.
* `INTERSECT`: Returns only rows common to both queries.
* `EXCEPT`: Returns rows from the first query that aren't in the second.

These operations are particularly useful for segmentation, filtering, and comparative analytics.

---

## 🔍 Use Cases in Data-Driven Decision Making

### 1. Segmentation: Young Foreign Actors

```sql
SELECT name, nationality, year_of_birth
FROM actors
WHERE nationality <> 'USA'
INTERSECT
SELECT name, nationality, year_of_birth
FROM actors
WHERE year_of_birth > 1990;
```

**Purpose**: Identify young actors born after 1990 who are not from the USA.

### 2. Popular Dramas

```sql
SELECT movie_id
FROM movies
WHERE genre = 'Drama'
INTERSECT
SELECT movie_id
FROM renting
GROUP BY movie_id
HAVING AVG(rating) > 9;
```

**Purpose**: Surface high-quality drama films for targeted promotion.

---

## 📊 Best Practices & Pitfalls

### ✅ Advantages

* Easy to perform comparisons across datasets.
* Simplifies complex filtering logic.
* Can be used with nested or correlated subqueries.

### ⚠️ Pitfalls to Avoid

* Ensure same number and types of columns in both SELECT statements.
* Remember: `INTERSECT` and `EXCEPT` can be performance-intensive on large datasets.
* Aliasing and order may impact readability and maintainability.

---

## 🎬 MovieNow Case Summary

In the MovieNow analysis:

* **Set operations** helped segment **target groups** (e.g., young foreign talent).
* Combined filters were used to **find cross-qualifying criteria** (e.g., genre and performance).
* **Correlated queries** and **UNION/INTERSECT** logic improved decision relevance for both marketing and content curation.

---

## 📖 TL;DR

Set operations are powerful SQL tools for comparing and combining datasets. In data-driven decision-making, they enable precise segmentation, performance analysis, and refined targeting essential for business intelligence.

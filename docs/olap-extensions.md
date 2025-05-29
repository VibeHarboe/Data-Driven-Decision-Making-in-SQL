# OLAP Extensions in SQL

## 📋 Overview

OLAP (Online Analytical Processing) extensions in SQL enable advanced aggregations over multidimensional data. These include:

* `ROLLUP`: Creates subtotals that roll up from the most detailed level to a grand total.
* `CUBE`: Generates subtotals for all combinations of the grouping columns.
* `GROUPING SETS`: Allows explicit specification of multiple groupings in a single query.

These tools are essential for building pivot-style reports and high-level summaries for business intelligence.

---

## 🔍 Use Cases in Data-Driven Decision Making

### 1. Total Ratings by Genre and Country with ROLLUP

```sql
SELECT genre, country, COUNT(rating) AS rating_count
FROM movies m
JOIN renting r ON m.movie_id = r.movie_id
JOIN customers c ON r.customer_id = c.customer_id
GROUP BY ROLLUP (genre, country);
```

**Purpose**: Generates genre-country breakdowns, including genre and overall totals.

### 2. All Combinations with CUBE

```sql
SELECT genre, country, COUNT(rating) AS rating_count
FROM movies m
JOIN renting r ON m.movie_id = r.movie_id
JOIN customers c ON r.customer_id = c.customer_id
GROUP BY CUBE (genre, country);
```

**Purpose**: Returns every possible subtotal: by genre, by country, by both, and the grand total.

### 3. Custom Groupings with GROUPING SETS

```sql
SELECT genre, country, COUNT(rating) AS rating_count
FROM movies m
JOIN renting r ON m.movie_id = r.movie_id
JOIN customers c ON r.customer_id = c.customer_id
GROUP BY GROUPING SETS ((genre), (country));
```

**Purpose**: Computes separate subtotals by genre and by country only—not their combinations.

---

## 📊 Best Practices & Interpretation

### ✅ Advantages

* Simplifies multidimensional reporting.
* Eliminates the need for UNION-based aggregation.
* Reduces manual pivot table prep.

### ❌ Pitfalls to Avoid

* May return NULLs in grouped columns for subtotal rows.
* Can confuse results without clear understanding of GROUPING behavior.
* Not all databases support all OLAP extensions natively.

### GROUPING Function

```sql
SELECT
  genre,
  country,
  COUNT(rating) AS rating_count,
  GROUPING(genre) AS genre_grouped,
  GROUPING(country) AS country_grouped
...
```

Use `GROUPING()` to distinguish NULLs caused by aggregation from real NULL values.

---

## 🎥 MovieNow Case Summary

OLAP functions were used in MovieNow to:

* Create **pivot-like reports** by genre and customer country.
* Summarize **engagement levels** across content and regions.
* Identify **gaps and top-performing segments** to refine content and campaign strategies.

---

## 📖 TL;DR

OLAP extensions (`ROLLUP`, `CUBE`, `GROUPING SETS`) allow efficient, multidimensional analysis. In real-world analytics like MovieNow, they support pivot-style summaries and help inform content curation, regional targeting, and performance monitoring.

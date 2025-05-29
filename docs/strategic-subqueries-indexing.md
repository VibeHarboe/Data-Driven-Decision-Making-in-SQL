# 🧠 Strategic Subqueries and Indexing in SQL

Subqueries enable targeted filtering and comparisons based on grouped or derived data, while indexing supports efficient execution of those queries. This section explores subqueries used for segmentation, filtering, and KPI derivation, alongside considerations for query optimization.

## 🔁 Subqueries
Subqueries are nested queries that return intermediate results used by a surrounding (outer) query. They are essential in analytical workflows when the filtering condition depends on aggregate results or related datasets.

### ✳️ Syntax Examples
```sql
-- Subquery in WHERE clause
SELECT *
FROM movies
WHERE movie_id IN (
    SELECT movie_id
    FROM renting
    GROUP BY movie_id
    HAVING COUNT(*) > 5
);

-- Correlated subquery
SELECT *
FROM customers c
WHERE 5 > (
    SELECT COUNT(*)
    FROM renting r
    WHERE r.customer_id = c.customer_id
);

-- Subquery in SELECT clause
SELECT title,
       (SELECT AVG(rating)
        FROM renting r
        WHERE r.movie_id = m.movie_id) AS avg_rating
FROM movies m;
```

### 📍 Common Use Cases
- Identify frequent customers or popular movies
- Compare values to average or min/max values
- Filter based on dynamic thresholds
- Identify unmatched or underperforming segments

## 🧩 Correlated Subqueries
These subqueries depend on the outer query for their values and are executed once for each row. Useful for evaluating per-row context.

```sql
-- Find customers who rated fewer than 5 movies
SELECT *
FROM customers c
WHERE 5 > (
    SELECT COUNT(*)
    FROM renting r
    WHERE r.customer_id = c.customer_id
);
```

## ⚡ Indexing Considerations
To maintain performance when using subqueries:
- Ensure indexed columns are used in filtering and joining.
- Consider materializing subqueries with common table expressions (CTEs) if reused.
- Use `EXISTS` instead of `IN` for correlated subqueries when performance matters.

## 🚀 Strategic Impact
Strategic subqueries enable business-critical filtering for segments such as:
- Top performing products or customers
- High/low engagement cohorts
- Outliers in financial KPIs

Their flexibility makes them indispensable for decision-making based on data patterns not evident in flat filtering.

## 🧠 Tip
Use aggregate subqueries in combination with `HAVING`, `EXISTS`, or `JOINs` to balance readability and performance depending on the context of analysis.

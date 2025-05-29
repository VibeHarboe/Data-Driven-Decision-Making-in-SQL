# 📊 Data-Driven Decision Making in SQL

## 🔍 Overview
This guide provides an introduction to using SQL for data-driven business decisions. Drawing from the "MovieNow" case used throughout the course, we explore how SQL enables strategic and operational insight via real-time analysis of key performance indicators (KPIs), customer behavior, and content performance.

## 🎯 Learning Objectives
- Understand how SQL supports data-informed decisions
- Use filtering, aggregation, and joins to derive insights
- Apply queries to evaluate KPIs like revenue, engagement, and satisfaction
- Use subqueries and joins to segment customers and content

## 🧩 Key Concepts
| Concept | Description |
|--------|-------------|
| KPIs | Business metrics such as revenue, rental frequency, customer activity, and average ratings |
| Granularity | Analysis can be done per country, customer, movie, or actor |
| Filtering | Focus on specific timeframes, genres, customer segments, or thresholds |
| Aggregation | Summarize performance across dimensions (e.g., AVG, COUNT, SUM) |
| Joins | Combine customer, movie, and rental information |

## 🧠 Typical Use Cases
- **Strategic Insight:**
  - Evaluate most and least successful movies across time periods
  - Identify customer groups with high or low engagement
  - Track KPIs over time to assess business growth

- **Operational Decisions:**
  - Prioritize marketing for highly rated but under-watched movies
  - Segment customers for personalized outreach
  - Identify countries or genres that need improvement

## 📁 Data Tables Used
| Table | Description |
|-------|-------------|
| `movies` | Movie metadata: title, genre, renting_price, runtime |
| `customers` | Customer metadata: country, gender, birth year, start date |
| `renting` | Rental logs: movie_id, customer_id, date_renting, rating |
| `actors` | Actor profiles: name, nationality, gender, birth year |
| `actsin` | Mapping table: actor_id to movie_id |

## 🧾 Sample Query Patterns
```sql
-- KPI Report: Rentals, Revenue, Ratings per Country
SELECT 
  c.country,                    
  COUNT(r.renting_id) AS rentals,
  AVG(r.rating) AS avg_rating,
  SUM(m.renting_price) AS revenue
FROM renting AS r
LEFT JOIN customers AS c ON c.customer_id = r.customer_id
LEFT JOIN movies AS m ON m.movie_id = r.movie_id
WHERE r.date_renting >= '2019-01-01'
GROUP BY c.country;
```

## ✅ Summary
This module trains you to move from technical SQL syntax to meaningful business impact. Whether you're supporting marketing, strategy, or product teams, your SQL skills are core to transforming raw data into actionable decisions.

> Use SQL not just to answer questions — but to reveal the right questions to ask.

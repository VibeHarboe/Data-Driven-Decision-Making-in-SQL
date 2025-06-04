# Data Driven Decision Making in SQL
Advanced SQL project focused on data-driven decision making. Includes subqueries, window functions, OLAP, and predictive analysis using PostgreSQL.

# Data-Driven Decision Making in SQL 🚀

Welcome to the **Data-Driven Decision Making in SQL** project repository! 📈 This project showcases advanced SQL techniques and analytical strategies used to support data-informed decisions. Built on the DataCamp course curriculum, the repository presents real-world business scenarios and technical solutions with PostgreSQL.

## Project Overview 📄

This repository explores how SQL can be used to:

* Optimize business strategy and performance through data.
* Support operational and strategic decision-making with complex queries.
* Derive actionable insights using advanced SQL constructs.

## Repository Structure 📂

```
Data-Driven-Decision-Making-in-SQL/
├── LICENSE
├── README.md
├── certificate/
│   ├── Data-Driven-Decision-Making-Certificate.png
│   └── README.md
├── data/
│   ├── README.md
│   └── erdiagram.png (if available)
├── docs/
│   ├── business-scenarios-and-subqueries.md
│   ├── exists-union-intersect.md
│   ├── olap-queries.md
│   ├── window-functions-and-partitioning.md
│   ├── advanced-aggregation-and-grouping.md
│   ├── predictive-analytics-with-sql.md
│   └── README.md
├── sql/
│   ├── 01_Strategic_Subqueries_and_Indexing.sql
│   ├── 02_Advanced_Joins_and_Union.sql
│   ├── 03_OLAP_and_Window_Functions.sql
│   ├── 04_Predictive_Analytics_and_Campaigns.sql
│   └── README.md
└── visuals/
    ├── README.md
    └── charts-and-insights.png
```

## Key Concepts ✨

### 🔢 Strategic Subqueries & Filtering

* Subqueries for conditional logic.
* EXISTS for performance-focused filtering.
* Use of `IN`, `NOT IN`, and `HAVING` with GROUP BY.

### 🔀 Joins, Union & Intersect

* Multi-source data comparison using UNION and INTERSECT.
* Strategic filtering and segmentation across datasets.

### ⚖️ OLAP Queries & Window Functions

* Ranking customers or regions with `RANK()` and `ROW_NUMBER()`.
* Generating multidimensional views using `CUBE` and `ROLLUP`.

### 📊 Predictive Analytics & Campaign Logic

* Conditional logic to identify qualified customers.
* Segmenting purchase patterns over time.
* Forecasting behavior using `LEAD()` and `LAG()` functions.

## Real-World Examples 💡

* Identify profitable customer segments using EXISTS.
* Merge campaign participants across years using UNION.
* Find overlapping customers using INTERSECT.
* Rank customers by purchase value within regions using window functions.
* Forecast next likely purchase using LEAD().

## Certification 🎓

A certificate of completion from DataCamp is available in `/certificate`.

## Documentation 📖

Each major concept is documented in `/docs` to serve as a reference or training guide.

## Data & Visuals 📉

* If applicable, ER diagrams and example visualizations are in the `/data` and `/visuals` folders.

## License 📜

This repository is licensed under the MIT License.

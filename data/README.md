# 📂 Data Folder: MovieNow Dataset

## 📌 Purpose

This folder contains all source tables used throughout the SQL project *Data-Driven Decision Making in SQL*. The dataset simulates an online movie rental platform and serves as the foundation for all exploratory, analytical, and performance-driven queries.

## 🧱 Tables Defined

| Table       | Description                                           |
| ----------- | ----------------------------------------------------- |
| `movies`    | Metadata about available films: title, genre, price   |
| `actors`    | Actor profiles including nationality and birth year   |
| `actsin`    | Join table mapping actors to movies                   |
| `customers` | Customer profiles with demographic and signup data    |
| `renting`   | Rental transactions, including rating and rental date |

## 🔗 Source

All tables are created via SQL `CREATE TABLE` statements and loaded with real CSV data from DataCamp-hosted endpoints using the `COPY FROM PROGRAM 'curl ...'` method.

## 🗺️ Usage

This data supports:

* KPI aggregation (revenue, rentals, ratings)
* Customer behavior analysis
* Actor/movie segmentation
* Join-heavy queries across customer, rental, and movie data

## ✅ Ready to Query

All schema and data are ready for immediate use in PostgreSQL environments.

> ER diagram and relationships can be viewed under `visuals/erdiagram.png`

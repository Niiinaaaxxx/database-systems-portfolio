# database-systems-portfolio

A compact SQL & database systems portfolio featuring **MySQL querying**, **relational analytics**, and a **member-level data warehouse** with **Tableau** visualizations.

**Tech Stack:** MySQL · SQL (joins, aggregation, date logic, feature engineering) · Tableau

---

## Projects

### 01 — Flight SQL Analysis (`01-flight-sql-analysis`)
**Goal:** Practice core SQL querying patterns on a flight dataset.  
**Skills demonstrated:** filtering, sorting, aggregation, multi-table joins, basic derived fields.

**Files**
- `queries.sql` — SQL solutions / queries
- `writeup.docx` — short write-up and answers

---

### 02 — Insurance Claims SQL (`02-insurance-claims-sql`)
**Goal:** Analyze an insurance claims dataset with business-style questions (customer/claims summary, categorical breakdowns, and time-based calculations).  
**Skills demonstrated:** relational joins, group-level summaries, date parsing/differences, and query organization.

**Files**
- `sql/` — SQL scripts (database build and/or analysis queries)
- `writeup.docx` — short write-up and answers

---

### 03 — Country Club Member-Level Data Warehouse + Tableau (`03-country-club-data-warehouse`)
**Goal:** Build a **member-level feature table (Customer 360 / data mart)** from multiple transactional sources and generate insights via Tableau.  
**Skills demonstrated:** multi-table aggregation, `LEFT JOIN` + `COALESCE` handling, feature engineering (spend by category, recency), and visualization-driven recommendations.

**Files**
- `analysis_queries.sql` — warehouse/feature-table build + analysis queries
- `visualization.twb` — Tableau workbook
- `writeup.docx` — analysis summary + recommendations

---

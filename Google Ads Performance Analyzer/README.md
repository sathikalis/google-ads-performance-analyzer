# 🗂 Google Ads Performance Analyzer

> 📊 “How do ads perform over time? Where are we wasting spend?”

This project analyzes Google Ads performance to uncover inefficiencies, optimize budget allocation, and visualize key performance trends over time. It combines SQL-based analysis with Looker Studio dashboards for insightful reporting.

---

## 🛠 Skills Highlighted

- SQL  
- Data Cleaning  
- KPI Analysis (e.g., ROAS)  
- Tableau Reporting  

---

## 🧰 Tools Used

- **PostgreSQL** (or **BigQuery**)  
- **Google Ads Data** (API or CSV export)  
- **Tableau**  

---

# 🗂 Data Source

- 📥 **Raw data sourced from Kaggle:**  
  [Google Ads Campaign Dataset on Kaggle](https://www.kaggle.com/datasets/marceaxl82/shopping-mall-paid-search-campaign-dataset) 

---

## 📦 Deliverables

- ✅ Connect Google Ads data to a local PostgreSQL database or use exported CSVs  
- ✅ Clean and structure the following core tables:
  - `campaigns`
  - `ad_groups`
  - `impressions`
  - `spend`
  - `conversions`
- ✅ Write SQL queries to:
  - Compare Return on Ad Spend (ROAS) Month-over-Month  
    - Example: April 1–7 vs. March 1–7  
  - Identify and flag low-performing campaigns (below a defined ROAS threshold)
- ✅ Build an interactive dashboard in Looker Studio to visualize:
  - Spend vs. Conversions over time  
  - Campaign-level ROAS trends  
  - Alerts for underperforming segments

---

## 🧪 Sample Analysis Logic

```sql
-- ROAS calculation per campaign for a specific period
SELECT
  campaign_id,
  SUM(conversions * conversion_value) / NULLIF(SUM(spend), 0) AS roas
FROM campaign_performance
WHERE date BETWEEN '2025-04-01' AND '2025-04-07'
GROUP BY campaign_id;
```

```sql
-- Flag campaigns under ROAS threshold (e.g., ROAS < prev_roas)
SELECT
  campaign_id,
  roas,
  CASE 
    WHEN roas < prev_roas THEN 'Underperforming'
    ELSE 'OK'
  END AS performance_flag
FROM campaign_roas_summary;
```

---

## 📈 Outcome

By combining SQL insights with Tableau dashboards, this project enables marketing teams to:

- Evaluate campaign performance over time  
- Spot low-performing ads draining budget  
- Make data-driven decisions to improve ROAS  

---

## 📁 Folder Structure

```
📦 google-ads-performance-analyzer/
├── data/
│   └── shop_data.csv
├── sql/
│   └── roas_mom.sql
├── dashboard/
│   └── roas_mom.twb
└── README.md
```

---

## 🚀 Future Improvements

- Automate data ingestion from Google Ads API  
- Add anomaly detection using time-series methods  
- Schedule SQL jobs and alerting with CRON or dbt  

---

## 📬 Contact

Feel free to reach out if you have questions or want to collaborate!

---

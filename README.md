# 🛒 E-Commerce Customer & Sales Analysis
### UK Online Retail | 541K Transactions | 2010–2011

---

## 📌 Problem Statement
A UK-based online retail company needed to understand customer behavior, 
revenue trends, and identify customers at risk of churning — to make 
data-driven retention and growth decisions.

---

## 🎯 Key Business Insights

- 📈 **November 2011** was the peak revenue month — 84% higher than January
- 🇬🇧 **UK dominates** with 83% of total revenue — international expansion opportunity
- 👑 **950 VIP customers** generate avg £6,055 each — 13x more than lost customers  
- ⚠️ **667 At-Risk customers** need immediate retention action (avg £1,272 spend)
- 📌 **1,067 Lost customers** — win-back campaign can recover significant revenue
- 🛍️ Top product **"Paper Craft Little Birdie"** generated £168K alone

---

## 🛠️ Tools & Technologies

| Tool | Usage |
|------|-------|
| PostgreSQL | Data cleaning, RFM scoring, aggregation queries |
| Python (pandas, matplotlib, seaborn) | EDA, trend analysis, charts |
| Power BI | Interactive 2-page executive dashboard |
| Excel | Initial data exploration |

---

## 📊 Dashboard

### Page 1 — Sales Overview
![Page 1](https://github.com/Simrannegi02/ecommerce-sales-analysis/blob/main/E_commerce_dashboard.png)

### Page 2 — RFM Customer Segmentation  
![Page 2](https://github.com/Simrannegi02/ecommerce-sales-analysis/blob/main/rfm_analysis_Dashboard.png)

---

## 🗃️ Dataset
- **Source:** [Kaggle — UK E-Commerce Retail](https://www.kaggle.com/datasets/carrie1/ecommerce-data)
- **Raw Data:** 541,909 rows | 8 columns
- **Clean Data:** 397,636 rows (26.6% removed)

### Why rows were removed:

| Issue | Count |
|-------|-------|
| Null CustomerID | 135,080 |
| Cancellation invoices (C%) | 9,288 |
| Negative quantity (returns) | 10,624 |
| Zero/negative price | 2,521 |
| Unspecified country | 446 |
| Null description | 1,454 |

---

## 👥 RFM Customer Segmentation Results

| Segment | Customers | Avg Revenue |
|---------|-----------|-------------|
| 👑 VIP | 950 | £6,055 |
| 💚 Loyal | 983 | £1,545 |
| ⚠️ At Risk | 667 | £1,272 |
| 🔵 Potential | 355 | £471 |
| 💀 Lost | 1,067 | £469 |
| 🆕 New Customer | 312 | £391 |

---

## 💡 Business Recommendations

1. **VIP Loyalty Program** — Exclusive offers for 950 VIP customers to retain £6K+ revenue each
2. **At-Risk Campaign** — Immediate re-engagement emails to 667 at-risk customers
3. **International Expansion** — Netherlands & Germany show strong growth potential
4. **Seasonal Stocking** — Increase inventory from September for November peak

---

## 📁 Project Structure
ecommerce-sales-analysis/
├── README.md
├── sql/
│   └── ecommerce_analysis.sql
├── notebooks/
│   └── ecommerce_eda.ipynb
├── dashboard/
│   └── ecommerce_dashboard.pbix
└── assets/
├── page1_overview.png
└── page2_rfm.png
---

## 👩‍💻 Author
**Simran Negi** — Aspiring Data Analyst  
SQL • Python • Power BI • Excel  
[LinkedIn](www.linkedin.com/in/simran-negi-b20407275) 

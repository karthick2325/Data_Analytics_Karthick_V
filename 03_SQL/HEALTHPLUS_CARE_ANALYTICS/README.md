# HealthPlus Care Healthcare Analytics

## Overview
HealthPlus Care is a **SQL/MySQL healthcare analytics project** focused on healthcare service utilization, financial performance, member engagement, and member experience. The project uses cleaned and validated healthcare data to generate business-focused KPIs and insights.

## Objectives
- Analyze member and consultation activity
- Measure telemedicine and chronic care performance
- Analyze health package and corporate participation
- Evaluate laboratory, prescription, and insurance activity
- Measure billing, payments, and collection performance
- Analyze member feedback and workforce operations

## Technology Stack
- **Database:** MySQL
- **Language:** SQL
- **Data Source:** CSV


## Database
**Database:** `healthplus_care_db`

The project contains **17 tables** covering members, clinics, specialists, consultations, telemedicine, chronic care, packages, prescriptions, lab tests, claims, billing, payments, staff, corporates, and feedback.

## Dataset
| Area | Records |
|---|---:|
| Members | 2,500 |
| Consultations | 6,000 |
| Telemedicine Sessions | 2,200 |
| Chronic Care Programs | 900 |
| Package Subscriptions | 3,000 |
| Prescriptions | 5,000 |
| Lab Tests | 3,500 |
| Claims | 1,800 |
| Billing | 6,000 |
| Payments | 6,000 |
| Feedback | 2,500 |

## Key KPIs
- Total Members
- Total Consultations
- Consultation Completion Rate
- Telemedicine Completion Rate
- Active Chronic Care Programs
- Package Subscription Rate
- Total Claim Amount
- Total Billed Amount
- Net Collection Amount
- Collection Gap
- Average Feedback Rating
- Total Staff and Specialists

## Project Workflow
```text
CSV Data
   ↓
MySQL Database
   ↓
Data Cleaning
   ↓
Data Validation
   ↓
SQL Analysis
   ↓
KPI Queries
   ↓
Business Insights
```

## SQL Analysis
The project uses:
- Aggregations: `sum()`, `avg()`, `count()`, `group by`, `having`
- Joins: `inner join`, `left join`, `right join`
- CTEs
- Window Functions: `row_number()`, `rank()`, `lag()`, `lead()`

## Project Files
```text
sql/
├── 01.healthplus_care_table_Database_Setup.sql
├── 02.healthplus_care_Data_Cleaning.sql
├── 03.healthplus_care_Data_Validation.sql
├── 04.healthplus_care_Business_Analysis.sql
└── HealthPlus_Care_KPI_Queries.sql

data/
└── HealthPlus Care CSV datasets
```

## Financial Analysis
Billing and payment data are analyzed separately where required to avoid duplicate counting caused by one-to-many payment relationships.

## Outcome
The project converts healthcare data into **reliable KPIs, analytical insights, and dashboard-ready information** to support data-driven healthcare decisions.

**Project Type:** Academic / Data Analytics Project  
**Domain:** Healthcare Analytics  
**Database:** MySQL

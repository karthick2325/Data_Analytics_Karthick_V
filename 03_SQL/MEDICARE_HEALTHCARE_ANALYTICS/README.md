# 🏥 MediCare Healthcare Operations & Revenue Analytics

## Overview
MediCare is a **MySQL / SQL healthcare analytics project** focused on hospital operations, patient activity, healthcare service utilization, billing, and payment collection.

The project uses a relational database and SQL analysis to generate business-focused healthcare and financial insights.

## Objectives
- Analyze hospital and patient activity
- Measure department and doctor workload
- Analyze appointments and admissions
- Evaluate room and healthcare resource utilization
- Analyze treatment, laboratory, and pharmacy activity
- Analyze billing and payment performance
- Identify gaps between billed and collected revenue
- Generate SQL-based business insights

## Technology Stack
- **Database:** MySQL
- **Language:** SQL
- **Data Source:** Healthcare dataset
- **Analysis:** SQL

## Database

**Database:** `HospitalAnalyticsDB`

### Main Tables

**Hospital Structure**
- `hospitals`
- `departments`
- `rooms`
- `employees`

**Patient & Clinical**
- `patients`
- `doctors`
- `appointments`
- `admissions`
- `treatments`

**Healthcare Services**
- `laboratory`
- `pharmacy`
- `medicines`
- `insurance`

**Finance**
- `billing`
- `payments`

## Key Analysis Areas
- Hospital performance
- Department workload
- Doctor workload
- Patient activity
- Admission analysis
- Room utilization
- Treatment analysis
- Laboratory analysis
- Pharmacy analysis
- Billing and revenue
- Payment collection

## Key KPIs
- Patient Activity
- Appointment Volume
- Admission Volume
- Doctor Workload
- Treatment Activity
- Laboratory Volume and Cost
- Pharmacy Activity
- Total Billed Amount
- Total Collected Amount
- Collection Gap
- Payment Status and Method

## SQL Analysis
The project uses:

- `select`
- `where`
- `order by`
- `limit`
- `sum()`
- `avg()`
- `count()`
- `group by`
- `having`
- `inner join`
- `left join`
- `right join`
- ctes
- `row_number()`
- `rank()`
- `lag()`
- `lead()`

## Project Workflow
```text
Healthcare Dataset
       ↓
MySQL Database
       ↓
Data Cleaning & Validation
       ↓
SQL Business Analysis
       ↓
KPI Analysis
       ↓
Business Insights
```

## Financial Analysis
Billing and payment data are analyzed carefully to understand:

- Total billed revenue
- Payment collections
- Payment status
- Payment methods
- Collection gaps

The analysis avoids duplicate counting when billing and payment tables have one-to-many relationships.


## Outcome
The project converts healthcare operational and financial data into **SQL-driven KPIs, business insights, and dashboard-ready information** to support data-driven hospital management decisions.

**Project Type:** Academic / Data Analytics Project  
**Domain:** Healthcare Analytics  
**Database:** MySQL  
**Language:** SQL  

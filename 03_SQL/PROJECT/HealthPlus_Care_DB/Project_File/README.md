# HealthPlus Care Database

## Project Overview

HealthPlus Care Database is a SQL-based healthcare management and data cleaning project for HealthPlus Care Network Pvt. Ltd.

The database contains healthcare information related to clinics, specialists, members, corporate members, consultations, telemedicine sessions, chronic care programs, health packages, prescriptions, laboratory tests, insurance claims, staff, billing, payments and feedback.

The main purpose of this project is to organize healthcare data, identify data quality issues, clean the data using SQL queries, and prepare the dataset for further analysis.

## Database

Database Name:

healthplus_care_db

## Tables

- Clinics
- Specialists
- Members
- Corporates
- Corporate_Members
- Consultations
- Telemedicine_Sessions
- Chronic_Care_Programs
- Health_Packages
- Package_Subscriptions
- Prescriptions
- Lab_Tests
- Claims
- Staff
- Billing
- Payments
- Feedback

## Data Cleaning

The project performs SQL-based data cleaning operations including:

- Checking duplicate records
- Checking NULL values
- Checking empty values
- Removing unwanted spaces using TRIM()
- Converting blank values to NULL
- Standardizing gender values
- Checking invalid numeric values
- Checking invalid dates
- Checking invalid phone numbers
- Checking invalid email formats
- Checking invalid references between tables
- Checking invalid prices and charges
- Checking invalid ratings
- Checking invalid payment amounts
- Checking inconsistent categorical values
- Checking date ranges
- Checking duplicate records

## SQL Concepts Used

- CREATE DATABASE
- CREATE TABLE
- SELECT
- UPDATE
- WHERE
- IS NULL
- IS NOT NULL
- TRIM()
- NULLIF()
- CASE
- DISTINCT
- GROUP BY
- HAVING
- ORDER BY
- COUNT()
- LENGTH()
- LEFT JOIN
- LIKE
- LOWER()
- CURDATE()

## Data Quality Checks

The project checks different types of data quality problems such as:

- Duplicate IDs
- Missing values
- Blank values
- Leading and trailing spaces
- Invalid numeric values
- Invalid dates
- Invalid phone numbers
- Invalid email formats
- Inconsistent gender values
- Invalid payment amounts
- Invalid ratings
- Invalid table references
- Invalid package and subscription values

## Data Cleaning Approach

The data is first imported into the database and then cleaned using SQL queries.

Date-related columns are initially stored as VARCHAR to support the data import process. After data cleaning and validation, the date columns can be converted to appropriate DATE or DATETIME data types.

## Tools Used

- MySQL
- MySQL Workbench
- Microsoft Excel
- SQL

## Project Objective

The objective of this project is to clean and prepare HealthPlus Care healthcare data so that it can be used for reliable SQL analysis, reporting, data visualization and business insights.
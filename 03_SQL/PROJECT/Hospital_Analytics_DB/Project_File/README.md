# Hospital Analytics Database

## Project Overview

Hospital Analytics Database is a SQL-based healthcare data management and data cleaning project.

The project contains multiple hospital-related tables such as hospitals, departments, doctors, patients, rooms, appointments, admissions, treatments, insurance, medicines, pharmacy, laboratory, employees, billing and payments.

The main purpose of this project is to organize healthcare data, identify data quality issues, clean the data using SQL queries, and prepare the database for further analysis.

## Database

Database Name:

hospitalanalyticsdb

## Tables

- Hospitals
- Departments
- Doctors
- Patients
- Rooms
- Appointments
- Admissions
- Treatments
- Insurance
- Medicines
- Pharmacy
- Laboratory
- Employees
- Billing
- Payments

## Data Cleaning

The project performs SQL-based data cleaning operations including:

- Checking duplicate records
- Checking NULL values
- Checking empty values
- Removing unwanted spaces using TRIM()
- Standardizing inconsistent values
- Checking invalid numeric values
- Checking invalid dates
- Checking invalid phone numbers
- Checking invalid email formats
- Checking duplicate policy numbers
- Checking invalid foreign-key-like references
- Converting invalid negative values to NULL where required
- Checking categorical values using DISTINCT
- Checking invalid relationships between tables

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
- NOW()

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
- Inconsistent categorical values
- Invalid table references

## Tools Used

- MySQL
- MySQL Workbench
- Microsoft Excel
- SQL

## Project Objective

The objective of this project is to clean and prepare hospital healthcare data so that the dataset can be used for reliable SQL analysis, reporting and business insights.
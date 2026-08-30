use HospitalAnalyticsDB;


-- 01. how many hospitals are there?

select count(*) as total_hospitals from hospitals;


-- 02. how many departments are there?

select count(*) as total_departments from departments;


-- 03. how many doctors are there?

select count(*) as total_doctors from doctors;


-- 04. how many patients are there?

select count(*) as total_patients from patients;


-- 05. how many appointments are there?

select count(*) as total_appointments from appointments;


-- 06. how many admissions are there?

select count(*) as total_admissions from admissions;


-- 07. what is the total revenue?

select sum(total_amount) as total_revenue
from billing;


-- 08. what is the average bill amount?

select avg(total_amount) as average_bill_amount
from billing;


-- 09. what is the highest bill amount?

select max(total_amount) as highest_bill_amount
from billing;


-- 10. what is the lowest bill amount?

select min(total_amount) as lowest_bill_amount
from billing;


-- 11. how many patients are there in each gender?

select gender,count(*) as total_patients
from patients
group by gender;


-- 12. how many appointments are there for each status?

select status,count(*) as total_appointments
from appointments
group by status;


-- 13. how many doctors are there in each specialization?

select specialization,count(*) as total_doctors
from doctors
group by specialization;


-- 14. how many doctors are there in each gender?

select gender,count(*) as total_doctors
from doctors
group by gender;


-- 15. what is the average consultation fee?

select avg(consultation_fee) as average_consultation_fee
from doctors;


-- 16. what is the highest consultation fee?

select max(consultation_fee) as highest_consultation_fee
from doctors;


-- 17. what is the total payment amount?

select sum(payment_amount) as total_payment_amount
from payments;


-- 18. how many payments are there for each payment mode?

select payment_mode,count(*) as total_payments
from payments
group by payment_mode;


-- 19. how many payments are there for each payment status?

select payment_status,count(*) as total_payments
from payments
group by payment_status;


-- 20. how many admissions are there for each admission type?

select admission_type,count(*) as total_admissions
from admissions
group by admission_type;


-- 21. how many admissions are there for each admission status?

select admission_status,count(*) as total_admissions
from admissions
group by admission_status;


-- 22. what is the total treatment cost?

select sum(treatment_cost) as total_treatment_cost
from treatments;


-- 23. how many laboratory tests are there for each test status?

select test_status,count(*) as total_tests
from laboratory
group by test_status;


-- 24. what is the total laboratory test revenue?

select sum(test_cost) as total_lab_revenue
from laboratory;


-- 25. which specialization has the most doctors?

select specialization,count(*) as total_doctors
from doctors
group by specialization
order by total_doctors desc limit 1;
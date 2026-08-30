use healthplus_care_db;


-- 01. how many members are there?

select count(*) as total_members from members;

-- 02. how many clinics are there?

select count(*) as total_clinics from clinics;

-- 03. how many specialists are there?

select count(*) as total_specialists from specialists;


-- 04. how many consultations are there?

select count(*) as total_consultations from consultations;


-- 05. what is the total revenue?

select sum(total_amount) as total_revenue from billing;


-- 06. what is the average bill amount?

select avg(total_amount) as average_bill_amount from billing;


-- 07. what is the highest bill amount?

select max(total_amount) as highest_bill_amount from billing;


-- 08. what is the lowest bill amount?

select min(total_amount) as lowest_bill_amount from billing;


-- 09. how many members are there in each membership type?

select membership_type,count(*) as total_members
from members
group by membership_type;


-- 10. how many consultations are there for each status?

select status,count(*) as total_consultations
from consultations
group by status;


-- 11. how many consultations are there for each consultation mode?

select consultation_mode,count(*) as total_consultations
from consultations
group by consultation_mode;


-- 12. how many specialists are there in each specialization?

select specialization,count(*) as total_specialists
from specialists
group by specialization;


-- 13. what is the average consultation fee?

select avg(consultation_fee) as average_consultation_fee
from specialists;


-- 14. what is the highest consultation fee?

select max(consultation_fee) as highest_consultation_fee
from specialists;


-- 15. what is the total amount of payments?

select sum(payment_amount) as total_payment_amount
from payments;


-- 16. how many payments are there for each payment mode?

select payment_mode,count(*) as total_payments
from payments
group by payment_mode;


-- 17. how many payments are there for each payment status?

select payment_status,count(*) as total_payments
from payments
group by payment_status;


-- 18. how many claims are there for each claim status?

select claim_status,count(*) as total_claims
from claims
group by claim_status;


-- 19. what is the total claim amount?

select sum(claim_amount) as total_claim_amount
from claims;


-- 20. how many subscriptions are there for each health package?

select package_id,count(*) as total_subscriptions
from package_subscriptions
group by package_id
order by total_subscriptions desc;


-- 21. what is the average rating?

select avg(rating) as average_rating from feedback;

-- 22. how many feedback records are there for each rating?

select rating,count(*) as total_feedback
from feedback
group by rating
order by rating desc;


-- 23. how many lab tests are there for each test status?

select test_status,count(*) as total_tests
from lab_tests
group by test_status;


-- 24. what is the total lab test revenue?

select sum(test_cost) as total_lab_revenue from lab_tests;


-- 25. which specialization has the most specialists?

select specialization,count(*) as total_specialists
from specialists
group by specialization
order by total_specialists desc limit 1;
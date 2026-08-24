use healthplus_care_db;


-- CLINICS TABLE DATA CLEANING

select * from clinics;

select clinic_id,count(*) as count
from clinics
group by clinic_id
having count(*) > 1;

select *
from clinics
where clinic_name is null
or clinic_type is null
or city is null
or state is null
or established_year is null
or contact_number is null;

select *
from clinics
where trim(clinic_name) = ''
or trim(clinic_type) = ''
or trim(city) = ''
or trim(state) = ''
or trim(contact_number) = '';

select *
from clinics
where clinic_name <> trim(clinic_name)
or clinic_type <> trim(clinic_type)
or city <> trim(city)
or state <> trim(state)
or contact_number <> trim(contact_number);

select distinct clinic_type,city,state
from clinics;

select established_year
from clinics
where established_year < 0
or established_year is null;

select contact_number
from clinics
where length(contact_number) > 10
or length(contact_number) < 10;


-- SPECIALISTS TABLE DATA CLEANING

select * from specialists;

set sql_safe_updates = 0;

update specialists
set
first_name = nullif(trim(first_name),''),
last_name = nullif(trim(last_name),''),
gender = nullif(trim(gender),''),
specialization = nullif(trim(specialization),''),
clinic_id = nullif(trim(clinic_id),''),
qualification = nullif(trim(qualification),''),
experience_years = nullif(trim(experience_years),''),
consultation_fee = nullif(trim(consultation_fee),'');

select specialist_id,count(*) as count
from specialists
group by specialist_id
having count(*) > 1;

select first_name,last_name,gender,specialization,qualification
from specialists
where first_name <> trim(first_name)
or last_name <> trim(last_name)
or gender <> trim(gender)
or specialization <> trim(specialization)
or qualification <> trim(qualification);

select distinct gender
from specialists
order by gender;

update specialists
set gender = case
when lower(trim(gender)) = 'f' then 'Female'
when lower(trim(gender)) = 'female' then 'Female'
when lower(trim(gender)) = 'm' then 'Male'
when lower(trim(gender)) = 'male' then 'Male'
else gender
end
where gender is not null;

select distinct specialization
from specialists
order by specialization;

select lower(specialization),count(distinct specialization)
from specialists
group by lower(specialization)
having count(distinct specialization) > 1;

select specialist_id,experience_years
from specialists
where experience_years < 0
or experience_years is null;

select specialist_id,first_name,consultation_fee
from specialists
where consultation_fee < 0
or consultation_fee is null;


-- MEMBERS TABLE DATA CLEANING

select * from members;

update members
set
first_name = nullif(trim(first_name),''),
last_name = nullif(trim(last_name),''),
gender = nullif(trim(gender),''),
date_of_birth = nullif(trim(date_of_birth),''),
age = nullif(trim(age),''),
city = nullif(trim(city),''),
membership_type = nullif(trim(membership_type),''),
registration_date = nullif(trim(registration_date),''),
phone_number = nullif(trim(phone_number),''),
email = nullif(trim(email),'');

select member_id,count(*)
from members
group by member_id
having count(*) > 1;

select member_id,first_name,last_name,gender,city,phone_number,email
from members
where first_name <> trim(first_name)
or last_name <> trim(last_name)
or gender <> trim(gender)
or city <> trim(city)
or membership_type <> trim(membership_type)
or phone_number <> trim(phone_number)
or email <> trim(email);

select distinct gender
from members;

update members
set gender = case
when lower(trim(gender)) = 'm' then 'Male'
when lower(trim(gender)) = 'f' then 'Female'
when lower(trim(gender)) = 'male' then 'Male'
when lower(trim(gender)) = 'female' then 'Female'
else gender
end
where gender is not null;

select date_of_birth
from members
where date_of_birth > curdate()
or date_of_birth is null;

select age
from members
where age < 0
or age > 100
or age is null;

select distinct city
from members
order by city;

select length(phone_number)
from members
where length(phone_number) > 10
or length(phone_number) < 10
or length(phone_number) is null;

select email
from members
where email is not null
and (email not like '%@%' or email not like '%.%');

select email
from members
where email is null;

update members
set email = 'Missing Mail'
where email is null;

select distinct membership_type
from members
order by membership_type;

select registration_date
from members
where registration_date > curdate()
or registration_date is null;


-- CORPORATES TABLE DATA CLEANING

select * from corporates;

update corporates
set
company_name = nullif(trim(company_name),''),
industry = nullif(trim(industry),''),
city = nullif(trim(city),''),
contract_start_date = nullif(trim(contract_start_date),''),
contract_end_date = nullif(trim(contract_end_date),''),
employee_count = nullif(trim(employee_count),'');

select corporate_id,count(*) as count
from corporates
group by corporate_id
having count(*) > 1;

select corporate_id,company_name,industry,city
from corporates
where company_name <> trim(company_name)
or industry <> trim(industry)
or city <> trim(city);

select employee_count
from corporates
where employee_count < 0
or employee_count is null;

select corporate_id,contract_start_date,contract_end_date
from corporates
where contract_start_date is null
or contract_end_date is null
or contract_end_date < contract_start_date;

select distinct industry
from corporates
order by industry;

select distinct city
from corporates
order by city;


-- CORPORATE MEMBERS TABLE DATA CLEANING

select * from corporate_members;

update corporate_members
set
corporate_id = nullif(trim(corporate_id),''),
member_id = nullif(trim(member_id),''),
designation = nullif(trim(designation),''),
enrollment_date = nullif(trim(enrollment_date),'');

select corporate_member_id,count(*) as count
from corporate_members
group by corporate_member_id
having count(*) > 1;

select corporate_member_id,corporate_id,member_id,designation
from corporate_members
where corporate_id <> trim(corporate_id)
or member_id <> trim(member_id)
or designation <> trim(designation);

select cm.corporate_member_id,cm.corporate_id
from corporate_members cm
left join corporates c on cm.corporate_id = c.corporate_id
where cm.corporate_id is not null
and c.corporate_id is null;

select cm.corporate_member_id,cm.member_id
from corporate_members cm
left join members m on cm.member_id = m.member_id
where cm.member_id is not null
and m.member_id is null;

select corporate_member_id,enrollment_date
from corporate_members
where enrollment_date is null
or enrollment_date > curdate();

select distinct designation
from corporate_members
order by designation;


-- CONSULTATIONS TABLE DATA CLEANING

select * from consultations;

update consultations
set
member_id = nullif(trim(member_id),''),
specialist_id = nullif(trim(specialist_id),''),
clinic_id = nullif(trim(clinic_id),''),
consultation_date = nullif(trim(consultation_date),''),
consultation_mode = nullif(trim(consultation_mode),''),
status = nullif(trim(status),''),
reason_for_visit = nullif(trim(reason_for_visit),'');

select consultation_id,count(*) as count
from consultations
group by consultation_id
having count(*) > 1;

select consultation_id,member_id,specialist_id,clinic_id,consultation_mode,status,reason_for_visit
from consultations
where member_id <> trim(member_id)
or specialist_id <> trim(specialist_id)
or clinic_id <> trim(clinic_id)
or consultation_mode <> trim(consultation_mode)
or status <> trim(status)
or reason_for_visit <> trim(reason_for_visit);

select c.consultation_id,c.member_id
from consultations c
left join members m on c.member_id = m.member_id
where c.member_id is not null
and m.member_id is null;

select c.consultation_id,c.specialist_id
from consultations c
left join specialists s on c.specialist_id = s.specialist_id
where c.specialist_id is not null
and s.specialist_id is null;

select c.consultation_id,c.clinic_id
from consultations c
left join clinics cl on c.clinic_id = cl.clinic_id
where c.clinic_id is not null
and cl.clinic_id is null;

select consultation_id,consultation_date
from consultations
where consultation_date > curdate()
or consultation_date is null;

select distinct consultation_mode
from consultations
order by consultation_mode;

select distinct status
from consultations
order by status;

select distinct reason_for_visit
from consultations
order by reason_for_visit;


-- TELEMEDICINE SESSIONS TABLE DATA CLEANING

select * from telemedicine_sessions;

update telemedicine_sessions
set
consultation_id = nullif(trim(consultation_id),''),
session_start_time = nullif(trim(session_start_time),''),
session_end_time = nullif(trim(session_end_time),''),
platform = nullif(trim(platform),''),
connection_quality = nullif(trim(connection_quality),''),
session_status = nullif(trim(session_status),'');

select session_id,count(*) as count
from telemedicine_sessions
group by session_id
having count(*) > 1;

select session_id,consultation_id,platform,connection_quality,session_status
from telemedicine_sessions
where consultation_id <> trim(consultation_id)
or platform <> trim(platform)
or connection_quality <> trim(connection_quality)
or session_status <> trim(session_status);

select t.session_id,t.consultation_id
from telemedicine_sessions t
left join consultations c on t.consultation_id = c.consultation_id
where t.consultation_id is not null
and c.consultation_id is null;

select session_id,session_start_time,session_end_time
from telemedicine_sessions
where session_start_time is null
or session_end_time is null;

select distinct platform
from telemedicine_sessions
order by platform;

select distinct connection_quality
from telemedicine_sessions
order by connection_quality;

select distinct session_status
from telemedicine_sessions
order by session_status;


-- CHRONIC CARE PROGRAMS TABLE DATA CLEANING

select * from chronic_care_programs;

update chronic_care_programs
set
member_id = nullif(trim(member_id),''),
specialist_id = nullif(trim(specialist_id),''),
condition_name = nullif(trim(condition_name),''),
enrollment_date = nullif(trim(enrollment_date),''),
program_status = nullif(trim(program_status),''),
next_review_date = nullif(trim(next_review_date),'');

select program_id,count(*) as count
from chronic_care_programs
group by program_id
having count(*) > 1;

select program_id,member_id,specialist_id,condition_name,program_status
from chronic_care_programs
where member_id <> trim(member_id)
or specialist_id <> trim(specialist_id)
or condition_name <> trim(condition_name)
or program_status <> trim(program_status);

select c.program_id,c.member_id
from chronic_care_programs c
left join members m on c.member_id = m.member_id
where c.member_id is not null
and m.member_id is null;

select c.program_id,c.specialist_id
from chronic_care_programs c
left join specialists s on c.specialist_id = s.specialist_id
where c.specialist_id is not null
and s.specialist_id is null;

select program_id,enrollment_date,next_review_date
from chronic_care_programs
where enrollment_date is null
or next_review_date is null;

select distinct condition_name
from chronic_care_programs
order by condition_name;

select distinct program_status
from chronic_care_programs
order by program_status;


-- HEALTH PACKAGES TABLE DATA CLEANING

select * from health_packages;

update health_packages
set
package_name = nullif(trim(package_name),''),
package_type = nullif(trim(package_type),''),
price = nullif(trim(price),''),
validity_days = nullif(trim(validity_days),''),
tests_included = nullif(trim(tests_included),'');

select package_id,count(*) as count
from health_packages
group by package_id
having count(*) > 1;

select package_id,package_name,package_type
from health_packages
where package_name <> trim(package_name)
or package_type <> trim(package_type);

select package_id,price
from health_packages
where price < 0
or price is null;

select package_id,validity_days
from health_packages
where validity_days < 0
or validity_days is null;

select package_id,tests_included
from health_packages
where tests_included < 0
or tests_included is null;

select distinct package_type
from health_packages
order by package_type;


-- PACKAGE SUBSCRIPTIONS TABLE DATA CLEANING

select * from package_subscriptions;

update package_subscriptions
set
member_id = nullif(trim(member_id),''),
package_id = nullif(trim(package_id),''),
subscription_date = nullif(trim(subscription_date),''),
expiry_date = nullif(trim(expiry_date),''),
payment_status = nullif(trim(payment_status),'');

select subscription_id,count(*) as count
from package_subscriptions
group by subscription_id
having count(*) > 1;

select subscription_id,member_id,package_id,payment_status
from package_subscriptions
where member_id <> trim(member_id)
or package_id <> trim(package_id)
or payment_status <> trim(payment_status);

select ps.subscription_id,ps.member_id
from package_subscriptions ps
left join members m on ps.member_id = m.member_id
where ps.member_id is not null
and m.member_id is null;

select ps.subscription_id,ps.package_id
from package_subscriptions ps
left join health_packages hp on ps.package_id = hp.package_id
where ps.package_id is not null
and hp.package_id is null;

select subscription_id,subscription_date,expiry_date
from package_subscriptions
where subscription_date is null
or expiry_date is null
or expiry_date < subscription_date;

select distinct payment_status
from package_subscriptions
order by payment_status;


-- PRESCRIPTIONS TABLE DATA CLEANING

select * from prescriptions;

update prescriptions
set
consultation_id = nullif(trim(consultation_id),''),
member_id = nullif(trim(member_id),''),
specialist_id = nullif(trim(specialist_id),''),
medicine_name = nullif(trim(medicine_name),''),
dosage = nullif(trim(dosage),''),
duration_days = nullif(trim(duration_days),''),
prescription_date = nullif(trim(prescription_date),'');

select prescription_id,count(*) as count
from prescriptions
group by prescription_id
having count(*) > 1;

select prescription_id,consultation_id,member_id,specialist_id,medicine_name,dosage
from prescriptions
where consultation_id <> trim(consultation_id)
or member_id <> trim(member_id)
or specialist_id <> trim(specialist_id)
or medicine_name <> trim(medicine_name)
or dosage <> trim(dosage);

select p.prescription_id,p.consultation_id
from prescriptions p
left join consultations c on p.consultation_id = c.consultation_id
where p.consultation_id is not null
and c.consultation_id is null;

select p.prescription_id,p.member_id
from prescriptions p
left join members m on p.member_id = m.member_id
where p.member_id is not null
and m.member_id is null;

select p.prescription_id,p.specialist_id
from prescriptions p
left join specialists s on p.specialist_id = s.specialist_id
where p.specialist_id is not null
and s.specialist_id is null;

select prescription_id,duration_days
from prescriptions
where duration_days <= 0
or duration_days is null;

select prescription_id,prescription_date
from prescriptions
where prescription_date is null
or prescription_date > curdate();

select distinct dosage
from prescriptions
order by dosage;

select distinct medicine_name
from prescriptions
order by medicine_name;


-- LAB TESTS TABLE DATA CLEANING

select * from lab_tests;

update lab_tests
set
member_id = nullif(trim(member_id),''),
clinic_id = nullif(trim(clinic_id),''),
test_name = nullif(trim(test_name),''),
test_date = nullif(trim(test_date),''),
test_result = nullif(trim(test_result),''),
test_cost = nullif(trim(test_cost),''),
test_status = nullif(trim(test_status),'');

select lab_test_id,count(*) as count
from lab_tests
group by lab_test_id
having count(*) > 1;

select lab_test_id,member_id,clinic_id,test_name,test_result,test_status
from lab_tests
where member_id <> trim(member_id)
or clinic_id <> trim(clinic_id)
or test_name <> trim(test_name)
or test_result <> trim(test_result)
or test_status <> trim(test_status);

select l.lab_test_id,l.member_id
from lab_tests l
left join members m on l.member_id = m.member_id
where l.member_id is not null
and m.member_id is null;

select l.lab_test_id,l.clinic_id
from lab_tests l
left join clinics c on l.clinic_id = c.clinic_id
where l.clinic_id is not null
and c.clinic_id is null;

select lab_test_id,test_date
from lab_tests
where test_date is null
or test_date > curdate();

select lab_test_id,test_name,test_cost
from lab_tests
where test_cost < 0
or test_cost is null;

select distinct test_name
from lab_tests
order by test_name;

select distinct test_result
from lab_tests
order by test_result;

select distinct test_status
from lab_tests
order by test_status;


-- CLAIMS TABLE DATA CLEANING

select * from claims;

update claims
set
member_id = nullif(trim(member_id),''),
consultation_id = nullif(trim(consultation_id),''),
claim_amount = nullif(trim(claim_amount),''),
claim_date = nullif(trim(claim_date),''),
claim_status = nullif(trim(claim_status),''),
insurance_provider = nullif(trim(insurance_provider),'');

select claim_id,count(*) as count
from claims
group by claim_id
having count(*) > 1;

select claim_id,member_id,consultation_id,claim_status,insurance_provider
from claims
where member_id <> trim(member_id)
or consultation_id <> trim(consultation_id)
or claim_status <> trim(claim_status)
or insurance_provider <> trim(insurance_provider);

select c.claim_id,c.member_id
from claims c
left join members m on c.member_id = m.member_id
where c.member_id is not null
and m.member_id is null;

select c.claim_id,c.consultation_id
from claims c
left join consultations co on c.consultation_id = co.consultation_id
where c.consultation_id is not null
and co.consultation_id is null;

select claim_id,claim_amount
from claims
where claim_amount < 0
or claim_amount is null;

select claim_id,claim_date
from claims
where claim_date is null
or claim_date > curdate();

select distinct claim_status
from claims
order by claim_status;

select distinct insurance_provider
from claims
order by insurance_provider;


-- STAFF TABLE DATA CLEANING

select * from staff;

update staff
set
clinic_id = nullif(trim(clinic_id),''),
first_name = nullif(trim(first_name),''),
last_name = nullif(trim(last_name),''),
designation = nullif(trim(designation),''),
employment_type = nullif(trim(employment_type),''),
salary = nullif(trim(salary),''),
joining_date = nullif(trim(joining_date),'');

select staff_id,count(*) as count
from staff
group by staff_id
having count(*) > 1;

select s.staff_id,s.clinic_id
from staff s
left join clinics c on s.clinic_id = c.clinic_id
where s.clinic_id is not null
and c.clinic_id is null;

select distinct designation
from staff
order by designation;

select distinct employment_type
from staff
order by employment_type;

select staff_id,first_name,salary
from staff
where salary < 0
or salary is null;

select staff_id,first_name,joining_date
from staff
where joining_date is null
or joining_date > curdate();


-- BILLING TABLE DATA CLEANING

select * from billing;

update billing
set
member_id = nullif(trim(member_id),''),
consultation_id = nullif(trim(consultation_id),''),
bill_date = nullif(trim(bill_date),''),
consultation_charges = nullif(trim(consultation_charges),''),
lab_charges = nullif(trim(lab_charges),''),
medicine_charges = nullif(trim(medicine_charges),''),
total_amount = nullif(trim(total_amount),''),
bill_status = nullif(trim(bill_status),'');

select bill_id,count(*) as count
from billing
group by bill_id
having count(*) > 1;

select b.bill_id,b.member_id,b.consultation_id
from billing b
left join members m on b.member_id = m.member_id
where b.member_id is not null
and m.member_id is null;

select b.bill_id,b.member_id,b.consultation_id
from billing b
left join consultations c on b.consultation_id = c.consultation_id
where b.consultation_id is not null
and c.consultation_id is null;

select bill_id,consultation_charges,lab_charges,medicine_charges
from billing
where consultation_charges < 0
or lab_charges < 0
or medicine_charges < 0;

select bill_id,total_amount
from billing
where total_amount < 0;

update billing
set total_amount = null
where total_amount < 0;

select bill_id,member_id,bill_date
from billing
where bill_date is null
or bill_date > curdate();

select distinct bill_status
from billing
order by bill_status;


-- PAYMENTS TABLE DATA CLEANING

select * from payments;

update payments
set
bill_id = nullif(trim(bill_id),''),
member_id = nullif(trim(member_id),''),
payment_date = nullif(trim(payment_date),''),
payment_amount = nullif(trim(payment_amount),''),
payment_mode = nullif(trim(payment_mode),''),
payment_status = nullif(trim(payment_status),'');

select payment_id,count(*) as count
from payments
group by payment_id
having count(*) > 1;

select p.payment_id,p.bill_id,p.member_id,p.payment_amount
from payments p
left join billing b on p.bill_id = b.bill_id
where p.bill_id is not null
and b.bill_id is null;

select p.payment_id,p.bill_id,p.member_id,p.payment_amount
from payments p
left join members m on p.member_id = m.member_id
where p.member_id is not null
and m.member_id is null;

select payment_id,bill_id,member_id,payment_amount
from payments
where payment_amount < 0
or payment_amount is null;

update payments
set payment_amount = null
where payment_amount < 0;

select payment_id,bill_id,member_id,payment_date
from payments
where payment_date is null
or payment_date > curdate();

select distinct payment_mode
from payments
order by payment_mode;

select distinct payment_status
from payments
order by payment_status;


-- FEEDBACK TABLE DATA CLEANING

select * from feedback;

update feedback
set
member_id = nullif(trim(member_id),''),
consultation_id = nullif(trim(consultation_id),''),
rating = nullif(trim(rating),''),
feedback_text = nullif(trim(feedback_text),''),
feedback_date = nullif(trim(feedback_date),'');

select feedback_id,count(*) as count
from feedback
group by feedback_id
having count(*) > 1;

select feedback_id,member_id,consultation_id,rating,feedback_text
from feedback
where member_id <> trim(member_id)
or consultation_id <> trim(consultation_id)
or feedback_text <> trim(feedback_text);

select f.feedback_id,f.member_id
from feedback f
left join members m on f.member_id = m.member_id
where f.member_id is not null
and m.member_id is null;

select f.feedback_id,f.consultation_id
from feedback f
left join consultations c on f.consultation_id = c.consultation_id
where f.consultation_id is not null
and c.consultation_id is null;

select feedback_id,rating
from feedback
where rating < 1
or rating > 5
or rating is null;

select feedback_id,feedback_date
from feedback
where feedback_date is null
or feedback_date > curdate();

select distinct rating
from feedback
order by rating;
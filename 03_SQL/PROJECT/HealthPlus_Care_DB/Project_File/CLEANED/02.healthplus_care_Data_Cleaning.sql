use healthplus_care_db;


-- specialists table data cleaning

update specialists
set
first_name = nullif(trim(first_name),''),
last_name = nullif(trim(last_name),''),
gender = nullif(trim(gender),''),
specialization = nullif(trim(specialization),''),
clinic_id = nullif(trim(clinic_id),''),
qualification = nullif(trim(qualification),''),
experience_years = nullif(experience_years,''),
consultation_fee = nullif(consultation_fee,'')
where specialist_id is not null;


update specialists
set gender = case
when lower(trim(gender)) in ('m','male') then 'Male'
when lower(trim(gender)) in ('f','female') then 'Female'
else gender
end
where gender is not null;


update specialists
set specialization = case
when lower(trim(specialization)) in ('cardiology','cardiologist') then 'Cardiology'
when lower(trim(specialization)) in ('neurology','neurologist') then 'Neurology'
when lower(trim(specialization)) in ('orthopedics','orthopedic') then 'Orthopedics'
when lower(trim(specialization)) in ('dermatology','dermatologist') then 'Dermatology'
else trim(specialization)
end
where specialization is not null;


update specialists
set experience_years = null
where experience_years < 0;


update specialists
set consultation_fee = null
where consultation_fee < 0;



-- members table data cleaning

update members
set
first_name = nullif(trim(first_name),''),
last_name = nullif(trim(last_name),''),
gender = nullif(trim(gender),''),
date_of_birth = nullif(trim(date_of_birth),''),
city = nullif(trim(city),''),
membership_type = nullif(trim(membership_type),''),
registration_date = nullif(trim(registration_date),''),
phone_number = nullif(trim(phone_number),''),
email = nullif(trim(email),'')
where member_id is not null;


update members
set gender = case
when lower(trim(gender)) in ('m','male') then 'Male'
when lower(trim(gender)) in ('f','female') then 'Female'
else gender
end
where gender is not null;


update members
set membership_type = case
when lower(trim(membership_type)) in ('basic','basic plan') then 'Basic'
when lower(trim(membership_type)) in ('premium','premium plan') then 'Premium'
when lower(trim(membership_type)) in ('gold','gold plan') then 'Gold'
else trim(membership_type)
end
where membership_type is not null;


update members
set age = null
where age < 0
or age > 120;


update members
set phone_number = null
where length(phone_number) <> 10;


update members
set email = null
where email is not null
and (email not like '%@%'
or email not like '%.%');



-- corporates table data cleaning

update corporates
set
company_name = nullif(trim(company_name),''),
industry = nullif(trim(industry),''),
city = nullif(trim(city),''),
contract_start_date = nullif(trim(contract_start_date),''),
contract_end_date = nullif(trim(contract_end_date),'')
where corporate_id is not null;


update corporates
set employee_count = null
where employee_count < 0;



-- corporate_members table data cleaning

update corporate_members
set
corporate_id = nullif(trim(corporate_id),''),
member_id = nullif(trim(member_id),''),
designation = nullif(trim(designation),''),
enrollment_date = nullif(trim(enrollment_date),'')
where corporate_member_id is not null;



-- consultations table data cleaning

update consultations
set
member_id = nullif(trim(member_id),''),
specialist_id = nullif(trim(specialist_id),''),
clinic_id = nullif(trim(clinic_id),''),
consultation_date = nullif(trim(consultation_date),''),
consultation_mode = nullif(trim(consultation_mode),''),
status = nullif(trim(status),''),
reason_for_visit = nullif(trim(reason_for_visit),'')
where consultation_id is not null;


update consultations
set consultation_mode = case
when lower(trim(consultation_mode)) in ('online','online consultation','telemedicine') then 'Online'
when lower(trim(consultation_mode)) in ('offline','in-person','in person') then 'Offline'
else trim(consultation_mode)
end
where consultation_mode is not null;


update consultations
set status = case
when lower(trim(status)) in ('completed','complete') then 'Completed'
when lower(trim(status)) in ('cancelled','canceled') then 'Cancelled'
when lower(trim(status)) in ('pending') then 'Pending'
else trim(status)
end
where status is not null;



-- telemedicine_sessions table data cleaning

update telemedicine_sessions
set
consultation_id = nullif(trim(consultation_id),''),
session_start_time = nullif(trim(session_start_time),''),
session_end_time = nullif(trim(session_end_time),''),
platform = nullif(trim(platform),''),
connection_quality = nullif(trim(connection_quality),''),
session_status = nullif(trim(session_status),'')
where session_id is not null;


update telemedicine_sessions
set connection_quality = case
when lower(trim(connection_quality)) in ('excellent','good') then 'Good'
when lower(trim(connection_quality)) in ('average','fair') then 'Average'
when lower(trim(connection_quality)) in ('poor','bad') then 'Poor'
else trim(connection_quality)
end
where connection_quality is not null;


update telemedicine_sessions
set session_status = case
when lower(trim(session_status)) in ('completed','complete') then 'Completed'
when lower(trim(session_status)) in ('cancelled','canceled') then 'Cancelled'
when lower(trim(session_status)) in ('failed','failure') then 'Failed'
else trim(session_status)
end
where session_status is not null;



-- chronic_care_programs table data cleaning

update chronic_care_programs
set
member_id = nullif(trim(member_id),''),
specialist_id = nullif(trim(specialist_id),''),
condition_name = nullif(trim(condition_name),''),
enrollment_date = nullif(trim(enrollment_date),''),
program_status = nullif(trim(program_status),''),
next_review_date = nullif(trim(next_review_date),'')
where program_id is not null;


update chronic_care_programs
set program_status = case
when lower(trim(program_status)) in ('active','ongoing') then 'Active'
when lower(trim(program_status)) in ('completed','complete') then 'Completed'
when lower(trim(program_status)) in ('cancelled','canceled') then 'Cancelled'
else trim(program_status)
end
where program_status is not null;



-- health_packages table data cleaning

update health_packages
set
package_name = nullif(trim(package_name),''),
package_type = nullif(trim(package_type),'')
where package_id is not null;


update health_packages
set price = null
where price < 0;


update health_packages
set validity_days = null
where validity_days < 0;


update health_packages
set tests_included = null
where tests_included < 0;



-- package_subscriptions table data cleaning

update package_subscriptions
set
member_id = nullif(trim(member_id),''),
package_id = nullif(trim(package_id),''),
subscription_date = nullif(trim(subscription_date),''),
expiry_date = nullif(trim(expiry_date),''),
payment_status = nullif(trim(payment_status),'')
where subscription_id is not null;


update package_subscriptions
set payment_status = case
when lower(trim(payment_status)) in ('paid','payment completed') then 'Paid'
when lower(trim(payment_status)) in ('pending','payment pending') then 'Pending'
when lower(trim(payment_status)) in ('failed','payment failed') then 'Failed'
else trim(payment_status)
end
where payment_status is not null;



-- prescriptions table data cleaning

update prescriptions
set
consultation_id = nullif(trim(consultation_id),''),
member_id = nullif(trim(member_id),''),
specialist_id = nullif(trim(specialist_id),''),
medicine_name = nullif(trim(medicine_name),''),
dosage = nullif(trim(dosage),''),
prescription_date = nullif(trim(prescription_date),'')
where prescription_id is not null;


update prescriptions
set duration_days = null
where duration_days <= 0;



-- lab_tests table data cleaning

update lab_tests
set
member_id = nullif(trim(member_id),''),
clinic_id = nullif(trim(clinic_id),''),
test_name = nullif(trim(test_name),''),
test_date = nullif(trim(test_date),''),
test_result = nullif(trim(test_result),''),
test_status = nullif(trim(test_status),'')
where lab_test_id is not null;


update lab_tests
set test_cost = null
where test_cost < 0;


update lab_tests
set test_status = case
when lower(trim(test_status)) in ('completed','complete') then 'Completed'
when lower(trim(test_status)) in ('pending','in progress') then 'Pending'
when lower(trim(test_status)) in ('cancelled','canceled') then 'Cancelled'
else trim(test_status)
end
where test_status is not null;



-- claims table data cleaning

update claims
set
member_id = nullif(trim(member_id),''),
consultation_id = nullif(trim(consultation_id),''),
claim_date = nullif(trim(claim_date),''),
claim_status = nullif(trim(claim_status),''),
insurance_provider = nullif(trim(insurance_provider),'')
where claim_id is not null;


update claims
set claim_amount = null
where claim_amount < 0;


update claims
set claim_status = case
when lower(trim(claim_status)) in ('approved','approve') then 'Approved'
when lower(trim(claim_status)) in ('rejected','reject') then 'Rejected'
when lower(trim(claim_status)) in ('pending') then 'Pending'
else trim(claim_status)
end
where claim_status is not null;



-- staff table data cleaning

update staff
set
clinic_id = nullif(trim(clinic_id),''),
first_name = nullif(trim(first_name),''),
last_name = nullif(trim(last_name),''),
designation = nullif(trim(designation),''),
employment_type = nullif(trim(employment_type),''),
joining_date = nullif(trim(joining_date),'')
where staff_id is not null;


update staff
set salary = null
where salary < 0;


update staff
set employment_type = case
when lower(trim(employment_type)) in ('full-time','full time') then 'Full-Time'
when lower(trim(employment_type)) in ('part-time','part time') then 'Part-Time'
when lower(trim(employment_type)) in ('contract','contractor') then 'Contract'
else trim(employment_type)
end
where employment_type is not null;



-- billing table data cleaning

update billing
set
member_id = nullif(trim(member_id),''),
consultation_id = nullif(trim(consultation_id),''),
bill_date = nullif(trim(bill_date),''),
bill_status = nullif(trim(bill_status),'')
where bill_id is not null;


update billing
set consultation_charges = null
where consultation_charges < 0;


update billing
set lab_charges = null
where lab_charges < 0;


update billing
set medicine_charges = null
where medicine_charges < 0;


update billing
set total_amount = null
where total_amount < 0;


update billing
set bill_status = case
when lower(trim(bill_status)) in ('paid','payment completed') then 'Paid'
when lower(trim(bill_status)) in ('pending','payment pending') then 'Pending'
when lower(trim(bill_status)) in ('cancelled','canceled') then 'Cancelled'
else trim(bill_status)
end
where bill_status is not null;



-- payments table data cleaning

update payments
set
bill_id = nullif(trim(bill_id),''),
member_id = nullif(trim(member_id),''),
payment_date = nullif(trim(payment_date),''),
payment_mode = nullif(trim(payment_mode),''),
payment_status = nullif(trim(payment_status),'')
where payment_id is not null;


update payments
set payment_amount = null
where payment_amount < 0;


update payments
set payment_status = case
when lower(trim(payment_status)) in ('paid','payment completed') then 'Paid'
when lower(trim(payment_status)) in ('pending','payment pending') then 'Pending'
when lower(trim(payment_status)) in ('failed','payment failed') then 'Failed'
else trim(payment_status)
end
where payment_status is not null;

update payments
set payment_mode = "Credit Card"
where payment_mode is null;

-- feedback table data cleaning

update feedback
set
member_id = nullif(trim(member_id),''),
consultation_id = nullif(trim(consultation_id),''),
feedback_text = nullif(trim(feedback_text),''),
feedback_date = nullif(trim(feedback_date),'')
where feedback_id is not null;


update feedback
set rating = null
where rating < 1
or rating > 5;
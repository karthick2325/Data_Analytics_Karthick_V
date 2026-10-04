use HospitalAnalyticsDB;


-- hospitals table data cleaning

update hospitals
set
hospital_name = nullif(trim(hospital_name),''),
hospital_type = nullif(trim(hospital_type),''),
city = nullif(trim(city),''),
state = nullif(trim(state),''),
region = nullif(trim(region),''),
contact_number = nullif(trim(contact_number),''),
email = nullif(trim(email),'')
where hospital_id is not null;


update hospitals
set bed_capacity = null
where bed_capacity < 0;


update hospitals
set established_year = null
where established_year < 1800
or established_year > year(curdate());


update hospitals
set email = null
where email is not null
and (email not like '%@%'
or email not like '%.%');


-- departments table data cleaning

update departments
set
department_name = nullif(trim(department_name),''),
hospital_id = nullif(trim(hospital_id),''),
head_doctor_id = nullif(trim(head_doctor_id),'')
where department_id is not null;


update departments
set floor_number = null
where floor_number < 0;


-- doctors table data cleaning

update doctors
set
first_name = nullif(trim(first_name),''),
last_name = nullif(trim(last_name),''),
gender = nullif(trim(gender),''),
specialization = nullif(trim(specialization),''),
department_id = nullif(trim(department_id),''),
hospital_id = nullif(trim(hospital_id),''),
qualification = nullif(trim(qualification),''),
phone_number = nullif(trim(phone_number),''),
email = nullif(trim(email),'')
where doctor_id is not null;


update doctors
set gender = case
when lower(trim(gender)) in ('m','male') then 'Male'
when lower(trim(gender)) in ('f','female') then 'Female'
else gender
end
where gender is not null;


update doctors
set specialization = case
when lower(trim(specialization)) in ('cardiology','cardiologist') then 'Cardiology'
when lower(trim(specialization)) in ('neurology','neurologist') then 'Neurology'
when lower(trim(specialization)) in ('orthopedics','orthopedic') then 'Orthopedics'
when lower(trim(specialization)) in ('dermatology','dermatologist') then 'Dermatology'
else trim(specialization)
end
where specialization is not null;


update doctors
set experience_years = null
where experience_years < 0;


update doctors
set consultation_fee = null
where consultation_fee < 0;


update doctors
set phone_number = null
where length(phone_number) <> 10;


update doctors
set email = null
where email is not null
and (email not like '%@%'
or email not like '%.%');


-- patients table data cleaning

update patients
set
first_name = nullif(trim(first_name),''),
last_name = nullif(trim(last_name),''),
gender = nullif(trim(gender),''),
city = nullif(trim(city),''),
state = nullif(trim(state),''),
phone_number = nullif(trim(phone_number),''),
email = nullif(trim(email),''),
blood_group = nullif(trim(blood_group),'')
where patient_id is not null;


update patients
set gender = case
when lower(trim(gender)) in ('m','male') then 'Male'
when lower(trim(gender)) in ('f','female') then 'Female'
else gender
end
where gender is not null;


update patients
set age = null
where age < 0
or age > 120;


update patients
set phone_number = null
where length(phone_number) <> 10;


update patients
set email = null
where email is not null
and (email not like '%@%'
or email not like '%.%');


-- rooms table data cleaning

update rooms
set
hospital_id = nullif(trim(hospital_id),''),
room_type = nullif(trim(room_type),''),
room_status = nullif(trim(room_status),'')
where room_id is not null;


update rooms
set daily_charge = null
where daily_charge < 0;


update rooms
set room_status = case
when lower(trim(room_status)) in ('available','free') then 'Available'
when lower(trim(room_status)) in ('occupied','occupied room') then 'Occupied'
when lower(trim(room_status)) in ('maintenance','under maintenance') then 'Maintenance'
else trim(room_status)
end
where room_status is not null;


-- appointments table data cleaning

update appointments
set
patient_id = nullif(trim(patient_id),''),
doctor_id = nullif(trim(doctor_id),''),
hospital_id = nullif(trim(hospital_id),''),
status = nullif(trim(status),''),
reason_for_visit = nullif(trim(reason_for_visit),'')
where appointment_id is not null;


update appointments
set status = case
when lower(trim(status)) in ('completed','complete') then 'Completed'
when lower(trim(status)) in ('cancelled','canceled') then 'Cancelled'
when lower(trim(status)) in ('pending') then 'Pending'
else trim(status)
end
where status is not null;


-- admissions table data cleaning

update admissions
set
patient_id = nullif(trim(patient_id),''),
hospital_id = nullif(trim(hospital_id),''),
department_id = nullif(trim(department_id),''),
admitting_doctor_id = nullif(trim(admitting_doctor_id),''),
room_id = nullif(trim(room_id),''),
admission_type = nullif(trim(admission_type),''),
admission_status = nullif(trim(admission_status),'')
where admission_id is not null;


update admissions
set admission_type = case
when lower(trim(admission_type)) in ('emergency','emergency admission') then 'Emergency'
when lower(trim(admission_type)) in ('scheduled','planned') then 'Scheduled'
else trim(admission_type)
end
where admission_type is not null;


update admissions
set admission_status = case
when lower(trim(admission_status)) in ('admitted','active') then 'Active'
when lower(trim(admission_status)) in ('discharged','discharge') then 'Discharged'
when lower(trim(admission_status)) in ('cancelled','canceled') then 'Cancelled'
else trim(admission_status)
end
where admission_status is not null;


-- treatments table data cleaning

update treatments
set
admission_id = nullif(trim(admission_id),''),
patient_id = nullif(trim(patient_id),''),
doctor_id = nullif(trim(doctor_id),''),
treatment_name = nullif(trim(treatment_name),''),
treatment_status = nullif(trim(treatment_status),'')
where treatment_id is not null;


update treatments
set treatment_cost = null
where treatment_cost < 0;


update treatments
set treatment_status = case
when lower(trim(treatment_status)) in ('completed','complete') then 'Completed'
when lower(trim(treatment_status)) in ('pending','in progress') then 'Pending'
when lower(trim(treatment_status)) in ('cancelled','canceled') then 'Cancelled'
else trim(treatment_status)
end
where treatment_status is not null;


-- insurance table data cleaning

update insurance
set
patient_id = nullif(trim(patient_id),''),
insurance_provider = nullif(trim(insurance_provider),''),
policy_number = nullif(trim(policy_number),''),
claim_status = nullif(trim(claim_status),'')
where insurance_id is not null;


update insurance
set coverage_amount = null
where coverage_amount < 0;


update insurance
set claim_status = case
when lower(trim(claim_status)) in ('approved','approve') then 'Approved'
when lower(trim(claim_status)) in ('rejected','reject') then 'Rejected'
when lower(trim(claim_status)) in ('pending') then 'Pending'
else trim(claim_status)
end
where claim_status is not null;


-- medicines table data cleaning

update medicines
set
medicine_name = nullif(trim(medicine_name),''),
category = nullif(trim(category),''),
manufacturer = nullif(trim(manufacturer),'')
where medicine_id is not null;


update medicines
set unit_price = null
where unit_price < 0;


update medicines
set stock_quantity = null
where stock_quantity < 0;


-- pharmacy table data cleaning

update pharmacy
set
patient_id = nullif(trim(patient_id),''),
medicine_id = nullif(trim(medicine_id)),
hospital_id = nullif(trim(hospital_id),'')
where pharmacy_sale_id is not null;


update pharmacy
set quantity = null
where quantity <= 0;


update pharmacy
set total_price = null
where total_price < 0;


-- laboratory table data cleaning

update laboratory
set
patient_id = nullif(trim(patient_id),''),
doctor_id = nullif(trim(doctor_id),''),
hospital_id = nullif(trim(hospital_id),''),
test_name = nullif(trim(test_name),''),
test_result = nullif(trim(test_result),''),
test_status = nullif(trim(test_status),'')
where lab_test_id is not null;


update laboratory
set test_cost = null
where test_cost < 0;


update laboratory
set test_status = case
when lower(trim(test_status)) in ('completed','complete') then 'Completed'
when lower(trim(test_status)) in ('pending','in progress') then 'Pending'
when lower(trim(test_status)) in ('cancelled','canceled') then 'Cancelled'
else trim(test_status)
end
where test_status is not null;


-- employees table data cleaning

update employees
set
first_name = nullif(trim(first_name),''),
last_name = nullif(trim(last_name),''),
gender = nullif(trim(gender),''),
hospital_id = nullif(trim(hospital_id),''),
department_id = nullif(trim(department_id),''),
designation = nullif(trim(designation),''),
employment_type = nullif(trim(employment_type),''),
phone_number = nullif(trim(phone_number),''),
email = nullif(trim(email),'')
where employee_id is not null;


update employees
set gender = case
when lower(trim(gender)) in ('m','male') then 'Male'
when lower(trim(gender)) in ('f','female') then 'Female'
else gender
end
where gender is not null;


update employees
set salary = null
where salary < 0;


update employees
set employment_type = case
when lower(trim(employment_type)) in ('full-time','full time') then 'Full-Time'
when lower(trim(employment_type)) in ('part-time','part time') then 'Part-Time'
when lower(trim(employment_type)) in ('contract','contractor') then 'Contract'
else trim(employment_type)
end
where employment_type is not null;


update employees
set phone_number = null
where length(phone_number) <> 10;


update employees
set email = null
where email is not null
and (email not like '%@%'
or email not like '%.%');


-- billing table data cleaning

update billing
set
patient_id = nullif(trim(patient_id),''),
admission_id = nullif(trim(admission_id),''),
appointment_id = nullif(trim(appointment_id),''),
bill_status = nullif(trim(bill_status),'')
where bill_id is not null;


update billing
set room_charges = null
where room_charges < 0;


update billing
set doctor_charges = null
where doctor_charges < 0;


update billing
set medicine_charges = null
where medicine_charges < 0;


update billing
set lab_charges = null
where lab_charges < 0;


update billing
set other_charges = null
where other_charges < 0;


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
patient_id = nullif(trim(patient_id),''),
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
set payment_mode = "Net Banking"
where payment_mode is null;


-- feedback table data cleaning

update feedback
set
member_id = nullif(trim(member_id),''),
consultation_id = nullif(trim(consultation_id),''),
feedback_text = nullif(trim(feedback_text),'')
where feedback_id is not null;


update feedback
set rating = null
where rating < 1
or rating > 5;
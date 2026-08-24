use hospitalanalyticsdb;

-- HOSPITALS TABLE DATA CLEANING

select * from hospitals;

select hospital_id,count(*)
from hospitals
group by hospital_id having count(*) > 1;

select * from hospitals
where hospital_name is null
or hospital_type is null
or city is null
or state is null
or region is null
or bed_capacity is null
or established_year is null
or contact_number is null
or email is null;

select *
from hospitals
where trim(hospital_name) = ''
or trim(hospital_type) = ''
or trim(city) = ''
or trim(state) = ''
or trim(region) = ''
or trim(contact_number) = ''
or trim(email) = '';

select * from hospitals
where hospital_name <> trim(hospital_name)
or hospital_type <> trim(hospital_type)
or city <> trim(city)
or state <> trim(state)
or region <> trim(region)
or contact_number <> trim(contact_number)
or email <> trim(email);


select distinct hospital_type,state,region from hospitals;

select bed_capacity from hospitals where bed_capacity < 0;

select contact_number from hospitals where length(contact_number) >11 or length(contact_number) <11;


-- DEPARTMENT TABLE DATA CLEANING

select * from departments;

SELECT
    department_id,
    department_name,
    hospital_id,
    floor_number,
    head_doctor_id
FROM departments
WHERE department_id IS NOT NULL
AND TRIM(head_doctor_id) = '';

set sql_safe_updates = 0;

update departments
set head_doctor_id = null
where trim(head_doctor_id) = '';

select department_id,count(*) as count
from departments
group by department_id
having count(*) > 1;

select hospital_id,department_name,count(*) as count
from departments
group by hospital_id,department_name
having count(*)>1;

select floor_number from departments
where floor_number < 1 or floor_number is null;

select department_id,department_name,hospital_id from departments
where department_name <> trim(department_name);

update departments
set department_name = trim(department_name)
where department_name is not null
or department_name <> trim(department_name);

select department_id,department_name,hospital_id from departments
where department_name <> trim(department_name);


select distinct department_name
from departments
order by department_name;

select lower(department_name),count(*)
from departments
group by lower(department_name)
having count(*) > 1;


select d.department_id,d.department_name,d.hospital_id
from departments as d
left join hospitals as h on d.hospital_id = h.hospital_id
where d.hospital_id is not null
and h.hospital_id is null;


select d.department_id,d.department_name,d.head_doctor_id
from departments d
left join doctors dr on d.head_doctor_id = dr.doctor_id
where d.head_doctor_id is not null
and dr.doctor_id is null;



-- DOCTOR TABLE DATA CLEANING

select * from doctors;

set sql_safe_updates = 0;

update doctors
set
    first_name = nullif(trim(first_name), ''),
    last_name = nullif(trim(last_name), ''),
    gender = nullif(trim(gender), ''),
    specialization = nullif(trim(specialization), ''),
    department_id = nullif(trim(department_id), ''),
    hospital_id = nullif(trim(hospital_id), ''),
    qualification = nullif(trim(qualification), ''),
    experience_years = nullif(trim(experience_years), ''),
    consultation_fee = nullif(trim(consultation_fee), ''),
    phone_number = nullif(trim(phone_number), ''),
    email = nullif(trim(email), ''),
    joining_date = nullif(trim(joining_date), '');


select doctor_id,count(*) as count
from doctors
group by doctor_id
having count(*) > 1;


select first_name,last_name,gender,specialization,qualification,email
from doctors
where first_name <> trim(first_name)
or last_name <> trim(last_name)
or gender <> trim(gender)
or specialization <> trim(specialization)
or qualification <> trim(qualification)
or email <> trim(email);


select distinct gender from doctors order by gender;

update doctors
set gender = case
when lower(trim(gender)) ="f" then "Female"
when lower(trim(gender)) ="female" then "Female"
when lower(trim(gender)) ="m" then "Male"
when lower(trim(gender)) ="male" then "Male"
end;


select distinct specialization from doctors order by specialization;

select lower(specialization),count(distinct specialization) from doctors
group by lower(specialization)
having count(distinct specialization) > 1;

select department_id from doctors;

update doctors
SET department_id = "Missing id"
where department_id is null;



select department_id from doctors;

select doctor_id,experience_years from doctors
where experience_years < 0
or experience_years is null;

select experience_years from doctors;

select doctor_id,first_name,consultation_fee
from doctors where consultation_fee < 0
or consultation_fee is null;


select length(phone_number) from doctors
where length(phone_number) >10 or length(phone_number) <10;

update doctors
set email = "Missing Mail"
where email is null;

select email from doctors
where email is not null and
(email not like "%@%" or email not like "%.%");

-- SOME MAILS INVALID FORMATS IF IT REQUIRED VERIFY TO UPDATE

-- PATIENTS TABLE DATA CLEANING

select * from patients;

update patients
set first_name = nullif(trim(first_name), ''),
	last_name = nullif(trim(last_name), ''),
	gender = nullif(trim(gender), ''),
	date_of_birth = nullif(trim(date_of_birth), ''),
    age = nullif(trim(age), ''),
    city = nullif(trim(city), ''),
    state = nullif(trim(state), ''),
    phone_number = nullif(trim(phone_number), ''),
    email = nullif(trim(email), ''),
    blood_group = nullif(trim(blood_group), ''),
    registration_date = nullif(trim(registration_date), '');
    
select email from patients
where email is null;

select patient_id,count(*) from patients
group by patient_id
having count(*) > 1;

select patient_id,first_name,last_name,gender,city,state,phone_number,email,blood_group
from patients
where first_name <> trim(first_name)
or last_name <> trim(last_name)
or gender <> trim(gender)
or city <> trim(city)
or state <> trim(state)
or phone_number <> trim(phone_number)
or email <> trim(email)
or blood_group <> trim(blood_group);

select distinct gender from patients;

update patients
set gender = case
when lower(trim(gender)) = "m" then "Male"
when lower(trim(gender)) = "f" then "Female"
when lower(trim(gender)) = "male" then "Male"
when lower(trim(gender)) = "female" then "Female"
end;


select date_of_birth from patients
where date_of_birth > curdate() or
date_of_birth is null;

select age from patients
where age < 0 or age > 100 or age is null;

select distinct city from patients order by city;


select length(phone_number) from patients
where length(phone_number) > 10 or length(phone_number) < 10 or length(phone_number) is null;


select email from patients
where email is not null and (email not like "%@%" or email not like "%.%");

-- SOME EMAILS INVALID

select email from patients
where email is null;

update patients
set email = "Missing Mail"
where email is null;


select distinct blood_group from patients;

select registration_date from patients
where registration_date > curdate() or registration_date is null;

-- ROOMS TABLE DATA CLEANING

select * from rooms;

update rooms
set room_id = nullif(trim(room_id),""),
	hospital_id = nullif(trim(hospital_id),""),
    room_number = nullif(trim(room_number),""),
    room_type = nullif(trim(room_type),""),
    floor_number = nullif(trim(floor_number),""),
    daily_charge = nullif(trim(daily_charge),""),
    room_status = nullif(trim(room_status),"");
    
select room_id,count(*) from rooms
group by room_id
having count(*) > 1;

select room_id,hospital_id,room_number,room_type,room_status from rooms
where room_id <> trim(room_id)
or hospital_id <> trim(hospital_id)
or room_number <> trim(room_number)
or room_type <> trim(room_type)
or room_status <> trim(room_status);

select r.room_id,r.hospital_id
from rooms as r
left join hospitals as h
on r.hospital_id = h.hospital_id
where r.hospital_id is not null
and h.hospital_id is null;

select room_id,room_number from rooms
where room_number <= 0 or room_number is null;

select room_id,floor_number from rooms
where floor_number <= 0 or floor_number is null;

select room_id,daily_charge from rooms
where daily_charge <= 0 or daily_charge is null;

select distinct room_type from rooms order by room_type;

select distinct room_status from rooms order by room_status;


-- APPOINMENTS TABLE DATA CLEANING

select * from appointments;

update appointments
set
    patient_id = nullif(trim(patient_id), ''),
    doctor_id = nullif(trim(doctor_id), ''),
    hospital_id = nullif(trim(hospital_id), ''),
    appointment_date = nullif(trim(appointment_date), ''),
    appointment_time = nullif(trim(appointment_time), ''),
    status = nullif(trim(status), ''),
    reason_for_visit = nullif(trim(reason_for_visit), ''),
    created_at = nullif(trim(created_at), '');
    
    

select appointment_id,count(*) as count
from appointments
group by appointment_id
having count(*) > 1;

select appointment_id,patient_id,doctor_id,hospital_id,status,reason_for_visit
from appointments
where patient_id <> trim(patient_id)
or doctor_id <> trim(doctor_id)
or hospital_id <> trim(hospital_id)
or status <> trim(status)
or reason_for_visit <> trim(reason_for_visit);


select a.appointment_id,a.patient_id
from appointments as a
left join patients as p on a.patient_id = p.patient_id
where a.patient_id is not null
and p.patient_id is null;


select a.appointment_id,a.doctor_id
from appointments as a
left join doctors as d on a.doctor_id = d.doctor_id
where a.doctor_id is not null
and d.doctor_id is null;


select a.appointment_id,a.hospital_id
from appointments as a
left join hospitals as h on a.hospital_id = h.hospital_id
where a.hospital_id is not null
and h.hospital_id is null;


select appointment_id,appointment_date
from appointments
where appointment_date > curdate() or appointment_date is null;


select appointment_id,appointment_time
from appointments
where appointment_time < '00:00:00'
or appointment_time > '23:59:59'
or appointment_time is null;



select distinct status
from appointments order by status;

select distinct reason_for_visit
from appointments order by reason_for_visit;


select appointment_id,created_at
from appointments
where created_at is null
or created_at > now();


-- ADMISSIONS TABLE DATA CLEANING

select * from admissions;

update admissions
set
    patient_id = nullif(trim(patient_id), ''),
    hospital_id = nullif(trim(hospital_id), ''),
    department_id = nullif(trim(department_id), ''),
    admitting_doctor_id = nullif(trim(admitting_doctor_id), ''),
    room_id = nullif(trim(room_id), ''),
    admission_date = nullif(trim(admission_date), ''),
    discharge_date = nullif(trim(discharge_date), ''),
    admission_type = nullif(trim(admission_type), ''),
    admission_status = nullif(trim(admission_status), '');


select admission_id,count(*) as count
from admissions
group by admission_id
having count(*) > 1;


select admission_id,patient_id,hospital_id,department_id,admitting_doctor_id,room_id,
    admission_type,admission_status
from admissions
where patient_id <> trim(patient_id)
or hospital_id <> trim(hospital_id)
or department_id <> trim(department_id)
or admitting_doctor_id <> trim(admitting_doctor_id)
or room_id <> trim(room_id)
or admission_type <> trim(admission_type)
or admission_status <> trim(admission_status);


select a.admission_id,a.patient_id
from admissions as a
left join patients as p on a.patient_id = p.patient_id
where a.patient_id is not null
and p.patient_id is null;


select a.admission_id,a.hospital_id
from admissions as a
left join hospitals as h on a.hospital_id = h.hospital_id
where a.hospital_id is not null
and h.hospital_id is null;



select a.admission_id,a.department_id
from admissions as a
left join departments as d on a.department_id = d.department_id
where a.department_id is not null
and d.department_id is null;



select a.admission_id,a.admitting_doctor_id
from admissions as a
left join doctors as d on a.admitting_doctor_id = d.doctor_id
where a.admitting_doctor_id is not null
and d.doctor_id is null;



select a.admission_id,a.room_id
from admissions as a
left join rooms as r on a.room_id = r.room_id
where a.room_id is not null
and r.room_id is null;


select admission_id,patient_id,admission_date
from admissions
where admission_date is null
or admission_date > curdate();


select admission_id,admission_date,discharge_date
from admissions
where discharge_date is not null
and admission_date is not null
and discharge_date < admission_date;


select distinct admission_type
from admissions
order by admission_type;


select distinct admission_status
from admissions
order by admission_status;


-- TREATMENTS TABLE DATA CLEANING

select * from treatments;


update treatments
set
    admission_id = nullif(trim(admission_id), ''),
    patient_id = nullif(trim(patient_id), ''),
    doctor_id = nullif(trim(doctor_id), ''),
    treatment_name = nullif(trim(treatment_name), ''),
    treatment_date = nullif(trim(treatment_date), ''),
    treatment_cost = nullif(trim(treatment_cost), ''),
    treatment_status = nullif(trim(treatment_status), '');
    
    

select * from treatments
where admission_id is null
or patient_id is null
or doctor_id is null
or treatment_name is null
or treatment_date is null
or treatment_cost is null
or treatment_status is null;

select treatment_id,count(*) as count
from treatments
group by treatment_id
having count(*) > 1;

select treatment_id,admission_id,patient_id,doctor_id,treatment_name,treatment_status
from treatments
where admission_id <> trim(admission_id)
or patient_id <> trim(patient_id)
or doctor_id <> trim(doctor_id)
or treatment_name <> trim(treatment_name)
or treatment_status <> trim(treatment_status);


select t.treatment_id,t.admission_id
from treatments as t
left join admissions as a on t.admission_id = a.admission_id
where t.admission_id is not null
and a.admission_id is null;


select t.treatment_id,t.patient_id
from treatments as t
left join patients as p on t.patient_id = p.patient_id
where t.patient_id is not null
and p.patient_id is null;


select t.treatment_id,t.doctor_id
from treatments as t
left join doctors as d on t.doctor_id = d.doctor_id
where t.doctor_id is not null
and d.doctor_id is null;


select treatment_id,patient_id,treatment_date
from treatments
where treatment_date is null
or treatment_date > curdate();


select treatment_id,treatment_name,treatment_cost
from treatments
where treatment_cost < 0
or treatment_cost is null;

-- THIS OUTPUT SHOWING NEGATIVE VALUES.BUT COST NOT SHOW NEGATIVE . SHOW I CAN CHANGE TO NULL

update treatments
set treatment_cost = null
where treatment_cost < 0;


select distinct treatment_status
from treatments
order by treatment_status;


-- INSURANCE TABLE DATA CLEANUNG

select * from insurance;

update insurance
set
    patient_id = nullif(trim(patient_id), ''),
    insurance_provider = nullif(trim(insurance_provider), ''),
    policy_number = nullif(trim(policy_number), ''),
    coverage_amount = nullif(trim(coverage_amount), ''),
    policy_start_date = nullif(trim(policy_start_date), ''),
    policy_end_date = nullif(trim(policy_end_date), ''),
    claim_status = nullif(trim(claim_status), '');
    

select insurance_id,count(*) as count
from insurance
group by insurance_id
having count(*) > 1;



select insurance_id,patient_id,insurance_provider,policy_number,claim_status
from insurance
where patient_id <> trim(patient_id)
or insurance_provider <> trim(insurance_provider)
or policy_number <> trim(policy_number)
or claim_status <> trim(claim_status);



select i.insurance_id,i.patient_id
from insurance as i
left join patients as p on i.patient_id = p.patient_id
where i.patient_id is not null
and p.patient_id is null;



select policy_number,count(*) as count
from insurance
group by policy_number
having count(*) > 1;

-- TWO DUPLIACTE RECORS SHOWING

select insurance_id,patient_id,insurance_provider,policy_number,
	coverage_amount,policy_start_date,policy_end_date,claim_status
from insurance
where policy_number in ('pol599348', 'pol443216');


select insurance_id,patient_id,coverage_amount
from insurance
where coverage_amount < 0
or coverage_amount is null;


select insurance_id,policy_start_date,policy_end_date
from insurance
where policy_start_date is null
or policy_end_date is null
or policy_end_date < policy_start_date;



select distinct insurance_provider
from insurance
order by insurance_provider;


select distinct claim_status
from insurance
order by claim_status;



-- MEDICINES TABLE DATA CLEANING


select * from medicines;

update medicines
set
    medicine_name = nullif(trim(medicine_name), ''),
    category = nullif(trim(category), ''),
    manufacturer = nullif(trim(manufacturer), ''),
    unit_price = nullif(trim(unit_price), ''),
    stock_quantity = nullif(trim(stock_quantity), '');

select medicine_id,count(*) as count
from medicines
group by medicine_id
having count(*) > 1;


select medicine_id,medicine_name,unit_price
from medicines
where unit_price < 0
or unit_price is null;



select medicine_id,medicine_name,stock_quantity
from medicines
where stock_quantity < 0
or stock_quantity is null;


select distinct category
from medicines
order by category;


select distinct manufacturer
from medicines
order by manufacturer;



select medicine_id,unit_price
from medicines
where unit_price < 0;


select medicine_id,stock_quantity
from medicines
where stock_quantity < 0;



-- PHARMACY TABLE DATA CLEANING

select * from pharmacy;


update pharmacy
set
    patient_id = nullif(trim(patient_id), ''),
    medicine_id = nullif(trim(medicine_id), ''),
    hospital_id = nullif(trim(hospital_id), ''),
    quantity = nullif(trim(quantity), ''),
    sale_date = nullif(trim(sale_date), ''),
    total_price = nullif(trim(total_price), '');
    

select pharmacy_sale_id,count(*) as count
from pharmacy
group by pharmacy_sale_id
having count(*) > 1;


select p.pharmacy_sale_id,p.patient_id
from pharmacy as p
left join patients as pt on p.patient_id = pt.patient_id
where p.patient_id is not null
and pt.patient_id is null;



select p.pharmacy_sale_id,p.medicine_id
from pharmacy as p
left join medicines as m on p.medicine_id = m.medicine_id
where p.medicine_id is not null
and m.medicine_id is null;



select p.pharmacy_sale_id,p.hospital_id
from pharmacy as p
left join hospitals as h on p.hospital_id = h.hospital_id
where p.hospital_id is not null
and h.hospital_id is null;


select pharmacy_sale_id,medicine_id,quantity
from pharmacy
where quantity <= 0
or quantity is null;



select pharmacy_sale_id,sale_date
from pharmacy
where sale_date is null
or sale_date > curdate();


select pharmacy_sale_id,total_price
from pharmacy
where total_price < 0
or total_price is null;



-- LABORATORY TABLE DATA CLEANING


select * from laboratory;



update laboratory
set
    patient_id = nullif(trim(patient_id), ''),
    doctor_id = nullif(trim(doctor_id), ''),
    hospital_id = nullif(trim(hospital_id), ''),
    test_name = nullif(trim(test_name), ''),
    test_date = nullif(trim(test_date), ''),
    test_result = nullif(trim(test_result), ''),
    test_cost = nullif(trim(test_cost), ''),
    test_status = nullif(trim(test_status), '');
    
    
    

select lab_test_id,count(*) as count
from laboratory
group by lab_test_id
having count(*) > 1;



select l.lab_test_id,l.patient_id
from laboratory as l
left join patients as p on l.patient_id = p.patient_id
where l.patient_id is not null
and p.patient_id is null;



select l.lab_test_id,l.doctor_id
from laboratory l
left join doctors d on l.doctor_id = d.doctor_id
where l.doctor_id is not null
and d.doctor_id is null;


select l.lab_test_id,l.hospital_id
from laboratory l
left join hospitals h on l.hospital_id = h.hospital_id
where l.hospital_id is not null
and h.hospital_id is null;



select lab_test_id,test_date
from laboratory
where test_date is null
or test_date > curdate();


select lab_test_id,test_name,test_cost
from laboratory
where test_cost < 0
or test_cost is null;


select distinct test_name
from laboratory
order by test_name;



select distinct test_result
from laboratory
order by test_result;



select distinct test_status
from laboratory
order by test_status;



-- EMPLOYEES TABLE DATA CLEANING

select * from employees;


update employees
set
    first_name = nullif(trim(first_name), ''),
    last_name = nullif(trim(last_name), ''),
    gender = nullif(trim(gender), ''),
    hospital_id = nullif(trim(hospital_id), ''),
    department_id = nullif(trim(department_id), ''),
    designation = nullif(trim(designation), ''),
    employment_type = nullif(trim(employment_type), ''),
    salary = nullif(trim(salary), ''),
    joining_date = nullif(trim(joining_date), ''),
    phone_number = nullif(trim(phone_number), ''),
    email = nullif(trim(email), '');
	



select employee_id,count(*) as count
from employees
group by employee_id
having count(*) > 1;



select e.employee_id,e.hospital_id
from employees e
left join hospitals h on e.hospital_id = h.hospital_id
where e.hospital_id is not null
and h.hospital_id is null;



select e.employee_id,e.department_id
from employees e
left join departments d on e.department_id = d.department_id
where e.department_id is not null
and d.department_id is null;



select distinct gender
from employees
order by gender;

-- GENDER HAVED INCONSISTENCY

update employees
set gender = case
when lower(trim(gender)) = 'f' then 'Female'
when lower(trim(gender)) = 'female' then 'Female'
when lower(trim(gender)) = 'm' then 'Male'
when lower(trim(gender)) = 'male' then 'Male'
else gender
end
where gender is not null;



select distinct designation
from employees
order by designation;



select distinct employment_type
from employees
order by employment_type;



select employee_id,first_name,salary
from employees
where salary < 0
or salary is null;



select employee_id,first_name,joining_date
from employees
where joining_date is null
or joining_date > curdate();


select employee_id,phone_number
from employees
where phone_number is not null
and length(phone_number) <> 10;


select employee_id,first_name,email
from employees
where email is not null
and (email not like '%@%' or email not like '%.%');


-- BILLING TABLE DATA CLEANING


select * from billing;


update billing
set
    patient_id = nullif(trim(patient_id), ''),
    admission_id = nullif(trim(admission_id), ''),
    appointment_id = nullif(trim(appointment_id), ''),
    bill_date = nullif(trim(bill_date), ''),
    room_charges = nullif(trim(room_charges), ''),
    doctor_charges = nullif(trim(doctor_charges), ''),
    medicine_charges = nullif(trim(medicine_charges), ''),
    lab_charges = nullif(trim(lab_charges), ''),
    other_charges = nullif(trim(other_charges), ''),
    total_amount = nullif(trim(total_amount), ''),
    bill_status = nullif(trim(bill_status), '');
    
    
    

select bill_id,count(*) as count
from billing
group by bill_id
having count(*) > 1;



select b.bill_id,b.patient_id,b.admission_id,b.appointment_id
from billing b
left join patients p on b.patient_id = p.patient_id
where b.patient_id is not null
and p.patient_id is null;


select b.bill_id,b.patient_id,b.admission_id,b.appointment_id
from billing b
left join appointments a on b.appointment_id = a.appointment_id
where b.appointment_id is not null
and a.appointment_id is null;



select bill_id,room_charges,doctor_charges,medicine_charges,lab_charges,other_charges
from billing
where room_charges < 0
or doctor_charges < 0
or medicine_charges < 0
or lab_charges < 0
or other_charges < 0;


select bill_id,total_amount
from billing
where total_amount < 0;

-- BILLING AMOUNT SHOWING NEGATIVE VALUE.SHOW ITS CONVERT TO NULL.alter

UPDATE billing
SET total_amount = NULL
WHERE total_amount < 0;


select bill_id,patient_id,bill_date
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
    bill_id = nullif(trim(bill_id), ''),
    patient_id = nullif(trim(patient_id), ''),
    payment_date = nullif(trim(payment_date), ''),
    payment_amount = nullif(trim(payment_amount), ''),
    payment_mode = nullif(trim(payment_mode), ''),
    payment_status = nullif(trim(payment_status), '');
    
    

select payment_id,count(*) as count
from payments
group by payment_id
having count(*) > 1;


select p.payment_id,p.bill_id,p.patient_id,p.payment_amount
from payments p
left join billing b on p.bill_id = b.bill_id
where p.bill_id is not null
and b.bill_id is null;


select p.payment_id,p.bill_id,p.patient_id,p.payment_amount
from payments p
left join patients pt on p.patient_id = pt.patient_id
where p.patient_id is not null
and pt.patient_id is null;


select payment_id,bill_id,patient_id,payment_amount
from payments
where payment_amount < 0
or payment_amount is null;

-- NEGATIVE VALUE SHOWING DA.SO I CHANGE TO NULL.

UPDATE payments
SET payment_amount = NULL
WHERE payment_amount < 0;


select payment_id,bill_id,patient_id,payment_date
from payments
where payment_date is null
or payment_date > curdate();



select distinct payment_mode
from payments
order by payment_mode;


select distinct payment_status
from payments
order by payment_status;

























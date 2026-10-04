use HospitalAnalyticsDB;


-- hospitals validation

-- duplicate primary keys
select hospital_id, count(*) as count
from hospitals
group by hospital_id
having count(*) > 1;

-- missing values
select *
from hospitals
where hospital_name is null
or hospital_type is null
or city is null
or state is null
or region is null
or bed_capacity is null
or established_year is null
or contact_number is null;

-- blank values
select *
from hospitals
where trim(hospital_name) = ''
or trim(hospital_type) = ''
or trim(city) = ''
or trim(state) = ''
or trim(region) = ''
or trim(contact_number) = '';

-- invalid bed capacity
select hospital_id, bed_capacity
from hospitals
where bed_capacity < 0
or bed_capacity is null;

-- invalid established year
select hospital_id, established_year
from hospitals
where established_year < 0;

-- invalid contact number
select hospital_id, contact_number
from hospitals
where length(contact_number) <> 10;

-- invalid email
select hospital_id, email
from hospitals
where email is not null
and (email not like '%@%'
or email not like '%.%');


-- departments validation

-- duplicate primary keys
select department_id, count(*) as count
from departments
group by department_id
having count(*) > 1;

-- missing values
select *
from departments
where department_name is null
or hospital_id is null;

-- blank values
select *
from departments
where trim(department_name) = ''
or trim(hospital_id) = '';

-- invalid hospital references
select d.department_id, d.hospital_id
from departments d
left join hospitals h
on d.hospital_id = h.hospital_id
where d.hospital_id is not null
and h.hospital_id is null;


-- doctors validation

-- duplicate primary keys
select doctor_id, count(*) as count
from doctors
group by doctor_id
having count(*) > 1;

-- invalid experience
select doctor_id, experience_years
from doctors
where experience_years < 0
or experience_years is null;

-- invalid consultation fee
select doctor_id, consultation_fee
from doctors
where consultation_fee < 0
or consultation_fee is null;

-- invalid department references
select d.doctor_id, d.department_id
from doctors d
left join departments dp
on d.department_id = dp.department_id
where d.department_id is not null
and dp.department_id is null;

-- invalid hospital references
select d.doctor_id, d.hospital_id
from doctors d
left join hospitals h
on d.hospital_id = h.hospital_id
where d.hospital_id is not null
and h.hospital_id is null;

-- invalid phone number
select doctor_id, phone_number
from doctors
where length(phone_number) <> 10;

-- invalid email
select doctor_id, email
from doctors
where email is not null
and (email not like '%@%'
or email not like '%.%');

-- INVALID MAILS HAVED.AFTER CORRECTION I CORECTION OR REMOVED.


-- patients validation

-- duplicate primary keys
select patient_id, count(*) as count
from patients
group by patient_id
having count(*) > 1;

-- invalid age
select patient_id, age
from patients
where age < 0
or age > 120
or age is null;

-- future date of birth
select patient_id, date_of_birth
from patients
where date_of_birth > curdate();

-- invalid phone number
select patient_id, phone_number
from patients
where length(phone_number) <> 10;

-- invalid email
select patient_id, email
from patients
where email is not null
and (email not like '%@%'
or email not like '%.%');

-- INVALID MAILS HAVED.AFTER CORRECTION I CORECTION OR REMOVED.


-- rooms validation

-- duplicate primary keys
select room_id, count(*) as count
from rooms
group by room_id
having count(*) > 1;

-- invalid hospital references
select r.room_id, r.hospital_id
from rooms r
left join hospitals h
on r.hospital_id = h.hospital_id
where r.hospital_id is not null
and h.hospital_id is null;

-- invalid daily charge
select room_id, daily_charge
from rooms
where daily_charge < 0
or daily_charge is null;

-- invalid floor number
select room_id, floor_number
from rooms
where floor_number < 0;


-- appointments validation

-- duplicate primary keys
select appointment_id, count(*) as count
from appointments
group by appointment_id
having count(*) > 1;

-- invalid patient references
select a.appointment_id, a.patient_id
from appointments a
left join patients p
on a.patient_id = p.patient_id
where a.patient_id is not null
and p.patient_id is null;

-- invalid doctor references
select a.appointment_id, a.doctor_id
from appointments a
left join doctors d
on a.doctor_id = d.doctor_id
where a.doctor_id is not null
and d.doctor_id is null;

-- invalid hospital references
select a.appointment_id, a.hospital_id
from appointments a
left join hospitals h
on a.hospital_id = h.hospital_id
where a.hospital_id is not null
and h.hospital_id is null;

-- future appointment dates
select appointment_id, appointment_date
from appointments
where appointment_date > curdate();


-- admissions validation

-- duplicate primary keys
select admission_id, count(*) as count
from admissions
group by admission_id
having count(*) > 1;

-- invalid patient references
select a.admission_id, a.patient_id
from admissions a
left join patients p
on a.patient_id = p.patient_id
where a.patient_id is not null
and p.patient_id is null;

-- invalid hospital references
select a.admission_id, a.hospital_id
from admissions a
left join hospitals h
on a.hospital_id = h.hospital_id
where a.hospital_id is not null
and h.hospital_id is null;

-- invalid department references
select a.admission_id, a.department_id
from admissions a
left join departments d
on a.department_id = d.department_id
where a.department_id is not null
and d.department_id is null;

-- invalid doctor references
select a.admission_id, a.admitting_doctor_id
from admissions a
left join doctors d
on a.admitting_doctor_id = d.doctor_id
where a.admitting_doctor_id is not null
and d.doctor_id is null;

-- invalid room references
select a.admission_id, a.room_id
from admissions a
left join rooms r
on a.room_id = r.room_id
where a.room_id is not null
and r.room_id is null;

-- invalid admission dates
select admission_id, admission_date, discharge_date
from admissions
where discharge_date < admission_date;


-- treatments validation

-- duplicate primary keys
select treatment_id, count(*) as count
from treatments
group by treatment_id
having count(*) > 1;

-- invalid admission references
select t.treatment_id, t.admission_id
from treatments t
left join admissions a
on t.admission_id = a.admission_id
where t.admission_id is not null
and a.admission_id is null;

-- invalid patient references
select t.treatment_id, t.patient_id
from treatments t
left join patients p
on t.patient_id = p.patient_id
where t.patient_id is not null
and p.patient_id is null;

-- invalid doctor references
select t.treatment_id, t.doctor_id
from treatments t
left join doctors d
on t.doctor_id = d.doctor_id
where t.doctor_id is not null
and d.doctor_id is null;


-- invalid treatment cost
select treatment_id, treatment_cost
from treatments
where treatment_cost < 0
or treatment_cost is null;

-- NEGATIVE COST SHOWED.SO I CAN CHANGE TO NULL.

-- insurance validation

-- duplicate primary keys
select insurance_id, count(*) as count
from insurance
group by insurance_id
having count(*) > 1;

-- invalid patient references
select i.insurance_id, i.patient_id
from insurance i
left join patients p
on i.patient_id = p.patient_id
where i.patient_id is not null
and p.patient_id is null;

-- invalid coverage amount
select insurance_id, coverage_amount
from insurance
where coverage_amount < 0
or coverage_amount is null;

-- invalid policy dates
select insurance_id, policy_start_date, policy_end_date
from insurance
where policy_end_date < policy_start_date;


-- medicines validation

-- duplicate primary keys
select medicine_id, count(*) as count
from medicines
group by medicine_id
having count(*) > 1;

-- invalid unit price
select medicine_id, unit_price
from medicines
where unit_price < 0
or unit_price is null;

-- invalid stock quantity
select medicine_id, stock_quantity
from medicines
where stock_quantity < 0
or stock_quantity is null;


-- pharmacy validation

-- duplicate primary keys
select pharmacy_sale_id, count(*) as count
from pharmacy
group by pharmacy_sale_id
having count(*) > 1;

-- invalid patient references
select p.pharmacy_sale_id, p.patient_id
from pharmacy p
left join patients pt
on p.patient_id = pt.patient_id
where p.patient_id is not null
and pt.patient_id is null;

-- invalid medicine references
select p.pharmacy_sale_id, p.medicine_id
from pharmacy p
left join medicines m
on p.medicine_id = m.medicine_id
where p.medicine_id is not null
and m.medicine_id is null;

-- invalid hospital references
select p.pharmacy_sale_id, p.hospital_id
from pharmacy p
left join hospitals h
on p.hospital_id = h.hospital_id
where p.hospital_id is not null
and h.hospital_id is null;

-- invalid quantity
select pharmacy_sale_id, quantity
from pharmacy
where quantity <= 0
or quantity is null;

-- invalid total price
select pharmacy_sale_id, total_price
from pharmacy
where total_price < 0
or total_price is null;


-- laboratory validation

-- duplicate primary keys
select lab_test_id, count(*) as count
from laboratory
group by lab_test_id
having count(*) > 1;

-- invalid patient references
select l.lab_test_id, l.patient_id
from laboratory l
left join patients p
on l.patient_id = p.patient_id
where l.patient_id is not null
and p.patient_id is null;

-- invalid doctor references
select l.lab_test_id, l.doctor_id
from laboratory l
left join doctors d
on l.doctor_id = d.doctor_id
where l.doctor_id is not null
and d.doctor_id is null;

-- invalid hospital references
select l.lab_test_id, l.hospital_id
from laboratory l
left join hospitals h
on l.hospital_id = h.hospital_id
where l.hospital_id is not null
and h.hospital_id is null;

-- invalid test cost
select lab_test_id, test_cost
from laboratory
where test_cost < 0
or test_cost is null;


-- employees validation

-- duplicate primary keys
select employee_id, count(*) as count
from employees
group by employee_id
having count(*) > 1;

-- invalid hospital references
select e.employee_id, e.hospital_id
from employees e
left join hospitals h
on e.hospital_id = h.hospital_id
where e.hospital_id is not null
and h.hospital_id is null;

-- invalid department references
select e.employee_id, e.department_id
from employees e
left join departments d
on e.department_id = d.department_id
where e.department_id is not null
and d.department_id is null;

-- invalid salary
select employee_id, salary
from employees
where salary < 0
or salary is null;

-- invalid phone number
select employee_id, phone_number
from employees
where length(phone_number) <> 10;

-- invalid email
select employee_id, email
from employees
where email is not null
and (email not like '%@%'
or email not like '%.%');


-- billing validation

-- duplicate primary keys
select bill_id, count(*) as count
from billing
group by bill_id
having count(*) > 1;

-- invalid patient references
select b.bill_id, b.patient_id
from billing b
left join patients p
on b.patient_id = p.patient_id
where b.patient_id is not null
and p.patient_id is null;

-- invalid admission references
select b.bill_id, b.admission_id
from billing b
left join admissions a
on b.admission_id = a.admission_id
where b.admission_id is not null
and a.admission_id is null;

-- invalid appointment references
select b.bill_id, b.appointment_id
from billing b
left join appointments a
on b.appointment_id = a.appointment_id
where b.appointment_id is not null
and a.appointment_id is null;

-- invalid total amount
select bill_id, total_amount
from billing
where total_amount < 0;


-- payments validation

-- duplicate primary keys
select payment_id, count(*) as count
from payments
group by payment_id
having count(*) > 1;

-- invalid bill references
select p.payment_id, p.bill_id
from payments p
left join billing b
on p.bill_id = b.bill_id
where p.bill_id is not null
and b.bill_id is null;

-- invalid patient references
select p.payment_id, p.patient_id
from payments p
left join patients pt
on p.patient_id = pt.patient_id
where p.patient_id is not null
and pt.patient_id is null;

-- invalid payment amount
select payment_id, payment_amount
from payments
where payment_amount < 0
or payment_amount is null;

-- NEGATIVE PAYMENT SHOWED.SO I CAN CHANGE TO NULL.
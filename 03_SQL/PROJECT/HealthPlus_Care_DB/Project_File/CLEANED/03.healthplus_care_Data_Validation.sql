use healthplus_care_db;


-- clinics validation

-- duplicate primary keys
select clinic_id, count(*) as count
from clinics
group by clinic_id
having count(*) > 1;

-- missing values
select *
from clinics
where clinic_name is null
or clinic_type is null
or city is null
or state is null
or established_year is null
or contact_number is null;

-- blank values
select *
from clinics
where trim(clinic_name) = ''
or trim(clinic_type) = ''
or trim(city) = ''
or trim(state) = ''
or trim(contact_number) = '';

-- invalid established year
select clinic_id, established_year
from clinics
where established_year < 0;

-- invalid contact number
select clinic_id, contact_number
from clinics
where length(contact_number) <> 10;


-- specialists validation

-- duplicate primary keys
select specialist_id, count(*) as count
from specialists
group by specialist_id
having count(*) > 1;

-- invalid experience
select specialist_id, experience_years
from specialists
where experience_years < 0
or experience_years is null;

-- invalid consultation fee
select specialist_id, consultation_fee
from specialists
where consultation_fee < 0
or consultation_fee is null;

-- invalid clinic references
select s.specialist_id, s.clinic_id
from specialists s
left join clinics c
on s.clinic_id = c.clinic_id
where s.clinic_id is not null
and c.clinic_id is null;


-- members validation

-- duplicate primary keys
select member_id, count(*) as count
from members
group by member_id
having count(*) > 1;

-- invalid age
select member_id, age
from members
where age < 0
or age > 100
or age is null;

-- future date of birth
select member_id, date_of_birth
from members
where date_of_birth > curdate();

-- invalid phone number
select member_id, phone_number
from members
where length(phone_number) <> 10;

-- invalid email
select member_id, email
from members
where email is not null
and (email not like '%@%'
or email not like '%.%');

-- INAVLID EMAIL ID HAVED.MAIN DATA USED TO CORRECTION OR REMOVED LATERLY.


-- corporates validation

-- duplicate primary keys
select corporate_id, count(*) as count
from corporates
group by corporate_id
having count(*) > 1;

-- invalid employee count
select corporate_id, employee_count
from corporates
where employee_count < 0
or employee_count is null;

-- invalid contract dates
select corporate_id, contract_start_date, contract_end_date
from corporates
where contract_end_date < contract_start_date;


-- corporate_members validation

-- duplicate primary keys
select corporate_member_id, count(*) as count
from corporate_members
group by corporate_member_id
having count(*) > 1;

-- invalid corporate references
select cm.corporate_member_id, cm.corporate_id
from corporate_members cm
left join corporates c
on cm.corporate_id = c.corporate_id
where cm.corporate_id is not null
and c.corporate_id is null;

-- invalid member references
select cm.corporate_member_id, cm.member_id
from corporate_members cm
left join members m on cm.member_id = m.member_id
where cm.member_id is not null
and m.member_id is null;



-- consultations validation

-- duplicate primary keys
select consultation_id, count(*) as count
from consultations
group by consultation_id
having count(*) > 1;

-- invalid member references
select c.consultation_id, c.member_id
from consultations c
left join members m
on c.member_id = m.member_id
where c.member_id is not null
and m.member_id is null;

-- invalid specialist references
select c.consultation_id, c.specialist_id
from consultations c
left join specialists s
on c.specialist_id = s.specialist_id
where c.specialist_id is not null
and s.specialist_id is null;

-- invalid clinic references
select c.consultation_id, c.clinic_id
from consultations c
left join clinics cl
on c.clinic_id = cl.clinic_id
where c.clinic_id is not null
and cl.clinic_id is null;

-- future consultation dates
select consultation_id, consultation_date
from consultations
where consultation_date > curdate();


-- telemedicine_sessions validation


select session_id, count(*) as count
from telemedicine_sessions
group by session_id
having count(*) > 1;

select t.session_id, t.consultation_id
from telemedicine_sessions t
left join consultations c
on t.consultation_id = c.consultation_id
where t.consultation_id is not null
and c.consultation_id is null;

select session_id, session_start_time, session_end_time
from telemedicine_sessions
where session_start_time is null
or session_end_time is null;


-- chronic_care_programs validation

select program_id, count(*) as count
from chronic_care_programs
group by program_id
having count(*) > 1;

select c.program_id, c.member_id
from chronic_care_programs c
left join members m
on c.member_id = m.member_id
where c.member_id is not null
and m.member_id is null;

select c.program_id, c.specialist_id
from chronic_care_programs c
left join specialists s
on c.specialist_id = s.specialist_id
where c.specialist_id is not null
and s.specialist_id is null;


-- health_packages validation

select package_id, count(*) as count
from health_packages
group by package_id
having count(*) > 1;

select package_id, price
from health_packages
where price < 0
or price is null;

select package_id, validity_days
from health_packages
where validity_days < 0
or validity_days is null;

select package_id, tests_included
from health_packages
where tests_included < 0
or tests_included is null;


-- package_subscriptions validation

select subscription_id, count(*) as count
from package_subscriptions
group by subscription_id
having count(*) > 1;

select ps.subscription_id, ps.member_id
from package_subscriptions ps
left join members m
on ps.member_id = m.member_id
where ps.member_id is not null
and m.member_id is null;

select ps.subscription_id, ps.package_id
from package_subscriptions ps
left join health_packages hp
on ps.package_id = hp.package_id
where ps.package_id is not null
and hp.package_id is null;

select subscription_id, subscription_date, expiry_date
from package_subscriptions
where subscription_date is null
or expiry_date is null
or expiry_date < subscription_date;


-- prescriptions validation

select prescription_id, count(*) as count
from prescriptions
group by prescription_id
having count(*) > 1;

select p.prescription_id, p.consultation_id
from prescriptions p
left join consultations c
on p.consultation_id = c.consultation_id
where p.consultation_id is not null
and c.consultation_id is null;

select p.prescription_id, p.member_id
from prescriptions p
left join members m
on p.member_id = m.member_id
where p.member_id is not null
and m.member_id is null;

select p.prescription_id, p.specialist_id
from prescriptions p
left join specialists s
on p.specialist_id = s.specialist_id
where p.specialist_id is not null
and s.specialist_id is null;

select prescription_id, duration_days
from prescriptions
where duration_days <= 0
or duration_days is null;


-- lab_tests validation

select lab_test_id, count(*) as count
from lab_tests
group by lab_test_id
having count(*) > 1;

select l.lab_test_id, l.member_id
from lab_tests l
left join members m
on l.member_id = m.member_id
where l.member_id is not null
and m.member_id is null;

select l.lab_test_id, l.clinic_id
from lab_tests l
left join clinics c
on l.clinic_id = c.clinic_id
where l.clinic_id is not null
and c.clinic_id is null;

select lab_test_id, test_cost
from lab_tests
where test_cost < 0
or test_cost is null;


-- claims validation

select claim_id, count(*) as count
from claims
group by claim_id
having count(*) > 1;

select c.claim_id, c.member_id
from claims c
left join members m
on c.member_id = m.member_id
where c.member_id is not null
and m.member_id is null;

select c.claim_id, c.consultation_id
from claims c
left join consultations co
on c.consultation_id = co.consultation_id
where c.consultation_id is not null
and co.consultation_id is null;

select claim_id, claim_amount
from claims
where claim_amount < 0
or claim_amount is null;


-- staff validation

select staff_id, count(*) as count
from staff
group by staff_id
having count(*) > 1;

select s.staff_id, s.clinic_id
from staff s
left join clinics c
on s.clinic_id = c.clinic_id
where s.clinic_id is not null
and c.clinic_id is null;

select staff_id, salary
from staff
where salary < 0
or salary is null;


-- billing validation

select bill_id, count(*) as count
from billing
group by bill_id
having count(*) > 1;

select b.bill_id, b.member_id
from billing b
left join members m
on b.member_id = m.member_id
where b.member_id is not null
and m.member_id is null;

select b.bill_id, b.consultation_id
from billing b
left join consultations c
on b.consultation_id = c.consultation_id
where b.consultation_id is not null
and c.consultation_id is null;

select bill_id, total_amount
from billing
where total_amount < 0;


-- payments validation

select payment_id, count(*) as count
from payments
group by payment_id
having count(*) > 1;

select p.payment_id, p.bill_id
from payments p
left join billing b
on p.bill_id = b.bill_id
where p.bill_id is not null
and b.bill_id is null;

select p.payment_id, p.member_id
from payments p
left join members m
on p.member_id = m.member_id
where p.member_id is not null
and m.member_id is null;

select payment_id, payment_amount
from payments
where payment_amount < 0
or payment_amount is null;

-- PAYMENT AMOUNT IS SHOWED NEGATIVE.SO I CAN CHANGE TO NULL.

-- feedback validation

select feedback_id, count(*) as count
from feedback
group by feedback_id
having count(*) > 1;

select f.feedback_id, f.member_id
from feedback f
left join members m
on f.member_id = m.member_id
where f.member_id is not null
and m.member_id is null;

select f.feedback_id, f.consultation_id
from feedback f
left join consultations c
on f.consultation_id = c.consultation_id
where f.consultation_id is not null
and c.consultation_id is null;

select feedback_id, rating
from feedback
where rating < 1
or rating > 5
or rating is null;
use healthplus_care_db;


-- 01. which clinics have the highest consultation volume?

select
    c.clinic_id,
    c.clinic_name,
    count(cs.consultation_id) as consultation_volume
from clinics c
inner join consultations cs
    on c.clinic_id = cs.clinic_id
group by c.clinic_id, c.clinic_name
order by consultation_volume desc;


-- 02. which specialists have the highest consultation workload?

select
    s.specialist_id,
    concat(s.first_name, ' ', s.last_name) as specialist_name,
    s.specialization,
    count(c.consultation_id) as consultation_workload
from specialists s
inner join consultations c
    on s.specialist_id = c.specialist_id
group by s.specialist_id, s.first_name, s.last_name, s.specialization
order by consultation_workload desc;


-- 03. which specializations have the highest activity?

select
    s.specialization,
    count(c.consultation_id) as consultation_activity
from specialists s
inner join consultations c
    on s.specialist_id = c.specialist_id
group by s.specialization
order by consultation_activity desc;


-- 04. which members are the most active healthcare users?

select
    m.member_id,
    concat(m.first_name, ' ', m.last_name) as member_name,
    count(c.consultation_id) as consultation_count
from members m
inner join consultations c
    on m.member_id = c.member_id
group by m.member_id, m.first_name, m.last_name
order by consultation_count desc;


-- 05. how do consultation modes compare?

select
    consultation_mode,
    count(*) as total_consultations,
    round(count(*) * 100.0 / (select count(*) from consultations), 2) as consultation_percentage
from consultations
group by consultation_mode
order by total_consultations desc;


-- 06. which reasons for visit occur most frequently?

select
    reason_for_visit,
    count(*) as total_visits
from consultations
group by reason_for_visit
order by total_visits desc;


-- 07. which consultation statuses require attention?

select
    lower(status) as consultation_status,
    count(*) as total_consultations
from consultations
where lower(status) <> 'completed'
group by lower(status)
order by total_consultations desc;


-- 08. how many telemedicine sessions are completed, cancelled, or in other statuses?

select
    lower(session_status) as session_status,
    count(*) as total_sessions
from telemedicine_sessions
group by lower(session_status)
order by total_sessions desc;


-- 09. which telemedicine platforms and connection-quality categories are most common?

select
    platform,
    connection_quality,
    count(*) as total_sessions
from telemedicine_sessions
group by platform, connection_quality
order by total_sessions desc;


-- 10. what is the average telemedicine session duration?

select
    round(avg(timestampdiff(
        minute,
        str_to_date(session_start_time, '%Y-%m-%d %H:%i:%s'),
        str_to_date(session_end_time, '%Y-%m-%d %H:%i:%s')
    )), 2) as average_session_duration_minutes
from telemedicine_sessions
where session_start_time is not null
  and session_end_time is not null;


-- 11. which chronic conditions have the highest program enrollment?

select
    condition_name,
    count(*) as program_enrollment
from chronic_care_programs
group by condition_name
order by program_enrollment desc;


-- 12. which specialists manage the most chronic-care programs?

select
    s.specialist_id,
    concat(s.first_name, ' ', s.last_name) as specialist_name,
    s.specialization,
    count(ccp.program_id) as chronic_program_count
from specialists s
inner join chronic_care_programs ccp
    on s.specialist_id = ccp.specialist_id
group by s.specialist_id, s.first_name, s.last_name, s.specialization
order by chronic_program_count desc;


-- 13. which health packages have the highest subscription volume?

select
    hp.package_id,
    hp.package_name,
    count(ps.subscription_id) as subscription_volume
from health_packages hp
inner join package_subscriptions ps
    on hp.package_id = ps.package_id
group by hp.package_id, hp.package_name
order by subscription_volume desc;


-- 14. which subscriptions are approaching or have passed expiry based on expiry_date?

select
    subscription_id,
    member_id,
    package_id,
    expiry_date,
    case
        when str_to_date(expiry_date, '%Y-%m-%d') < curdate()
            then 'expired'
        when str_to_date(expiry_date, '%Y-%m-%d')
             between curdate() and date_add(curdate(), interval 30 day)
            then 'expiring within 30 days'
        else 'active'
    end as expiry_status
from package_subscriptions
where str_to_date(expiry_date, '%Y-%m-%d') <= date_add(curdate(), interval 30 day)
order by str_to_date(expiry_date, '%Y-%m-%d');


-- 15. which corporates contribute the most enrolled members?

select
    c.corporate_id,
    c.company_name,
    count(cm.corporate_member_id) as enrolled_members
from corporates c
inner join corporate_members cm
    on c.corporate_id = cm.corporate_id
group by c.corporate_id, c.company_name
order by enrolled_members desc;


-- 16. which industries have the greatest corporate healthcare participation?

select
    c.industry,
    count(distinct c.corporate_id) as total_corporates,
    count(cm.corporate_member_id) as enrolled_members
from corporates c
inner join corporate_members cm
    on c.corporate_id = cm.corporate_id
group by c.industry
order by enrolled_members desc;


-- 17. which medicines are prescribed most frequently?

select
    medicine_name,
    count(*) as prescription_count
from prescriptions
group by medicine_name
order by prescription_count desc;


-- 18. which specialists generate the highest prescription volume?

select
    s.specialist_id,
    concat(s.first_name, ' ', s.last_name) as specialist_name,
    s.specialization,
    count(p.prescription_id) as prescription_volume
from specialists s
inner join prescriptions p
    on s.specialist_id = p.specialist_id
group by s.specialist_id, s.first_name, s.last_name, s.specialization
order by prescription_volume desc;


-- 19. which lab tests generate the highest total cost?

select
    test_name,
    count(*) as test_count,
    sum(test_cost) as total_test_cost
from lab_tests
group by test_name
order by total_test_cost desc;


-- 20. which clinics have the highest laboratory workload?

select
    c.clinic_id,
    c.clinic_name,
    count(l.lab_test_id) as laboratory_workload
from clinics c
inner join lab_tests l
    on c.clinic_id = l.clinic_id
group by c.clinic_id, c.clinic_name
order by laboratory_workload desc;


-- 21. which insurance providers have the highest claim amount?

select
    insurance_provider,
    count(claim_id) as total_claims,
    sum(claim_amount) as total_claim_amount
from claims
group by insurance_provider
order by total_claim_amount desc;


-- 22. what is the distribution of claim statuses?

select
    claim_status,
    count(*) as total_claims,
    round(count(*) * 100.0 / (select count(*) from claims), 2) as claim_percentage
from claims
group by claim_status
order by total_claims desc;


-- 23. what is the total billed amount and how is it split among consultation, laboratory, and medicine charges?

select
    sum(total_amount) as total_billed_amount,
    sum(consultation_charges) as total_consultation_charges,
    sum(lab_charges) as total_lab_charges,
    sum(medicine_charges) as total_medicine_charges
from billing;


-- 24. what is the total payment amount by payment status and payment mode?

select
    payment_status,
    payment_mode,
    count(payment_id) as total_payments,
    sum(payment_amount) as total_payment_amount
from payments
group by payment_status, payment_mode
order by total_payment_amount desc;


-- 25. what is the validated collection gap?

select
    b.bill_id,
    b.total_amount as billed_amount,
    coalesce(sum(case
        when lower(p.payment_status) = 'success' then p.payment_amount
        when lower(p.payment_status) = 'refunded' then -p.payment_amount
        else 0
    end), 0) as validated_collection,
    b.total_amount - coalesce(sum(case
        when lower(p.payment_status) = 'success' then p.payment_amount
        when lower(p.payment_status) = 'refunded' then -p.payment_amount
        else 0
    end), 0) as collection_gap
from billing b
left join payments p
    on b.bill_id = p.bill_id
group by b.bill_id, b.total_amount
order by collection_gap desc;


-- 26. which clinics or specialists receive the highest and lowest average feedback ratings?

select
    'clinic' as entity_type,
    c.clinic_id as entity_id,
    c.clinic_name as entity_name,
    round(avg(f.rating), 2) as average_rating,
    count(f.feedback_id) as feedback_count
from clinics c
inner join consultations cs
    on c.clinic_id = cs.clinic_id
inner join feedback f
    on cs.consultation_id = f.consultation_id
group by c.clinic_id, c.clinic_name

union all

select
    'specialist' as entity_type,
    s.specialist_id as entity_id,
    concat(s.first_name, ' ', s.last_name) as entity_name,
    round(avg(f.rating), 2) as average_rating,
    count(f.feedback_id) as feedback_count
from specialists s
inner join consultations cs
    on s.specialist_id = cs.specialist_id
inner join feedback f
    on cs.consultation_id = f.consultation_id
group by s.specialist_id, s.first_name, s.last_name

order by average_rating desc;


-- 27. are there members with consultations but no feedback?

select distinct
    m.member_id,
    concat(m.first_name, ' ', m.last_name) as member_name
from members m
inner join consultations c
    on m.member_id = c.member_id
left join feedback f
    on c.consultation_id = f.consultation_id
where f.feedback_id is null
order by m.member_id;


-- 28. are there registered members with no consultations?

select
    m.member_id,
    concat(m.first_name, ' ', m.last_name) as member_name,
    m.registration_date
from members m
left join consultations c
    on m.member_id = c.member_id
where c.consultation_id is null
order by m.member_id;


-- 29. which business areas show high activity but weak financial or experience indicators?

with consultation_metrics as (
    select
        c.clinic_id,
        c.clinic_name,
        count(cs.consultation_id) as consultation_volume,
        round(avg(f.rating), 2) as average_rating,
        round(
            sum(case
                when lower(cs.status) in ('cancelled', 'no-show') then 1
                else 0
            end) * 100.0 / count(cs.consultation_id),
            2
        ) as issue_rate
    from clinics c
    left join consultations cs
        on c.clinic_id = cs.clinic_id
    left join feedback f
        on cs.consultation_id = f.consultation_id
    group by c.clinic_id, c.clinic_name
),
billing_metrics as (
    select
        c.clinic_id,
        sum(b.total_amount) as total_billed_amount
    from clinics c
    inner join consultations cs
        on c.clinic_id = cs.clinic_id
    inner join billing b
        on cs.consultation_id = b.consultation_id
    group by c.clinic_id
),
payment_metrics as (
    select
        c.clinic_id,
        sum(case
            when lower(p.payment_status) = 'success' then p.payment_amount
            when lower(p.payment_status) = 'refunded' then -p.payment_amount
            else 0
        end) as validated_collection
    from clinics c
    inner join consultations cs
        on c.clinic_id = cs.clinic_id
    inner join billing b
        on cs.consultation_id = b.consultation_id
    inner join payments p
        on b.bill_id = p.bill_id
    group by c.clinic_id
),
clinic_metrics as (
    select
        cm.clinic_id,
        cm.clinic_name,
        cm.consultation_volume,
        coalesce(bm.total_billed_amount, 0) as total_billed_amount,
        coalesce(pm.validated_collection, 0) as validated_collection,
        cm.average_rating,
        cm.issue_rate
    from consultation_metrics cm
    left join billing_metrics bm
        on cm.clinic_id = bm.clinic_id
    left join payment_metrics pm
        on cm.clinic_id = pm.clinic_id
),
benchmarks as (
    select
        avg(consultation_volume) as avg_activity,
        avg(total_billed_amount) as avg_billed_amount,
        avg(validated_collection) as avg_collection,
        avg(average_rating) as avg_rating,
        avg(issue_rate) as avg_issue_rate
    from clinic_metrics
)
select
    cm.clinic_id,
    cm.clinic_name,
    cm.consultation_volume,
    cm.total_billed_amount,
    cm.validated_collection,
    round(cm.total_billed_amount - cm.validated_collection, 2) as collection_gap,
    cm.average_rating,
    cm.issue_rate
from clinic_metrics cm
cross join benchmarks b
where cm.consultation_volume > b.avg_activity
  and (
        cm.total_billed_amount < b.avg_billed_amount
        or cm.validated_collection < b.avg_collection
        or cm.average_rating < b.avg_rating
        or cm.issue_rate > b.avg_issue_rate
      )
order by cm.consultation_volume desc;
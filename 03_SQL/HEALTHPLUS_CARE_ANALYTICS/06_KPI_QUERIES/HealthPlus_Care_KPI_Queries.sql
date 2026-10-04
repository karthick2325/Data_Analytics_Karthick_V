use healthplus_care_db;


-- kpi queries

-- 01. total members
select
    count(distinct member_id) as total_members
from members;


-- 02. total consultations
select
    count(distinct consultation_id) as total_consultations
from consultations;


-- 03. completed consultations
select
    count(distinct consultation_id) as completed_consultations
from consultations
where lower(status) = 'completed';


-- 04. consultation completion rate %
select
    round(
        100.0 * sum(
            case
                when lower(status) = 'completed' then 1
                else 0
            end
        ) / nullif(count(*), 0),
        2
    ) as consultation_completion_rate
from consultations;


-- 05. total specialists
select
    count(distinct specialist_id) as total_specialists
from specialists;


-- 06. total clinics
select
    count(distinct clinic_id) as total_clinics
from clinics;


-- 07. average consultations per member
select
    round(
        count(distinct consultation_id) /
        nullif(count(distinct member_id), 0),
        2
    ) as avg_consultations_per_member
from consultations;


-- 08. total telemedicine sessions
select
    count(distinct session_id) as total_telemedicine_sessions
from telemedicine_sessions;


-- 09. telemedicine completion rate %
select
    round(
        100.0 * sum(
            case
                when lower(session_status) = 'completed' then 1
                else 0
            end
        ) / nullif(count(*), 0),
        2
    ) as telemedicine_completion_rate
from telemedicine_sessions;


-- 10. average telemedicine session duration
select
    round(
        avg(
            timestampdiff(
                minute,
                session_start_time,
                session_end_time
            )
        ),
        2
    ) as avg_telemedicine_duration_minutes
from telemedicine_sessions
where session_start_time is not null
  and session_end_time is not null;


-- 11. total billed amount
select
    round(sum(total_amount), 2) as total_billed_amount
from billing;


-- 12. total successful payment amount
select
    round(
        sum(
            case
                when lower(payment_status) = 'success'
                then payment_amount
                else 0
            end
        ),
        2
    ) as total_successful_payment
from payments;


-- 13. total refunded amount
select
    round(
        sum(
            case
                when lower(payment_status) = 'refunded'
                then payment_amount
                else 0
            end
        ),
        2
    ) as total_refunded_amount
from payments;


-- 14. net collection amount
select
    round(
        sum(
            case
                when lower(payment_status) = 'success'
                    then payment_amount
                when lower(payment_status) = 'refunded'
                    then -payment_amount
                else 0
            end
        ),
        2
    ) as net_collection_amount
from payments;


-- 15. collection rate %
with bill_summary as (
    select
        sum(total_amount) as total_billed
    from billing
),
payment_summary as (
    select
        sum(
            case
                when lower(payment_status) = 'success'
                    then payment_amount
                when lower(payment_status) = 'refunded'
                    then -payment_amount
                else 0
            end
        ) as net_collected
    from payments
)
select
    round(
        100.0 * net_collected / nullif(total_billed, 0),
        2
    ) as collection_rate
from bill_summary
cross join payment_summary;


-- 16. collection gap
with bill_summary as (
    select
        sum(total_amount) as total_billed
    from billing
),
payment_summary as (
    select
        sum(
            case
                when lower(payment_status) = 'success'
                    then payment_amount
                when lower(payment_status) = 'refunded'
                    then -payment_amount
                else 0
            end
        ) as net_collected
    from payments
)
select
    round(total_billed, 2) as total_billed,
    round(net_collected, 2) as net_collected,
    round(total_billed - net_collected, 2) as collection_gap
from bill_summary
cross join payment_summary;


-- 17. total package subscriptions
select
    count(distinct subscription_id) as total_package_subscriptions
from package_subscriptions;


-- 18. paid package subscription rate %
select
    round(
        100.0 * sum(
            case
                when lower(payment_status) = 'paid' then 1
                else 0
            end
        ) / nullif(count(*), 0),
        2
    ) as paid_subscription_rate
from package_subscriptions;


-- 19. active chronic care programs
select
    count(distinct program_id) as active_chronic_care_programs
from chronic_care_programs
where lower(program_status) = 'active';


-- 20. total chronic care programs
select
    count(distinct program_id) as total_chronic_care_programs
from chronic_care_programs;


-- 21. total lab tests
select
    count(distinct lab_test_id) as total_lab_tests
from lab_tests;


-- 22. total lab test cost
select
    round(sum(test_cost), 2) as total_lab_test_cost
from lab_tests;


-- 23. average lab test cost
select
    round(avg(test_cost), 2) as avg_lab_test_cost
from lab_tests;


-- 24. total claims amount
select
    round(sum(claim_amount), 2) as total_claim_amount
from claims;


-- 25. approved claims amount
select
    round(
        sum(
            case
                when lower(claim_status) = 'approved'
                then claim_amount
                else 0
            end
        ),
        2
    ) as approved_claim_amount
from claims;


-- 26. average feedback rating
select
    round(avg(rating), 2) as avg_feedback_rating
from feedback;


-- 27. total feedback responses
select
    count(distinct feedback_id) as total_feedback_responses
from feedback;


-- 28. positive feedback rate %
-- rating 4 or 5 is treated as positive
select
    round(
        100.0 * sum(
            case
                when rating >= 4 then 1
                else 0
            end
        ) / nullif(count(*), 0),
        2
    ) as positive_feedback_rate
from feedback
where rating is not null;


-- 29. total corporate members
select
    count(distinct corporate_member_id) as total_corporate_members
from corporate_members;


-- 30. total corporate organizations
select
    count(distinct corporate_id) as total_corporates
from corporates;


-- 31. total staff
select
    count(distinct staff_id) as total_staff
from staff;


-- 32. average staff salary
select
    round(avg(salary), 2) as avg_staff_salary
from staff;

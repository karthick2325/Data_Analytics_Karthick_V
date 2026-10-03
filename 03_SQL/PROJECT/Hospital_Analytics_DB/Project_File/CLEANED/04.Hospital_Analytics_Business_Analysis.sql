use HospitalAnalyticsDB;


-- 01. which hospitals have the highest patient and operational activity?

select
    h.hospital_id,
    h.hospital_name,
    count(distinct x.patient_id) as patient_count,
    count(x.activity_id) as operational_activity
from hospitals h
left join (
    select
        hospital_id,
        patient_id,
        appointment_id as activity_id
    from appointments

    union all

    select
        hospital_id,
        patient_id,
        admission_id as activity_id
    from admissions

    union all

    select
        a.hospital_id,
        t.patient_id,
        t.treatment_id as activity_id
    from treatments t
    inner join admissions a
        on t.admission_id = a.admission_id

    union all

    select
        hospital_id,
        patient_id,
        lab_test_id as activity_id
    from laboratory

    union all

    select
        hospital_id,
        patient_id,
        pharmacy_sale_id as activity_id
    from pharmacy
) x
    on h.hospital_id = x.hospital_id
group by h.hospital_id, h.hospital_name
order by operational_activity desc, patient_count desc;


-- 02. which departments experience the highest appointment and admission workload?

select
    d.department_id,
    d.department_name,
    count(distinct a.appointment_id) as appointment_workload,
    count(distinct ad.admission_id) as admission_workload
from departments d
left join doctors doc
    on d.department_id = doc.department_id
left join appointments a
    on doc.doctor_id = a.doctor_id
left join admissions ad
    on d.department_id = ad.department_id
group by d.department_id, d.department_name
order by appointment_workload desc, admission_workload desc;


-- 03. how is doctor workload distributed based on available appointment or treatment data?

select
    d.doctor_id,
    concat(d.first_name, ' ', d.last_name) as doctor_name,
    d.specialization,
    coalesce(a.appointment_count, 0) as appointment_count,
    coalesce(t.treatment_count, 0) as treatment_count,
    coalesce(a.appointment_count, 0) +
    coalesce(t.treatment_count, 0) as total_workload
from doctors d
left join (
    select
        doctor_id,
        count(*) as appointment_count
    from appointments
    group by doctor_id
) a
    on d.doctor_id = a.doctor_id
left join (
    select
        doctor_id,
        count(*) as treatment_count
    from treatments
    group by doctor_id
) t
    on d.doctor_id = t.doctor_id
order by total_workload desc;


-- 04. which patients have the highest healthcare service activity?

select
    p.patient_id,
    concat(p.first_name, ' ', p.last_name) as patient_name,
    count(*) as service_activity
from patients p
inner join (
    select patient_id from appointments

    union all

    select patient_id from admissions

    union all

    select patient_id from treatments

    union all

    select patient_id from laboratory

    union all

    select patient_id from pharmacy
) s
    on p.patient_id = s.patient_id
group by p.patient_id, p.first_name, p.last_name
order by service_activity desc;


-- 05. which hospitals and departments record the highest admissions?

select
    h.hospital_id,
    h.hospital_name,
    d.department_id,
    d.department_name,
    count(a.admission_id) as total_admissions
from hospitals h
inner join admissions a
    on h.hospital_id = a.hospital_id
inner join departments d
    on a.department_id = d.department_id
group by
    h.hospital_id,
    h.hospital_name,
    d.department_id,
    d.department_name
order by total_admissions desc;


-- 06. what are the patterns in admission type and admission status?

select
    admission_type,
    admission_status,
    count(*) as total_admissions
from admissions
group by admission_type, admission_status
order by total_admissions desc;


-- 07. what is the average patient length of stay where admission and discharge dates are available?

select
    round(avg(datediff(discharge_date, admission_date)), 2)
        as average_length_of_stay_days
from admissions
where admission_date is not null
  and discharge_date is not null
  and discharge_date >= admission_date;


-- 08. how are rooms distributed by type and status?

select
    room_type,
    room_status,
    count(*) as total_rooms
from rooms
group by room_type, room_status
order by total_rooms desc;


-- 09. which treatments generate the highest activity and treatment costs?

select
    treatment_name,
    count(*) as treatment_activity,
    sum(treatment_cost) as total_treatment_cost
from treatments
group by treatment_name
order by treatment_activity desc, total_treatment_cost desc;


-- 10. which laboratory tests or services generate the highest volume and cost?

select
    test_name,
    count(*) as test_volume,
    sum(test_cost) as total_test_cost
from laboratory
group by test_name
order by test_volume desc, total_test_cost desc;


-- 11. which medicines generate the highest pharmacy activity or revenue?

select
    m.medicine_id,
    m.medicine_name,
    sum(p.quantity) as total_quantity_sold,
    count(p.pharmacy_sale_id) as sales_count,
    sum(p.total_price) as total_revenue
from medicines m
inner join pharmacy p
    on m.medicine_id = p.medicine_id
group by m.medicine_id, m.medicine_name
order by total_revenue desc, total_quantity_sold desc;


-- 12. how much revenue is billed across the healthcare network?

select
    sum(total_amount) as total_billed_revenue
from billing;


-- 13. how do room, doctor, medicine, laboratory, and other charges contribute to billing?

select
    sum(room_charges) as room_charges,
    sum(doctor_charges) as doctor_charges,
    sum(medicine_charges) as medicine_charges,
    sum(lab_charges) as laboratory_charges,
    sum(other_charges) as other_charges,
    sum(total_amount) as total_billed_amount
from billing;


-- 14. how much of the billed amount has been collected through payments?

select
    sum(b.total_amount) as total_billed_amount,
    coalesce(sum(p.collected_amount), 0) as total_collected_amount,
    sum(b.total_amount) - coalesce(sum(p.collected_amount), 0) as collection_gap
from billing b
left join (
    select
        bill_id,
        sum(payment_amount) as collected_amount
    from payments
    where lower(payment_status) = 'success'
    group by bill_id
) p
    on b.bill_id = p.bill_id;


-- 15. where are the largest gaps between billed amounts and payment collections?

select
    b.bill_id,
    b.patient_id,
    b.total_amount as billed_amount,
    coalesce(p.collected_amount, 0) as collected_amount,
    b.total_amount - coalesce(p.collected_amount, 0) as collection_gap
from billing b
left join (
    select
        bill_id,
        sum(
            case
                when lower(payment_status) = 'success'
                    then payment_amount
                when lower(payment_status) = 'refunded'
                    then -payment_amount
                else 0
            end
        ) as collected_amount
    from payments
    group by bill_id
) p
    on b.bill_id = p.bill_id
order by collection_gap desc;


-- 16. how do payment methods and payment status affect collection performance?

select
    payment_mode,
    payment_status,
    count(payment_id) as total_payments,
    sum(payment_amount) as payment_amount,
    round(avg(payment_amount), 2) as average_payment_amount
from payments
group by payment_mode, payment_status
order by payment_amount desc;
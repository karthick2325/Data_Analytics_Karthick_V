use HospitalAnalyticsDB;

-- KPI QUERIES

select count(*) as total_patients
from patients;

select count(*) as total_appointments
from appointments;

select count(*) as total_admissions
from admissions;

select round(avg(datediff(discharge_date, admission_date)),2) as average_length_of_stay
from admissions
where discharge_date is not null
  and discharge_date >= admission_date;

select count(*) as total_treatments
from treatments;

select round(sum(treatment_cost),2) as total_treatment_cost
from treatments;

select count(*) as total_lab_activity
from laboratory;

select count(*) as total_pharmacy_activity
from pharmacy;

select round(sum(total_amount),2) as total_billed_amount
from billing;

select round(sum(payment_amount),2) as total_payment_collected
from payments
where payment_status = 'paid';

select
    round((select sum(total_amount) from billing) -
          (select coalesce(sum(payment_amount),0)
           from payments
           where payment_status = 'paid'), 2) as collection_gap;

select
    round(
        100 * (select coalesce(sum(payment_amount),0)
               from payments
               where payment_status = 'paid')
        / nullif((select sum(total_amount) from billing),0),
        2
    ) as collection_rate_percent;

select h.hospital_name,
       count(distinct a.appointment_id) +
       count(distinct ad.admission_id) as hospital_activity
from hospitals h
left join appointments a on a.hospital_id = h.hospital_id
left join admissions ad on ad.hospital_id = h.hospital_id
group by h.hospital_id, h.hospital_name
order by hospital_activity desc;

select d.department_name,
       count(distinct ad.admission_id) as department_workload
from departments d
left join admissions ad on ad.department_id = d.department_id
group by d.department_id, d.department_name
order by department_workload desc;

select doc.doctor_id,
       concat(doc.first_name,' ',doc.last_name) as doctor_name,
       count(a.appointment_id) as doctor_workload
from doctors doc
left join appointments a on a.doctor_id = doc.doctor_id
group by doc.doctor_id, doctor_name
order by doctor_workload desc;

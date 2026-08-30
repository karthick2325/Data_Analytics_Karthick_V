create database HospitalAnalyticsDB;

use HospitalAnalyticsDB;


create table hospitals (
hospital_id varchar(10) primary key,
hospital_name varchar(100),
hospital_type varchar(50),
city varchar(50),
state varchar(50),
region varchar(20),
bed_capacity int,
established_year int,
contact_number varchar(15),
email varchar(150)
);


create table departments (
department_id varchar(10) primary key,
department_name varchar(50),
hospital_id varchar(10),
floor_number int,
head_doctor_id varchar(10)
);


create table doctors (
doctor_id varchar(10) primary key,
first_name varchar(50),
last_name varchar(50),
gender varchar(10),
specialization varchar(50),
department_id varchar(10),
hospital_id varchar(10),
qualification varchar(50),
experience_years int,
consultation_fee decimal(10,2),
phone_number varchar(15),
email varchar(150),
joining_date date
);


create table patients (
patient_id varchar(10) primary key,
first_name varchar(50),
last_name varchar(50),
gender varchar(10),
date_of_birth date,
age int,
city varchar(50),
state varchar(50),
phone_number varchar(15),
email varchar(150),
blood_group varchar(5),
registration_date date
);


create table rooms (
room_id varchar(10) primary key,
hospital_id varchar(10),
room_number int,
room_type varchar(30),
floor_number int,
daily_charge decimal(10,2),
room_status varchar(20)
);


create table appointments (
appointment_id varchar(10) primary key,
patient_id varchar(10),
doctor_id varchar(10),
hospital_id varchar(10),
appointment_date date,
appointment_time time,
status varchar(20),
reason_for_visit varchar(100),
created_at datetime
);


create table admissions (
admission_id varchar(10) primary key,
patient_id varchar(10),
hospital_id varchar(10),
department_id varchar(10),
admitting_doctor_id varchar(10),
room_id varchar(10),
admission_date date,
discharge_date date,
admission_type varchar(30),
admission_status varchar(30)
);


create table treatments (
treatment_id varchar(10) primary key,
admission_id varchar(10),
patient_id varchar(10),
doctor_id varchar(10),
treatment_name varchar(150),
treatment_date date,
treatment_cost decimal(12,2),
treatment_status varchar(30)
);


create table insurance (
insurance_id varchar(10) primary key,
patient_id varchar(10),
insurance_provider varchar(100),
policy_number varchar(20),
coverage_amount decimal(12,2),
policy_start_date date,
policy_end_date date,
claim_status varchar(30)
);


create table medicines (
medicine_id varchar(10) primary key,
medicine_name varchar(100),
category varchar(50),
manufacturer varchar(100),
unit_price decimal(10,2),
stock_quantity int
);


create table pharmacy (
pharmacy_sale_id varchar(10) primary key,
patient_id varchar(10),
medicine_id varchar(10),
hospital_id varchar(10),
quantity int,
sale_date date,
total_price decimal(12,2)
);


create table laboratory (
lab_test_id varchar(10) primary key,
patient_id varchar(10),
doctor_id varchar(10),
hospital_id varchar(10),
test_name varchar(100),
test_date date,
test_result varchar(50),
test_cost decimal(12,2),
test_status varchar(30)
);


create table employees (
employee_id varchar(10) primary key,
first_name varchar(50),
last_name varchar(50),
gender varchar(10),
hospital_id varchar(10),
department_id varchar(10),
designation varchar(50),
employment_type varchar(20),
salary decimal(12,2),
joining_date date,
phone_number varchar(15),
email varchar(150)
);


create table billing (
bill_id varchar(10) primary key,
patient_id varchar(10),
admission_id varchar(10),
appointment_id varchar(10),
bill_date date,
room_charges decimal(12,2),
doctor_charges decimal(12,2),
medicine_charges decimal(12,2),
lab_charges decimal(12,2),
other_charges decimal(12,2),
total_amount decimal(12,2),
bill_status varchar(30)
);


create table payments (
payment_id varchar(10) primary key,
bill_id varchar(10),
patient_id varchar(10),
payment_date date,
payment_amount decimal(12,2),
payment_mode varchar(30),
payment_status varchar(30)
);


alter table departments add constraint fk_departments_hospital
foreign key (hospital_id)
references hospitals(hospital_id);


alter table departments add constraint fk_departments_head_doctor
foreign key (head_doctor_id)
references doctors(doctor_id);


alter table doctors add constraint fk_doctors_department
foreign key (department_id)
references departments(department_id);


alter table doctors add constraint fk_doctors_hospital
foreign key (hospital_id)
references hospitals(hospital_id);


alter table rooms add constraint fk_rooms_hospital
foreign key (hospital_id)
references hospitals(hospital_id);


alter table appointments add constraint fk_appointments_patient
foreign key (patient_id)
references patients(patient_id);


alter table appointments add constraint fk_appointments_doctor
foreign key (doctor_id)
references doctors(doctor_id);


alter table appointments add constraint fk_appointments_hospital
foreign key (hospital_id)
references hospitals(hospital_id);


alter table admissions add constraint fk_admissions_patient
foreign key (patient_id)
references patients(patient_id);


alter table admissions add constraint fk_admissions_hospital
foreign key (hospital_id)
references hospitals(hospital_id);


alter table admissions add constraint fk_admissions_department
foreign key (department_id)
references departments(department_id);


alter table admissions add constraint fk_admissions_doctor
foreign key (admitting_doctor_id)
references doctors(doctor_id);


alter table admissions add constraint fk_admissions_room
foreign key (room_id)
references rooms(room_id);


alter table treatments add constraint fk_treatments_admission
foreign key (admission_id)
references admissions(admission_id);


alter table treatments add constraint fk_treatments_patient
foreign key (patient_id)
references patients(patient_id);


alter table treatments add constraint fk_treatments_doctor
foreign key (doctor_id)
references doctors(doctor_id);


alter table insurance add constraint fk_insurance_patient
foreign key (patient_id)
references patients(patient_id);


alter table pharmacy add constraint fk_pharmacy_patient
foreign key (patient_id)
references patients(patient_id);


alter table pharmacy add constraint fk_pharmacy_medicine
foreign key (medicine_id)
references medicines(medicine_id);


alter table pharmacy add constraint fk_pharmacy_hospital
foreign key (hospital_id)
references hospitals(hospital_id);


alter table laboratory add constraint fk_laboratory_patient
foreign key (patient_id)
references patients(patient_id);


alter table laboratory add constraint fk_laboratory_doctor
foreign key (doctor_id)
references doctors(doctor_id);


alter table laboratory add constraint fk_laboratory_hospital
foreign key (hospital_id)
references hospitals(hospital_id);


alter table employees add constraint fk_employees_hospital
foreign key (hospital_id)
references hospitals(hospital_id);


alter table employees add constraint fk_employees_department
foreign key (department_id)
references departments(department_id);


alter table billing add constraint fk_billing_patient
foreign key (patient_id)
references patients(patient_id);


alter table billing add constraint fk_billing_admission
foreign key (admission_id)
references admissions(admission_id);


alter table billing add constraint fk_billing_appointment
foreign key (appointment_id)
references appointments(appointment_id);


alter table payments add constraint fk_payments_bill
foreign key (bill_id)
references billing(bill_id);


alter table payments add constraint fk_payments_patient
foreign key (patient_id)
references patients(patient_id);
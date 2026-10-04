create database healthplus_care_db;

use healthplus_care_db;


create table clinics (
clinic_id varchar(20) primary key,
clinic_name varchar(150),
clinic_type varchar(100),
city varchar(100),
state varchar(100),
established_year varchar(20),
contact_number varchar(20)
);


create table specialists (
specialist_id varchar(20) primary key,
first_name varchar(100),
last_name varchar(100),
gender varchar(20),
specialization varchar(100),
clinic_id varchar(20),
qualification varchar(100),
experience_years int,
consultation_fee decimal(10,2)
);


create table members (
member_id varchar(20) primary key,
first_name varchar(100),
last_name varchar(100),
gender varchar(20),
date_of_birth varchar(30),
age int,
city varchar(100),
membership_type varchar(50),
registration_date varchar(30),
phone_number varchar(20),
email varchar(150)
);


create table corporates (
corporate_id varchar(20) primary key,
company_name varchar(150),
industry varchar(100),
city varchar(100),
contract_start_date varchar(30),
contract_end_date varchar(30),
employee_count int
);


create table corporate_members (
corporate_member_id varchar(20) primary key,
corporate_id varchar(20),
member_id varchar(20),
designation varchar(100),
enrollment_date varchar(30)
);


create table consultations (
consultation_id varchar(20) primary key,
member_id varchar(20),
specialist_id varchar(20),
clinic_id varchar(20),
consultation_date varchar(30),
consultation_mode varchar(50),
status varchar(50),
reason_for_visit varchar(200)
);


create table telemedicine_sessions (
session_id varchar(20) primary key,
consultation_id varchar(20),
session_start_time varchar(50),
session_end_time varchar(50),
platform varchar(50),
connection_quality varchar(50),
session_status varchar(50)
);


create table chronic_care_programs (
program_id varchar(20) primary key,
member_id varchar(20),
specialist_id varchar(20),
condition_name varchar(150),
enrollment_date varchar(30),
program_status varchar(50),
next_review_date varchar(30)
);


create table health_packages (
package_id varchar(20) primary key,
package_name varchar(150),
package_type varchar(100),
price decimal(10,2),
validity_days int,
tests_included int
);


create table package_subscriptions (
subscription_id varchar(20) primary key,
member_id varchar(20),
package_id varchar(20),
subscription_date varchar(30),
expiry_date varchar(30),
payment_status varchar(50)
);


create table prescriptions (
prescription_id varchar(20) primary key,
consultation_id varchar(20),
member_id varchar(20),
specialist_id varchar(20),
medicine_name varchar(150),
dosage varchar(100),
duration_days int,
prescription_date varchar(30)
);


create table lab_tests (
lab_test_id varchar(20) primary key,
member_id varchar(20),
clinic_id varchar(20),
test_name varchar(150),
test_date varchar(30),
test_result varchar(100),
test_cost decimal(10,2),
test_status varchar(50)
);


create table claims (
claim_id varchar(20) primary key,
member_id varchar(20),
consultation_id varchar(20),
claim_amount decimal(10,2),
claim_date varchar(30),
claim_status varchar(50),
insurance_provider varchar(150)
);


create table staff (
staff_id varchar(20) primary key,
clinic_id varchar(20),
first_name varchar(100),
last_name varchar(100),
designation varchar(100),
employment_type varchar(50),
salary decimal(12,2),
joining_date varchar(30)
);


create table billing (
bill_id varchar(20) primary key,
member_id varchar(20),
consultation_id varchar(20),
bill_date varchar(30),
consultation_charges decimal(10,2),
lab_charges decimal(10,2),
medicine_charges decimal(10,2),
total_amount decimal(10,2),
bill_status varchar(50)
);


create table payments (
payment_id varchar(20) primary key,
bill_id varchar(20),
member_id varchar(20),
payment_date varchar(30),
payment_amount decimal(10,2),
payment_mode varchar(50),
payment_status varchar(50)
);


create table feedback (
feedback_id varchar(20) primary key,
member_id varchar(20),
consultation_id varchar(20),
rating int,
feedback_text varchar(500),
feedback_date varchar(30)
);


ALTER TABLE specialists ADD CONSTRAINT fk_specialists_clinic
FOREIGN KEY (clinic_id)
REFERENCES clinics(clinic_id);


ALTER TABLE corporate_members ADD CONSTRAINT fk_corporate_members_corporate
FOREIGN KEY (corporate_id)
REFERENCES corporates(corporate_id);

alter table corporate_members add constraint fk_corporate_members_member
foreign key (member_id)
references members(member_id);


alter table consultations add constraint fk_consultations_member
foreign key (member_id)
references members(member_id);


alter table consultations add constraint fk_consultations_specialist
foreign key (specialist_id)
references specialists(specialist_id);


alter table consultations add constraint fk_consultations_clinic
foreign key (clinic_id)
references clinics(clinic_id);


alter table telemedicine_sessions add constraint fk_telemedicine_consultation
foreign key (consultation_id)
references consultations(consultation_id);


alter table chronic_care_programs add constraint fk_chronic_care_member
foreign key (member_id)
references members(member_id);



alter table chronic_care_programs add constraint fk_chronic_care_specialist
foreign key (specialist_id)
references specialists(specialist_id);



alter table package_subscriptions add constraint fk_package_subscriptions_member
foreign key (member_id)
references members(member_id);



alter table package_subscriptions add constraint fk_package_subscriptions_package
foreign key (package_id)
references health_packages(package_id);



alter table prescriptions add constraint fk_prescriptions_consultation
foreign key (consultation_id)
references consultations(consultation_id);


alter table prescriptions add constraint fk_prescriptions_member
foreign key (member_id)
references members(member_id);

alter table prescriptions add constraint fk_prescriptions_specialist
foreign key (specialist_id)
references specialists(specialist_id);

alter table lab_tests add constraint fk_lab_tests_member
foreign key (member_id)
references members(member_id);


alter table lab_tests add constraint fk_lab_tests_clinic
foreign key (clinic_id)
references clinics(clinic_id);

alter table claims add constraint fk_claims_member
foreign key (member_id)
references members(member_id);


alter table claims add constraint fk_claims_consultation
foreign key (consultation_id)
references consultations(consultation_id);


alter table staff add constraint fk_staff_clinic
foreign key (clinic_id)
references clinics(clinic_id);


alter table billing add constraint fk_billing_member
foreign key (member_id)
references members(member_id);


alter table billing add constraint fk_billing_consultation
foreign key (consultation_id)
references consultations(consultation_id);


alter table payments add constraint fk_payments_bill
foreign key (bill_id)
references billing(bill_id);


alter table payments add constraint fk_payments_member
foreign key (member_id)
references members(member_id);

alter table feedback add constraint fk_feedback_member
foreign key (member_id)
references members(member_id);


alter table feedback add constraint fk_feedback_consultation
foreign key (consultation_id)
references consultations(consultation_id);


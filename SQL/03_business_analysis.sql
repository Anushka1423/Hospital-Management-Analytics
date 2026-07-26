
-- HOSPITAL MANAGEMENT ANALYTICS
-- Business Analysis Queries


USE hospital_analytics_project;

-- SECTION 1: PATIENT ANALYSIS

-- Query 1: Count the total number of patients in the hospital
SELECT COUNT(*) AS Total_Patients
FROM Patients;
-- Query 2: Male vs Female patients
SELECT gender, COUNT(*) AS Total
FROM Patients 
GROUP BY gender;
--Query 3: Blood group distribution
SELECT blood_group, COUNT(*) AS Total
FROM Patients 
GROUP BY blood_group;
--Query 4: City-wise patient count
SELECT city , COUNT(*) AS Total
FROM Patients
GROUP BY city
Order BY city; 
--Query 5: Average age of patients
SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR,date_of_birth, CURDATE())),1) AS Avg_age
FROM Patients;

-- SECTION 2: DOCTOR ANALYSIS

--Query 6: Total Doctors
SELECT COUNT(*) AS Total_doc
FROM Doctors;
--Query 7: Doctors in each department
SELECT department_name,COUNT(doc.doctor_id) AS total_doctors
FROM Departments AS dep
INNER JOIN Doctors AS doc
ON dep.department_id = doc.department_id
GROUP BY department_name;
--Query 8: Average experience by department
SELECT department_name, ROUND(AVG(doc.experience_years, 2)) AS avergae_experience
FROM Departments dep
INNER JOIN Doctors doc
ON dep.department_id = doc.department_id
GROUP BY  department_name;
--Query 9: Top 10 most experienced doctors
SELECT 
first_name,
last_name,
specialization,
experience_years 
FROM Doctors
ORDER BY experience_years DESC
LIMIT 10;
--Query 10: Doctors by specialization
SELECT specialization,
COUNT(*) AS total_doctors
FROM doctors
GROUP BY specialization
ORDER BY total_doctors DESC;

--APPOINTMENT ANALYSIS

--Query 11: Total appointments
SELECT COUNT(appointment_id) AS total_appointments
FROM Appointments;
--Query 12: Appointment Status
SELECT appointment_status, 
COUNT(*) AS total
FROM Appointments
GROUP BY appointment_status;
--Query 13: Appointment Type
SELECT appointment_type, COUNT(*) AS total
FROM  Appointments
GROUP BY appointment_type ;
--Query 14: Average consultation fee
SELECT ROUND(AVG(consultation_fee),2) AS avg_fee
FROM Appointments;
--Query 15: Highest consultation fee
SELECT MAX(consultation_fee) AS max_fee
FROM Appointments;

--BILLING ANALYSIS

--Query 16: Total revenue
SELECT SUM(total_amount) AS total_revenue
FROM billing;
--Query 17: Average bill amount
SELECT ROUND(AVG(total_amount),2) AS average_bill
FROM billing;
--Query 18: Payment method distribution
SELECT payment_method,
COUNT(*) AS total_transactions
FROM billing
GROUP BY payment_method;
--Query 19: Payment status
SELECT payment_status,
COUNT(*) AS total
FROM billing
GROUP BY payment_status;
--Query 20: Highest bill amount
SELECT MAX(total_amount) AS highest_bill
FROM billing;
SECTION 5: Admission Analysis (5 Queries)
Q21. Total admissions

--ADMISSION ANALYSIS

--Query 21: Total admissions
SELECT COUNT(*) AS total_admissions
FROM admissions;
--Query 22: Admitted vs Discharged patients
SELECT admission_status,
COUNT(*) AS total
FROM admissions
GROUP BY admission_status;
--Query 23: Average hospital stay
SELECT ROUND(AVG(DATEDIFF(discharge_date, admission_date)),2) AS average_days
FROM admissions;
--Query 24: Total occupied beds
SELECT COUNT(*) AS occupied_beds
FROM beds
WHERE availability_status='Occupied';
--Query 25: Bed availability
SELECT availability_status,
COUNT(*) AS total
FROM beds
GROUP BY availability_status;

--MEDICINE ANALYSIS

--Query 26: Total medicines
SELECT COUNT(*) AS total_medicines
FROM medicines;
--Query 27: Average medicine price
SELECT ROUND(AVG(unit_price),2) AS average_price
FROM medicines;
--Query 28: Top 10 expensive medicines
SELECT medicine_name,
unit_price
FROM medicines
ORDER BY unit_price DESC
LIMIT 10;
--Query 29: Low stock medicines
SELECT medicine_name,
stock_quantity
FROM medicines
WHERE stock_quantity<100;
--Query 30: Most prescribed medicines
SELECT m.medicine_name,
COUNT(p.prescription_id) AS total_prescriptions
FROM medicines m
JOIN prescriptions p
ON m.medicine_id=p.medicine_id
GROUP BY m.medicine_name
ORDER BY total_prescriptions DESC;
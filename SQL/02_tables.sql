CREATE TABLE Departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL UNIQUE,
    department_location VARCHAR(100) NOT NULL,
    contact_number VARCHAR(15),
    head_of_department VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Doctors (
doctor_id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
gender VARCHAR(10) NOT NULL,
specialization VARCHAR(100) NOT NULL,
experience_years INT NOT NULL,
phone VARCHAR(15) UNIQUE,
email VARCHAR(100) UNIQUE,
department_id INT NOT NULL,
joining_date DATE NOT NULL,

FOREIGN KEY (department_id)
REFERENCES Departments(department_id)
);

CREATE TABLE Patients (
patient_id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
gender VARCHAR(10) NOT NULL,
date_of_birth DATE NOT NULL,
blood_group VARCHAR(5),
phone VARCHAR(15) UNIQUE,
email VARCHAR(100) UNIQUE,
city VARCHAR(50),
registration_date DATE NOT NULL
);

CREATE TABLE Beds (
bed_id INT AUTO_INCREMENT PRIMARY KEY,
ward_name VARCHAR(50) NOT NULL,
room_number INT NOT NULL,
bed_type VARCHAR(30) NOT NULL,
availability_status VARCHAR(20) NOT NULL
);

CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    appointment_status VARCHAR(20) NOT NULL,
    appointment_type VARCHAR(30),
    consultation_fee DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (patient_id)
        REFERENCES Patients(patient_id),

    FOREIGN KEY (doctor_id)
        REFERENCES Doctors(doctor_id)
);

CREATE TABLE Admissions(
    admission_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    bed_id INT NOT NULL,
    admission_date DATE NOT NULL,
    discharge_date DATE,
    admission_status VARCHAR(20) NOT NULL,

    FOREIGN KEY(patient_id)
        REFERENCES Patients(patient_id),

    FOREIGN KEY(bed_id)
        REFERENCES Beds(bed_id)
);

CREATE TABLE Medicines(
    medicine_id INT AUTO_INCREMENT PRIMARY KEY,
    medicine_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL
);

CREATE TABLE Prescriptions(
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    medicine_id INT NOT NULL,
    quantity INT NOT NULL,
    dosage VARCHAR(50),

    FOREIGN KEY(appointment_id)
        REFERENCES Appointments(appointment_id),

    FOREIGN KEY(medicine_id)
        REFERENCES Medicines(medicine_id)
);

CREATE TABLE billing (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(30) NOT NULL,
    payment_status VARCHAR(20) NOT NULL,
    billing_date DATE NOT NULL,

    CONSTRAINT fk_billing_appointment
    FOREIGN KEY (appointment_id)
    REFERENCES appointments(appointment_id)
);
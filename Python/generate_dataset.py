from faker import Faker
import pandas as pd
import random

from config import *

fake = Faker('en_IN')

print("Hospital Dataset Generation Started...")

# -------------------------------
# Generate Departments
# -------------------------------

department_names = [
    "Cardiology",
    "Neurology",
    "Orthopedics",
    "Pediatrics",
    "Dermatology",
    "Oncology",
    "Gynecology",
    "ENT",
    "Radiology",
    "Emergency",
    "General Medicine",
    "Psychiatry"
]

department_locations = [
    "Block A",
    "Block B",
    "Block C",
    "Block D",
    "Block E",
    "Block F",
    "Block G",
    "Block H",
    "Block I",
    "Ground Floor",
    "First Floor",
    "Second Floor"
]

departments = []

for department_id in range(1, NUM_DEPARTMENTS + 1):

    departments.append({
        "department_id": department_id,
        "department_name": department_names[department_id - 1],
        "department_location": department_locations[department_id - 1],
        "contact_number": fake.phone_number(),
        "head_of_department": fake.name()
    })

df_departments = pd.DataFrame(departments)

df_departments.to_csv("Dataset/departments.csv", index=False)

print("Departments generated successfully!")

# -------------------------------
# Generate Doctors
# -------------------------------

specializations = [
    "Cardiologist",
    "Neurologist",
    "Orthopedic",
    "Pediatrician",
    "Dermatologist",
    "Oncologist",
    "Gynecologist",
    "ENT Specialist",
    "Radiologist",
    "General Physician"
]

doctors = []

for doctor_id in range(1, NUM_DOCTORS + 1):

    doctors.append({
        "doctor_id": doctor_id,
        "first_name": fake.first_name(),
        "last_name": fake.last_name(),
        "gender": random.choice(["Male", "Female"]),
        "department_id": random.randint(1, NUM_DEPARTMENTS),
        "specialization": random.choice(specializations),
        "experience_years": random.randint(1, 35),
        "phone": fake.phone_number(),
        "email": fake.email(),
        "joining_date": fake.date_between(start_date='-20y', end_date='today')
    })

df_doctors = pd.DataFrame(doctors)

df_doctors.to_csv("Dataset/doctors.csv", index=False)

print("Doctors generated successfully!")

# -------------------------------
# Generate Patients
# -------------------------------

blood_groups = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"]

patients = []

for patient_id in range(1, NUM_PATIENTS + 1):

    patients.append({
        "patient_id": patient_id,
        "first_name": fake.first_name(),
        "last_name": fake.last_name(),
        "gender": random.choice(["Male", "Female"]),
        "date_of_birth": fake.date_between(start_date='-80y', end_date='-1y'),
        "phone": fake.phone_number(),
        "email": fake.email(),
        "city": fake.city(),
        "blood_group": random.choice(blood_groups),
        "registration_date": fake.date_between(start_date='-2y', end_date='today')
    })

df_patients = pd.DataFrame(patients)

df_patients.to_csv("Dataset/patients.csv", index=False)

print("Patients generated successfully!")

# -------------------------------
# Generate Beds
# -------------------------------

ward_names = [
    "General Ward",
    "ICU",
    "Emergency",
    "Pediatric Ward",
    "Maternity Ward"
]

bed_types = [
    "General",
    "ICU",
    "Private",
    "Semi-Private"
]

beds = []

for bed_id in range(1, NUM_BEDS + 1):

    beds.append({
        "bed_id": bed_id,
        "ward_name": random.choice(ward_names),
        "room_number": random.randint(100, 500),
        "bed_type": random.choice(bed_types),
        "availability_status": random.choice(["Available", "Occupied"])
    })

df_beds = pd.DataFrame(beds)

df_beds.to_csv("Dataset/beds.csv", index=False)

print("Beds generated successfully!")

# -------------------------------
# Generate Appointments
# -------------------------------

appointment_types = [
    "Consultation",
    "Follow-up",
    "Emergency"
]

appointment_status = [
    "Completed",
    "Scheduled",
    "Cancelled"
]

appointments = []

for appointment_id in range(1, NUM_APPOINTMENTS + 1):

    appointments.append({
        "appointment_id": appointment_id,
        "patient_id": random.randint(1, NUM_PATIENTS),
        "doctor_id": random.randint(1, NUM_DOCTORS),
        "appointment_date": fake.date_between(start_date='-1y', end_date='today'),
        "appointment_time": fake.time(),
        "appointment_status": random.choice(appointment_status),
        "appointment_type": random.choice(appointment_types),
        "consultation_fee": random.choice([500,700,800,1000,1200])
    })

df_appointments = pd.DataFrame(appointments)

df_appointments.to_csv("Dataset/appointments.csv", index=False)

print("Appointments generated successfully!")

# -------------------------------
# Generate Billing
# -------------------------------

payment_methods = [
    "Cash",
    "UPI",
    "Credit Card",
    "Debit Card"
]

payment_status = [
    "Paid",
    "Pending"
]

billing = []

for bill_id in range(1, NUM_BILLS + 1):

    billing.append({
        "bill_id": bill_id,
        "appointment_id": bill_id,
        "total_amount": random.choice([500,700,900,1200,1500,2000]),
        "payment_method": random.choice(payment_methods),
        "payment_status": random.choice(payment_status),
        "billing_date": fake.date_between(start_date='-1y', end_date='today')
    })

df_billing = pd.DataFrame(billing)

df_billing.to_csv("Dataset/billing.csv", index=False)

print("Billing generated successfully!")

# -------------------------------
# Generate Admissions
# -------------------------------

admission_status = [
    "Admitted",
    "Discharged"
]

admissions = []

for admission_id in range(1, NUM_ADMISSIONS + 1):

    admission_date = fake.date_between(start_date='-1y', end_date='today')

    admissions.append({
        "admission_id": admission_id,
        "patient_id": random.randint(1, NUM_PATIENTS),
        "bed_id": random.randint(1, NUM_BEDS),
        "admission_date": admission_date,
        "discharge_date": fake.date_between(start_date=admission_date, end_date='today'),
        "admission_status": random.choice(admission_status)
    })

df_admissions = pd.DataFrame(admissions)

df_admissions.to_csv("Dataset/admissions.csv", index=False)

print("Admissions generated successfully!")

# -------------------------------
# Generate Medicines
# -------------------------------

medicine_categories = [
    "Tablet",
    "Capsule",
    "Injection",
    "Syrup"
]

medicines = []

for medicine_id in range(1, NUM_MEDICINES + 1):

    medicines.append({
        "medicine_id": medicine_id,
        "medicine_name": fake.word().capitalize(),
        "category": random.choice(medicine_categories),
        "unit_price": random.randint(10,500),
        "stock_quantity": random.randint(50,1000)
    })

df_medicines = pd.DataFrame(medicines)

df_medicines.to_csv("Dataset/medicines.csv", index=False)

print("Medicines generated successfully!")

# -------------------------------
# Generate Prescriptions
# -------------------------------

prescriptions = []

for prescription_id in range(1, NUM_PRESCRIPTIONS + 1):

    prescriptions.append({
        "prescription_id": prescription_id,
        "appointment_id": random.randint(1, NUM_APPOINTMENTS),
        "medicine_id": random.randint(1, NUM_MEDICINES),
        "quantity": random.randint(1,10),
        "dosage": random.choice([
            "Once Daily",
            "Twice Daily",
            "Three Times Daily"
        ])
    })

df_prescriptions = pd.DataFrame(prescriptions)

df_prescriptions.to_csv("Dataset/prescriptions.csv", index=False)

print("Prescriptions generated successfully!")

print("="*50)
print("Hospital Dataset Generated Successfully!")
print("="*50)
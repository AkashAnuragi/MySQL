-- ___________________________________ PROJECT 1: Hospital Management System  _____________________________________
-- Scenario : Design a system to manage patients, doctors, appointments, treatments, and billing.

CREATE DATABASE hospital_db; 
USE hospital_db;

CREATE TABLE patients ( 
patient_id INT PRIMARY KEY AUTO_INCREMENT, 
name VARCHAR(100) NOT NULL, 
age INT, 
gender VARCHAR(10), 
phone VARCHAR(15) UNIQUE 
);

CREATE TABLE doctors ( 
doctor_id INT PRIMARY KEY AUTO_INCREMENT, 
name VARCHAR(100), 
specialization VARCHAR(100), 
consultation_fee DECIMAL(10,2) 
);

CREATE TABLE appointments ( 
appointment_id INT PRIMARY KEY AUTO_INCREMENT, 
patient_id INT, 
doctor_id INT, 
appointment_date DATE, 
status VARCHAR(20), 
FOREIGN KEY (patient_id) REFERENCES patients(patient_id), 
FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) 
);

CREATE TABLE treatments ( 
treatment_id INT PRIMARY KEY AUTO_INCREMENT, 
appointment_id INT, 
description TEXT, 
cost DECIMAL(10,2), 
FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id) 
); 

CREATE TABLE bills ( 
bill_id INT PRIMARY KEY AUTO_INCREMENT, 
patient_id INT, 
total_amount DECIMAL(10,2), 
bill_date DATE, 
FOREIGN KEY (patient_id) REFERENCES patients(patient_id) 
);


INSERT INTO patients (name, age, gender, phone) VALUES
    ('Akash Anuragi',   23, 'Male',   '9876543210'),
    ('Priyaka Verma',    30, 'Female', '9812345678'),
    ('Rahul Ojha',    45, 'Male',   '9898989898'),
    ('Ayushi Garg',     28, 'Female', '9001234567'),
    ('Sagar Singh',  55, 'Male',   '9123456789');
    
INSERT INTO doctors (name, specialization, consultation_fee) VALUES
    ('Dr. Harshad Mehta', 'Cardiology',  800.00),
    ('Dr. Salman Khan','Neurology',700.00),
    ('Dr. Anil Kapoor', 'Cardiology',850.00),
    ('Dr. Aliya Bhatt', 'Orthopedics', 600.00),
    ('Dr. Akshay Kumar', 'General Medicine', 500.00);

INSERT INTO appointments (patient_id, doctor_id, appointment_date, status) VALUES
    (1, 1, '2025-06-01', 'Completed'),
    (2, 2, '2025-06-02', 'Completed'),
    (3, 1, '2025-06-03', 'Completed'),
    (1, 3, '2025-06-05', 'Completed'),
    (4, 4, '2025-06-06', 'Cancelled');
    -- patient_id 5 (Sagar Singh) has NO appointment → used in Q6

INSERT INTO treatments (appointment_id, description, cost) VALUES
    (1, 'ECG + Medication',        1500.00),
    (2, 'MRI Scan',                3000.00),
    (3, 'Stress Test + Medicines', 2000.00),
    (4, 'Angiography',             5000.00);
    -- appointment_id 5 (Cancelled) has no treatment
    
INSERT INTO bills (patient_id, total_amount, bill_date) VALUES
    (1, 0.00, '2025-06-01'),
    (2, 0.00, '2025-06-02'),
    (3, 0.00, '2025-06-03');

-- Basic  1. List all patients  
SELECT * FROM patients;

-- 2. Show all doctors with specialization = 'Cardiology' 
SELECT * FROM doctors
WHERE specialization = 'Cardiology';

-- Intermediate 3. Display all appointments with patient and doctor names  
SELECT p.name patient_name, d.name doctor_name, d.specialization,a.appointment_date, a.status FROM appointments a 
JOIN patients p ON p.patient_id = a.patient_id 
JOIN doctors d ON d.doctor_id = a.doctor_id
ORDER BY a.appointment_date;

-- 4. Find total number of appointments per doctor 
SELECT d.name doctor_name, count(a.appointment_date) as total_appointments FROM doctors d
JOIN appointments a ON d.doctor_id = a.doctor_id
Group by d.doctor_id, d.name
ORDER  BY total_appointments DESC ;

-- Advanced 
-- 5. Find total revenue generated per doctor  
-- 6. Find patients who never booked an appointment  
SELECT p.name,a.status FROM patients p 
LEFT JOIN appointments a ON p.patient_id = a.patient_id
Where a.appointment_id is NULL;

-- 7. Get top 3 highest billing patients 
SELECT p.name, SUM(b.total_amount) total_billed FROM patients p
JOIN bills b ON p.patient_id = b.patient_id
GROUP BY p.patient_id,p.name
ORDER by total_billed DESC
LIMIT 3;

-- Advanced Logic 8. Create a view: doctor_revenue_summary  
CREATE VIEW doctor_revenue_summary AS (
SELECT d.doctor_id, d.name, d.specialization, 
COUNT(a.appointment_id) total_appointments, 
COALESCE(SUM(t.cost),0) AS treatment_revenue, 
COUNT(a.appointment_id) * d.consultation_fee  AS consultation_revanue,
COALESCE(SUM(t.cost), 0) + COUNT(a.appointment_id) * d.consultation_fee AS total_revenue
FROM doctors d
LEFT JOIN appointments a ON d.doctor_id = a.doctor_id AND a.status = 'Completed'
LEFT JOIN treatments   t ON a.appointment_id = t.appointment_id
GROUP BY d.doctor_id, d.name, d.specialization, d.consultation_fee);

SELECT * FROM doctor_revenue_summary;

-- 9. Create a trigger to auto-add treatment cost into bill  
DELIMITER $$
 
CREATE TRIGGER after_treatment_insert
AFTER INSERT ON treatments
FOR EACH ROW
BEGIN
    DECLARE v_patient_id INT;
 
    -- Find which patient this appointment belongs to
    SELECT patient_id INTO v_patient_id
    FROM appointments
    WHERE appointment_id = NEW.appointment_id;
 
    -- Update (or create) the patient's bill
    IF EXISTS (
        SELECT 1 FROM bills WHERE patient_id = v_patient_id
    ) THEN
        UPDATE bills
        SET total_amount = total_amount + NEW.cost
        WHERE patient_id = v_patient_id;
    ELSE
        INSERT INTO bills (patient_id, total_amount, bill_date)
        VALUES (v_patient_id, NEW.cost, CURDATE());
    END IF;
END$$
DELIMITER ;
 
-- 10. Create a stored procedure to book appointment 

DELIMITER $$
 
CREATE PROCEDURE book_appointment(
    IN  p_patient_id  INT,
    IN  p_doctor_id   INT,
    IN  p_date        DATE,
    OUT p_appt_id     INT
)
BEGIN
    INSERT INTO appointments (patient_id, doctor_id, appointment_date, status)
    VALUES (p_patient_id, p_doctor_id, p_date, 'Scheduled');
 
    SET p_appt_id = LAST_INSERT_ID();
 
    SELECT CONCAT('Appointment booked successfully. ID = ', p_appt_id) AS message;
END$$ 
DELIMITER ;
 
 

select * from appointments ;
SELECT * FROM doctors;
SELECT * FROM patients;
SELECT * FROM bills;
-- Create db
CREATE DATABASE ITC5001_FINAL
DROP DATABASE ITC5001_FINAL
USE ITC5001_FINAL

-- Create tables
CREATE TABLE patient (
patient_id int primary key,
full_name varchar(20)
);


CREATE TABLE visit (
visit_id int primary key,
patient_id int,
registration_dt varchar(10),
discharge_dt varchar(10)
FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);


CREATE TABLE eventTable (
event_id int primary key,
patient_id int,
event_description varchar(20),
performed_dt varchar(20)
FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

-- Insert dummy values
INSERT INTO patient VALUES 
(100,'Natalie Jones'),
(101,'Mike Jin'),
(102,'Betty Hayes')

INSERT INTO visit VALUES 
(5001,100, '02-Dec-19','10-Dec-19'),
(5002,102, '02-Dec-19','20-Dec-19'),
(5003,101, '05-Dec-19','12-Dec-19'),
(5004,100, '12-Dec-19','13-Dec-19'),
(5005,102, '26-Dec-19','03-Jan-20')


INSERT INTO eventTable VALUES 
(111,100, 'Blood Pressure Check','03-Dec-19'),
(112,100, 'Blood Pressure Check','04-Dec-19'),
(113,100, 'Ultrasound','04-Dec-19'),
(114,100, 'Blood Pressure Check','05-Dec-19'),
(115,100, 'Ultrasound','06-Dec-19'),
(116,101, 'Blood Pressure Check','07-Dec-19'),
(117,101, 'Blood Pressure Check','09-Dec-19'),
(118,101, 'Ultrasound','11-Dec-19')


SELECT * FROM patient
SELECT * FROM eventTable
SELECT * FROM visit

-- Write a SQL statement to count the number of visits for each patient
SELECT full_name, count(*) as visit_count FROM patient p JOIN visit v
ON p.patient_id=v.patient_id GROUP BY full_name

-- Write a SQL statement to count the number of visits for each patient
SELECT * FROM patient p LEFT JOIN eventTable v
ON p.patient_id=v.patient_id WHERE event_id IS NULL

--Write a SQL statement to count the number of visits for each patient
SELECT TOP 1 * FROM patient p JOIN eventTable v
ON p.patient_id=v.patient_id where full_name='Mike Jin' ORDER BY event_id ASC

--Write a SQL statement to count the number of visits for each patient
SELECT TOP 1 event_description, COUNT(*) as times 
FROM eventTable 
GROUP BY event_description 
ORDER BY times desc

-- Write a SQL statement to count the number of visits for each patient
SELECT full_name, SUM(days_spent) AS total_days_in_hospital FROM 
(SELECT full_name, DATEDIFF(day,CAST(registration_dt as date), CAST(discharge_dt as date)) AS days_spent
FROM patient p JOIN visit v ON p.patient_id=v.patient_id) b 
GROUP BY full_name

--Write a SQL statement to determine the registration date that saw the highest number of patients in the hospital.
SELECT TOP 1 registration_dt, COUNT(*) 
AS no_of_patients 
FROM visit 
GROUP BY registration_dt 
ORDER BY COUNT(*) DESC

--Write a SQL statement to determine the registration date that saw the highest number of patients in the hospital.
SELECT full_name, 
LEFT(full_name,(CHARINDEX(' ', full_name)-1)) AS first_name, 
RIGHT(full_name, (CHARINDEX(' ', reverse(full_name))-1)) AS last_name
FROM patient

--Write a SQL statement to determine the registration date that saw the highest number of patients in the hospital.
SELECT full_name, event_description, performed_dt, ROW_NUMBER() 
OVER (order by performed_dt) AS row_count
FROM patient p JOIN eventTable e 
ON p.patient_id=e.patient_id
WHERE full_name='Natalie Jones'

--Write a SQL statement to display the following output using Ranking functions
SELECT full_name, event_description, performed_dt, DENSE_RANK() 
OVER (order by performed_dt) AS dense_rank
FROM patient p JOIN eventTable e 
ON p.patient_id=e.patient_id
WHERE full_name='Natalie Jones'


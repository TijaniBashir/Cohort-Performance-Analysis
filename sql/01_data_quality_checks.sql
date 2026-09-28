USE arel;

 -- 01_data_quality_checks
 -- purpose: check the underlying recods before trusting ang anysis built
 -- on them.
 -- attended data quality checks 
 -- Enrollments per status- unknown Records
 SELECT status, COUNT(*) AS total_enrolments
FROM enrolments
GROUP BY status;

-- 178/565 (31.5%) of the enrolments records are unknown

-- Attendance by status- not recorded
SELECT status,COUNT(*) AS total_attendance
FROM attendance
WHERE status= 'Not Recorded'
GROUP BY status;

-- 1873/58944 (3.2) of attendance records have status of Not recorded

-- Missing contact information for students
SELECT 
	SUM(email = '') missing_email,
    SUM(phone = '') missing_phone
FROM students;

-- 195/260 of students have missing contact information ( phone or email).

-- Decision made from these resuits
-- * not recorded attendance rows are excluded from attendance - rate calcculation
-- * unknown enrolments status is kept as its own category






-- 02_attendance_by_day_of_week
-- purpose: find which day of the week has the weakest
-- attendance, across every course and cohort in the program
SELECT DISTINCT status
FROM attendance;

SELECT 
	DAYNAME(session_date) day_of_week,
    SUM(status IN ('present', 'Late'))/ COUNT(*) AS attendance_rate
FROM attendance
WHERE status != 'Not recorded'
GROUP BY DAYNAME(session_date)
ORDER BY attendance_rate ASC;

-- Results: friday is weakest at 53.5%, monday strongestat 63.2%

-- attendance rate by day_of_weak in each cohort
WITH cohort_attendance AS(
SELECT c.cohort_label, 	DAYNAME(a.session_date) day_of_week,
SUM(a.status IN('Present', 'Late')) / COUNT(*) AS attendance_rate
FROM attendance a
JOIN enrolments e ON a.enrolment_id= e.enrolment_id
JOIN cohorts c ON e.cohort_id= e.cohort_id
WHERE a.status !=' Not Recorded'
GROUP BY c.cohort_label, DAYNAME(a.session_date)
)
SELECT cohort_label, day_of_week, attendance_rate,
RANK() OVER(PARTITION BY cohort_label ORDER BY attendance_rate) rank_
FROM cohort_attendance;

-- Friday has the weakest attendance rate across ALL cohort
-- attendance by month of year
-- attendance by schedule (MWF Vs MTWTF)



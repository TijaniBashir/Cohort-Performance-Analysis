USE arel;
-- 08_course_cohort_ranking.sql
-- purpose: rank every course/cohort combination that has run in the program 
-- by attendance rate, alongside its completion rate, to spot with specific 
-- offerings are underperforming and whether any course repeats near the bottom across mutiple cohorts.

WITH att AS(
	SELECT
    e.course_id,
    e.cohort_id,
    c.course_name,
    ROUND(100.0 * SUM(a.status IN('present', 'Late')) / COUNT(*), 1) AS attendance_rate
    
    FROM enrolments e
    JOIN courses c USING(course_id)
    JOIN attendance a USING(enrolment_id)
    WHERE a.status != 'Not Recorded'
    GROUP BY  e.course_id, e.cohort_id, course_name
),
comp AS(
	SELECT
	e.course_id,
    e.cohort_id,
    c.course_name,
    ROUND(100.0 *SUM(e.status= 'Completed') / COUNT(*), 1) AS completion_rate,
    COUNT(*)  AS enrolled
    FROM enrolments e
    GROUP BY e.course_id, e.cohort_id, course_name
)
SELECT
att.course_name,
att.cohort_id,
att.attendance_rate,
com.completion_rate,
comp.enrolled
FROM att
JOIN comp USING(course_id, cohort_id)
ORDER BY att.attendance_rate ASC;

-- Results: Data Analysis appear twice in the  weakest five (cohort 4 and 
-- cohort 5), suggesting a course level pattern, 





    
    
    




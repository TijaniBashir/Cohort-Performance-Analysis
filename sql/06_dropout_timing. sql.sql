USE arel;

-- dropout_timing.sql
--
-- question
-- is there pattern in attendance before students drop out
-- we compare attendance in the final 30 days before student's
-- last recoded attendance with  their attendance earlier in the course
WITH last_attendance AS(
-- Find the last attendance date for each students who eventually dropped out
SELECT a.attendance_id,

-- 
-- Results
-- Attendace drops sharply before students leave
-- attendance is 53.8% earlie in the course but fall to
-- 16.6% inthe final 30days before their last recorded attendance.
--
-- This show that declining attendance is a clear pattern
-- among students who eventually dropped out






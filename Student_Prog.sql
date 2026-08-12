CREATE VIEW university.StudentProgress AS
SELECT s.student_id, 
       s.first_name + ' ' + s.last_name AS student_name,
       d.name,
       COUNT(e.enrollment_id) AS courses_taken,
       SUM(CASE WHEN e.grade IS NULL THEN 1 ELSE 0 END) AS courses_in_progress,
       AVG(CASE WHEN e.grade = 'A' THEN 4.0
                WHEN e.grade = 'A-' THEN 3.7
                WHEN e.grade = 'B+' THEN 3.3
                WHEN e.grade = 'B' THEN 3.0
                WHEN e.grade = 'B-' THEN 2.7
                WHEN e.grade = 'C+' THEN 2.3
                WHEN e.grade = 'C' THEN 2.0
                WHEN e.grade = 'D' THEN 1.0
                ELSE 0 END) AS cumulative_gpa,
       SUM(c.credits) AS total_credits_earned
FROM university.Student s
JOIN university.Department d ON s.department_id = d.department_id
LEFT JOIN university.Enrollment e ON s.student_id = e.student_id
LEFT JOIN university.Course c ON e.course_id = c.course_id
WHERE e.grade IS NOT NULL AND e.grade != 'F'
GROUP BY s.student_id, s.first_name, s.last_name, d.name;


USE university
GO

-- Simple query to get all data from the view
SELECT * FROM university.StudentProgress
GO

SELECT * FROM university.StudentProgress
ORDER BY name, cumulative_gpa DESC


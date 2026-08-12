CREATE VIEW university.InstructorLoad AS
SELECT p.professor_id,
       p.first_name + ' ' + p.last_name AS professor_name,
       d.name,
       COUNT(DISTINCT s.section_id) AS current_sections,
       COUNT(DISTINCT CASE WHEN e.grade IS NULL THEN s.section_id END) AS active_sections,
       COUNT(DISTINCT e.student_id) AS total_students,
       AVG(CASE WHEN e.grade = 'A' THEN 4.0
                WHEN e.grade = 'A-' THEN 3.7
                WHEN e.grade = 'B+' THEN 3.3
                WHEN e.grade = 'B' THEN 3.0
                WHEN e.grade = 'B-' THEN 2.7
                WHEN e.grade = 'C+' THEN 2.3
                WHEN e.grade = 'C' THEN 2.0
                ELSE NULL END) AS avg_grade_points
FROM university.Professor p
JOIN university.Department d ON p.department_id = d.department_id
LEFT JOIN university.Section s ON p.professor_id = s.instructor_id
LEFT JOIN university.Enrollment e ON s.section_id = e.section_id
GROUP BY p.professor_id, p.first_name, p.last_name, d.name;


SELECT * FROM university.InstructorLoad
ORDER BY name, professor_name;

SELECT professor_name, name, current_sections, total_students
FROM university.InstructorLoad
ORDER BY total_students DESC;


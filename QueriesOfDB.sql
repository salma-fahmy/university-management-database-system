USE university
Go

-- professors teaching multiple courses with average student grades
SELECT p.professor_id, p.first_name, p.last_name,
       COUNT(DISTINCT s.section_id) AS num_courses_teaching,
       AVG(CASE WHEN e.grade = 'A' THEN 4.0
                WHEN e.grade = 'A-' THEN 3.7
                WHEN e.grade = 'B+' THEN 3.3
                WHEN e.grade = 'B' THEN 3.0
                WHEN e.grade = 'B-' THEN 2.7
                WHEN e.grade = 'C+' THEN 2.3
                WHEN e.grade = 'C' THEN 2.0
                ELSE 0 END) AS avg_grade_points
FROM university.Professor p
JOIN university.Section s ON p.professor_id = s.instructor_id
LEFT JOIN university.Enrollment e ON s.section_id = e.section_id
GROUP BY p.professor_id, p.first_name, p.last_name
HAVING COUNT(DISTINCT s.section_id) > 1
ORDER BY avg_grade_points DESC;

-- Computer Science TAs:
SELECT 
    ta.ta_id,
    ta.ta_name,
    c.course_name,
    sec.day_of_week + ' at ' + CONVERT(VARCHAR, sec.start_time, 108) AS schedule,
    COUNT(e.student_id) AS number_of_students
FROM 
    university.TeachingAssistant ta
JOIN 
    university.Section sec ON ta.ta_id = sec.teaching_assistant_id
JOIN 
    university.Course c ON sec.course_id = c.course_id
JOIN 
    university.Department d ON c.department_id = d.department_id
LEFT JOIN 
    university.Enrollment e ON sec.section_id = e.section_id
WHERE 
    d.name = 'Computer Science'
GROUP BY 
    ta.ta_id, ta.ta_name, c.course_name, sec.day_of_week, sec.start_time
ORDER BY 
    number_of_students DESC;

-- Computer Science Students and Their Courses
SELECT 
    s.student_id,
    s.first_name + ' ' + s.last_name AS student_name,
    c.course_name,
    p.first_name + ' ' + p.last_name AS professor_name
FROM 
    university.Student s
JOIN 
    university.Enrollment e ON s.student_id = e.student_id
JOIN 
    university.Course c ON e.course_id = c.course_id
JOIN 
    university.Section sec ON e.section_id = sec.section_id
JOIN 
    university.Professor p ON sec.instructor_id = p.professor_id
JOIN 
    university.Department d ON s.department_id = d.department_id
WHERE 
    d.name = 'Computer Science'
ORDER BY 
    student_name, course_name;


-- Literature Students and Their Courses
SELECT 
    s.student_id,
    s.first_name + ' ' + s.last_name AS student_name,
    c.course_name,
    p.first_name + ' ' + p.last_name AS professor_name
FROM 
    university.Student s
JOIN 
    university.Enrollment e ON s.student_id = e.student_id
JOIN 
    university.Course c ON e.course_id = c.course_id
JOIN 
    university.Section sec ON e.section_id = sec.section_id
JOIN 
    university.Professor p ON sec.instructor_id = p.professor_id
JOIN 
    university.Department d ON s.department_id = d.department_id
WHERE 
    d.name = 'Literature'
ORDER BY 
    student_name, course_name;

-- Fine Arts Students and Their Courses
SELECT 
    s.student_id,
    s.first_name + ' ' + s.last_name AS student_name,
    c.course_name,
    p.first_name + ' ' + p.last_name AS professor_name
FROM 
    university.Student s
JOIN 
    university.Enrollment e ON s.student_id = e.student_id
JOIN 
    university.Course c ON e.course_id = c.course_id
JOIN 
    university.Section sec ON e.section_id = sec.section_id
JOIN 
    university.Professor p ON sec.instructor_id = p.professor_id
JOIN 
    university.Department d ON s.department_id = d.department_id
WHERE 
    d.name = 'Fine Arts'
ORDER BY 
    student_name, course_name;


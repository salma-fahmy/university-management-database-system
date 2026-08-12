USE university;
GO

-- Drop tables in correct order (due to foreign key dependencies)
DROP TABLE IF EXISTS university.Schedule;
DROP TABLE IF EXISTS university.Course_Prerequisite;
DROP TABLE IF EXISTS university.Enrollment;
DROP TABLE IF EXISTS university.Section;
DROP TABLE IF EXISTS university.TeachingAssistant;
DROP TABLE IF EXISTS university.Course;
DROP TABLE IF EXISTS university.Student;
DROP TABLE IF EXISTS university.Professor;
DROP TABLE IF EXISTS university.Department;
GO

DROP SCHEMA IF EXISTS university;
GO

-- The schema
CREATE SCHEMA university;
GO


-- Department Table
CREATE TABLE university.Department (
    department_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
)
GO

-- Professor Table
CREATE TABLE university.Professor (
    professor_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(255) UNIQUE NOT NULL,
    department_id INT FOREIGN KEY REFERENCES university.Department(department_id)
)
GO


-- Student Table
CREATE TABLE university.Student (
    student_id INT PRIMARY KEY, 
    first_name VARCHAR(50),
    last_name VARCHAR(50),
	email VARCHAR(255) UNIQUE NOT NULL,
	department_id INT FOREIGN KEY REFERENCES university.Department(department_id),
    enrollment_year DATE  -- The day the student's academic record is formally created
)
GO

-- Course Table
CREATE TABLE university.Course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT,
    department_id INT FOREIGN KEY REFERENCES university.Department(department_id)
)
GO

-- Teaching Assistant Table
CREATE TABLE university.TeachingAssistant (
    ta_id INT PRIMARY KEY,
	student_id INT NULL FOREIGN KEY REFERENCES university.Student(student_id),
    ta_name VARCHAR(100)
);
Go  

-- Section Table
CREATE TABLE university.Section (
    section_id INT PRIMARY KEY,
    course_id INT FOREIGN KEY REFERENCES university.Course(course_id),
    instructor_id INT FOREIGN KEY REFERENCES university.Professor(professor_id),
    teaching_assistant_id INT FOREIGN KEY REFERENCES university.TeachingAssistant(ta_id),  -- TA from TeachingAssistant table
    room VARCHAR(20),
    day_of_week VARCHAR(10),
    start_time TIME
);
GO

-- Enrollment Table (Many-to-Many: Student <-> Course)
CREATE TABLE university.Enrollment (
    enrollment_id INT PRIMARY KEY,
    student_id INT FOREIGN KEY REFERENCES university.Student(student_id),
    course_id INT FOREIGN KEY REFERENCES university.Course(course_id),
	section_id INT FOREIGN KEY REFERENCES university.Section(section_id),
    enrollment_date DATE,
    grade VARCHAR(2)
)
GO

-- Course Prerequisite Table
CREATE TABLE university.Course_Prerequisite (
    course_id INT,
    prerequisite_course_id INT,
    PRIMARY KEY (course_id, prerequisite_course_id),
    FOREIGN KEY (course_id) REFERENCES university.Course(course_id),
    FOREIGN KEY (prerequisite_course_id) REFERENCES university.Course(course_id)
)
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'university')
BEGIN
    PRINT 'The university database exists.'
END
ELSE
BEGIN
    PRINT 'The university database does NOT exist.'
END

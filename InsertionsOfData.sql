USE university
Go
-- Departments
INSERT INTO university.Department VALUES 
(1, 'Computer Science'),
(2, 'Literature'),
(3, 'Fine Arts');
GO

-- Insert Professors 
INSERT INTO university.Professor VALUES
(101, 'Amr', 'Hassan', 'amrhassan101@uni.edu', 1),
(102, 'Nadia', 'Emam', 'nadiaemam102@uni.edu', 1),
(103, 'Nadine', 'Ahmed', 'nadineahmed103@uni.edu', 1),
(104, 'Kareem', 'Medhat', 'karimmedhat@uni.edu', 1),
(201, 'Michael', 'Mansy', 'michaelmansy@uni.edu', 2),
(202, 'Sarah', 'Elsayed', 'saraelsayed@uni.edu', 2),
(203, 'Hazem', 'Samir', 'hazemsamir@uni.edu', 2),
(301, 'Mohammed', 'Zayed', 'mohammedzayed@uni.edu', 3),
(302, 'Rania', 'Tameem', 'raniatameem@uni.edu', 3);
GO

-- Students
INSERT INTO university.Student VALUES
(1, 'Ahmed', 'Hassan', 'ahmedhassan@uni.edu', 1, '2022-10-01'),
(2, 'Fatima', 'Ali', 'fatimaali@uni.edu', 1, '2021-10-01'),
(3, 'Omar', 'Khaled', 'omarkhaled@uni.edu', 1, '2021-10-01'),
(4, 'Layla', 'Youssef', 'laylayoussef@uni.edu', 1, '2023-10-01'),
(5, 'Mohammed', 'Saleh', 'mohammedsaleh@uni.edu', 1, '2023-10-01'),
(6, 'Sara', 'Nabil', 'saranabil@uni.edu', 3, '2021-10-01'),
(7, 'Huda', 'Mahmoud', 'hudamahmoud@uni.edu', 1, '2022-10-01'),
(8, 'Khaled', 'Saad', 'khaledsaad@uni.edu', 3, '2021-10-01'),
(9, 'Nour', 'Fahmy', 'nourfahmy@uni.edu', 3, '2020-10-01'),
(10, 'Rami', 'Abdullah', 'ramiabdullah@uni.edu', 1, '2024-10-01'),
(11, 'Amina', 'Tarek', 'aminatarek@uni.edu', 2, '2021-10-01'),
(12, 'Zain', 'Adel', 'zainadel@uni.edu', 3, '2022-10-01'),
(13, 'Yasmin', 'Othman', 'yasminothman@uni.edu', 1, '2023-10-01'),
(14, 'Bassel', 'Nasser', 'basselnasser@uni.edu', 2, '2021-10-01'),
(15, 'Dina', 'Samir', 'dinasamir@uni.edu', 3, '2021-10-01'),
(16, 'Tariq', 'Hussein', 'tariqhussein@uni.edu', 1, '2023-10-01'),
(17, 'Salma', 'Ibrahim', 'salmaibrahim@uni.edu', 2, '2022-10-01'),
(18, 'Walid', 'Reda', 'walidreda@uni.edu', 3, '2024-10-01'),
(19, 'Lina', 'Amer', 'linaamer@uni.edu', 1, '2021-10-01'),
(20, 'Mustafa', 'Kamal', 'mustafakamal@uni.edu', 2, '2022-10-01');
Go

-- Courses
INSERT INTO university.Course VALUES
-- Computer Science Courses
(10001, 'Introduction to Programming', 3, 1),
(10002, 'Data Structures and Algorithms', 3, 1),
(10003, 'Database Systems', 3, 1),
(10004, 'Operating Systems', 3, 1),
(10005, 'Computer Networks', 3, 1),

-- Literature Courses
(20001, 'Introduction to Literature', 3, 2),
(20002, 'English Literature', 3, 2),
(20003, 'Modern Poetry', 3, 2),
(20004, 'World Literature', 3, 2),
(20005, 'Shakespearean Plays', 3, 2),

-- Fine Arts Courses
(30001, 'Basic Drawing', 3, 3),
(30002, 'Art History', 3, 3),
(30003, 'Sculpture and 3D Design', 3, 3),
(30004, 'Painting Techniques', 3, 3),
(30005, 'Photography', 3, 3);
GO

--  Course Prerequisites
INSERT INTO university.Course_Prerequisite VALUES
-- Computer Science Prerequisites
(10002, 10001),  -- Data Structures needs Introduction to Programming
(10005, 10004),  -- Computer Networks needs Operating Systems

-- Literature Prerequisites
(20002, 20001),  -- English Literature needs Introduction to Literature
(20004, 20001),  -- World Literature needs Introduction to Literature
(20005, 20004),  -- Shakespearean Plays needs World Literature

-- Fine Arts Prerequisites
(30004, 30001),  -- Painting Techniques needs Basic Drawing
(30005, 30004);  -- Photography needs Painting Techniques
GO

-- Teaching Assistants (including external TAs)
INSERT INTO university.TeachingAssistant (ta_id, student_id, ta_name)
VALUES
-- University Students (from 2021 enrollment)
(11101, 2, 'Fatima Ali'),
(11102, 3, 'Omar Khaled'),
(11103, 6, 'Sara Nabil'),
(11104, 8, 'Khaled Saad'),
(11105, 11, 'Amina Tarek'),
(11106, 14, 'Bassel Nasser'),
(11107, 15, 'Dina Samir'),
(11108, 19, 'Lina Amer'),

-- External Teaching Assistants (not university students)
(22201, NULL, 'Ahmed El-Gazzar'),  -- External TA for Computer Science
(22202, NULL, 'Mona Hassan'),     -- External TA for Literature
(22203, NULL, 'Ali Fathy'),       -- External TA for Fine Arts
(22204, NULL, 'Rania Youssef');   -- External TA for Literature
GO

-- Sections for Courses
INSERT INTO university.Section VALUES
-- Computer Science Sections
(1, 10001, 101, 11101, 'Room 101', 'Monday', '10:00:00'),  -- Introduction to Programming (TA: Fatima Ali)
(2, 10002, 102, 11102, 'Room 102', 'Tuesday', '11:00:00'), -- Data Structures and Algorithms (TA: Omar Khaled)
(3, 10003, 103, 11103, 'Room 103', 'Wednesday', '14:00:00'), -- Database Systems (TA: Sara Nabil)
(4, 10004, 104, 11104, 'Room 104', 'Thursday', '09:00:00'), -- Operating Systems (TA: Khaled Saad)
(5, 10005, 101, 11105, 'Room 105', 'Friday', '10:00:00'), -- Computer Networks (TA: Amina Tarek)

-- Literature Sections
(6, 20001, 201, 22202, 'Room 201', 'Monday', '13:00:00'), 
(7, 20002, 202, 22202, 'Room 202', 'Tuesday', '12:00:00'), 
(8, 20003, 203, 22204, 'Room 203', 'Wednesday', '15:00:00'), 
(9, 20004, 201, 22204, 'Room 204', 'Friday', '10:00:00'), 
(10, 20005, 202, 22204, 'Room 205', 'Thursday', '14:00:00'), 

-- Fine Arts Sections
(11, 30001, 301, 22203, 'Room 301', 'Monday', '09:00:00'), 
(12, 30002, 302, 22203, 'Room 302', 'Thursday', '13:00:00'), 
(13, 30003, 301, 22203, 'Room 303', 'Tuesday', '11:00:00'), 
(14, 30004, 302, 22203, 'Room 304', 'Friday', '12:00:00'), 
(15, 30005, 301, 22203, 'Room 305', 'Wednesday', '10:00:00'); 
GO

-- Enrollment Data
INSERT INTO university.Enrollment VALUES
-- Computer Science Enrollments
-- Introduction to Programming (Course 10001, Section 1)
(1, 1, 10001, 1, '2023-09-01', 'A'),
(2, 2, 10001, 1, '2021-09-01', 'A-'),
(3, 3, 10001, 1, '2021-09-01', 'B+'),
(4, 4, 10001, 1, '2023-09-01', 'B'),
(5, 5, 10001, 1, '2023-09-01', 'C+'),
(6, 7, 10001, 1, '2022-09-01', 'A'),
(7, 10, 10001, 1, '2024-09-01', NULL),
(8, 13, 10001, 1, '2023-09-01', 'A-'),
(9, 16, 10001, 1, '2023-09-01', 'B+'),
(10, 19, 10001, 1, '2021-09-01', 'A'),

-- Data Structures and Algorithms (Course 10002, Section 2)
(11, 1, 10002, 2, '2023-09-01', 'B+'),
(12, 2, 10002, 2, '2022-09-01', 'A'),
(13, 3, 10002, 2, '2022-09-01', 'A-'),
(14, 7, 10002, 2, '2023-09-01', 'B'),
(15, 19, 10002, 2, '2022-09-01', 'A'),

-- Database Systems (Course 10003, Section 3)
(16, 1, 10003, 3, '2024-01-15', 'A'),
(17, 2, 10003, 3, '2023-01-15', 'A-'),
(18, 3, 10003, 3, '2023-01-15', 'B+'),
(19, 7, 10003, 3, '2024-01-15', NULL),
(20, 19, 10003, 3, '2023-01-15', 'A'),

-- Operating Systems (Course 10004, Section 4)
(21, 2, 10004, 4, '2024-01-15', 'A'),
(22, 3, 10004, 4, '2024-01-15', 'B+'),
(23, 19, 10004, 4, '2024-01-15', 'A-'),

-- Computer Networks (Course 10005, Section 5)
(24, 2, 10005, 5, '2024-09-01', NULL),
(25, 19, 10005, 5, '2024-09-01', NULL),

-- Literature Enrollments
-- Introduction to Literature (Course 20001, Section 6)
(26, 11, 20001, 6, '2021-09-01', 'A'),
(27, 14, 20001, 6, '2021-09-01', 'B'),
(28, 17, 20001, 6, '2022-09-01', 'A-'),
(29, 20, 20001, 6, '2022-09-01', 'B+'),

-- English Literature (Course 20002, Section 7)
(30, 11, 20002, 7, '2022-09-01', 'A'),
(31, 14, 20002, 7, '2022-09-01', 'B+'),
(32, 17, 20002, 7, '2023-09-01', 'A-'),
(33, 20, 20002, 7, '2023-09-01', 'B'),

-- Modern Poetry (Course 20003, Section 8)
(34, 11, 20003, 8, '2023-09-01', 'A'),
(35, 17, 20003, 8, '2024-01-15', NULL),

-- World Literature (Course 20004, Section 9)
(36, 11, 20004, 9, '2024-01-15', NULL),
(37, 14, 20004, 9, '2023-09-01', 'A-'),
(38, 17, 20004, 9, '2024-09-01', NULL),

-- Shakespearean Plays (Course 20005, Section 10)
(39, 11, 20005, 10, '2024-09-01', NULL),

-- Fine Arts Enrollments
-- Basic Drawing (Course 30001, Section 11)
(40, 6, 30001, 11, '2021-09-01', 'A'),
(41, 8, 30001, 11, '2021-09-01', 'B+'),
(42, 9, 30001, 11, '2020-09-01', 'A'),
(43, 12, 30001, 11, '2022-09-01', 'A-'),
(44, 15, 30001, 11, '2021-09-01', 'B'),
(45, 18, 30001, 11, '2024-09-01', NULL),

-- Art History (Course 30002, Section 12)
(46, 6, 30002, 12, '2022-09-01', 'A'),
(47, 8, 30002, 12, '2022-09-01', 'B+'),
(48, 9, 30002, 12, '2021-09-01', 'A-'),
(49, 12, 30002, 12, '2023-09-01', 'B'),
(50, 15, 30002, 12, '2022-09-01', 'A'),

-- Sculpture and 3D Design (Course 30003, Section 13)
(51, 6, 30003, 13, '2023-09-01', 'A'),
(52, 9, 30003, 13, '2022-09-01', 'A-'),
(53, 12, 30003, 13, '2024-01-15', NULL),
(54, 15, 30003, 13, '2023-09-01', 'B+'),

-- Painting Techniques (Course 30004, Section 14)
(55, 6, 30004, 14, '2024-01-15', NULL),
(56, 9, 30004, 14, '2023-09-01', 'A'),
(57, 15, 30004, 14, '2024-09-01', NULL),

-- Photography (Course 30005, Section 15)
(58, 9, 30005, 15, '2024-09-01', NULL),

-- Cross-disciplinary enrollments (students taking courses outside their department)
-- Computer Science student taking Fine Arts course
(59, 1, 30001, 11, '2023-09-01', 'B'),

-- Literature student taking Computer Science course
(60, 11, 10001, 1, '2022-09-01', 'C'),

-- Fine Arts student taking Literature course
(61, 6, 20001, 6, '2021-09-01', 'A-');
GO
IF OBJECT_ID('university.fn_GetStudentEnrollmentSummary', 'FN') IS NOT NULL
    DROP FUNCTION university.fn_GetStudentEnrollmentSummary;
GO

CREATE FUNCTION university.fn_GetStudentEnrollmentSummary
(
    @student_id INT
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @full_name NVARCHAR(100);
    DECLARE @course_count INT;
    DECLARE @total_credits DECIMAL(10, 2);
    DECLARE @result NVARCHAR(MAX);
    DECLARE @course_names NVARCHAR(100);

    -- Get full name
    SELECT @full_name = first_name + ' ' + last_name
    FROM university.Student
    WHERE student_id = @student_id;

    -- Check if student exists
    IF @full_name IS NULL
    BEGIN
        SET @result = 'Student with ID ' + CAST(@student_id AS NVARCHAR) + ' not found.';
        RETURN @result;
    END

    -- Count enrolled courses
    SELECT @course_count = COUNT(*)
    FROM university.Enrollment
    WHERE student_id = @student_id;

    -- If the student is not enrolled in any courses
    IF @course_count = 0
    BEGIN
        SET @result = 'Student with ID ' + CAST(@student_id AS NVARCHAR) + ' is not enrolled in any courses.';
        RETURN @result;
    END

    -- Calculate total course credits
    SELECT @total_credits = ISNULL(SUM(c.credits), 0)
    FROM university.Enrollment e
    JOIN university.Course c ON e.course_id = c.course_id
    WHERE e.student_id = @student_id;

    -- Get course names
    SELECT @course_names = STRING_AGG(c.course_name, ', ')
    FROM university.Enrollment e
    JOIN university.Course c ON e.course_id = c.course_id
    WHERE e.student_id = @student_id;

    -- Combine results
    SET @result = 'Student: ' + @full_name +
                  ' | Courses Enrolled: ' + CAST(@course_count AS NVARCHAR) +
                  ' | Total credits: ' + CAST(@total_credits AS NVARCHAR) +
                  ' | Courses: ' + ISNULL(@course_names, 'No courses found.');

    RETURN @result;
END;
GO
-- Drop the function if it already exists
IF OBJECT_ID('university.fn_GetStudentGPA', 'FN') IS NOT NULL
    DROP FUNCTION university.fn_GetStudentGPA;
GO

-- Create the GPA calculation function
CREATE FUNCTION university.fn_GetStudentGPA
(
    @student_id INT
)
RETURNS FLOAT
AS
BEGIN
    DECLARE @GPA FLOAT;

    -- Check if the student exists
    IF NOT EXISTS (SELECT 1 FROM university.Student WHERE student_id = @student_id)
    BEGIN
        RETURN NULL;  -- Return NULL if student does not exist
    END

    -- Calculate GPA
    SELECT @GPA = AVG(
        CASE grade
            WHEN 'A' THEN 4.0
            WHEN 'B' THEN 3.0
            WHEN 'C' THEN 2.0
            WHEN 'D' THEN 1.0
            WHEN 'F' THEN 0.0
            ELSE NULL -- for ungraded or unknown grades
        END
    )
    FROM university.Enrollment
    WHERE student_id = @student_id;

    -- If no GPA was calculated, return NULL
    IF @GPA IS NULL
    BEGIN
        RETURN NULL;  -- Return NULL if GPA could not be calculated
    END

    RETURN @GPA;
END;
GO
-- Get enrollment summary for student with ID 1
SELECT university.fn_GetStudentEnrollmentSummary(1) AS Summary;

-- Get GPA for student with ID 1
SELECT university.fn_GetStudentGPA(1) AS GPA;

-- Try an invalid student ID to see the error handling
SELECT university.fn_GetStudentEnrollmentSummary(100) AS Summary; -- Returns 'Student not found'
SELECT university.fn_GetStudentGPA(100) AS GPA; -- Returns NULL

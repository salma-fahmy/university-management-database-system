
-- Drop if exists
IF OBJECT_ID('university.sp_RegisterStudentInSection', 'P') IS NOT NULL
    DROP PROCEDURE university.sp_RegisterStudentInSection;
GO

CREATE PROCEDURE university.sp_RegisterStudentInSection
    @student_id INT,
    @course_id INT,
    @section_id INT,
    @message NVARCHAR(255) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @course_name NVARCHAR(100);

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Check if student is already enrolled
        IF EXISTS (
            SELECT 1 FROM university.Enrollment
            WHERE student_id = @student_id AND course_id = @course_id
        )
        BEGIN
            SET @message = 'Student is already enrolled in this course.';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Check course and section validity
        SELECT @course_name = course_name FROM university.Course WHERE course_id = @course_id;
        IF @course_name IS NULL
        BEGIN
            SET @message = 'Course does not exist.';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM university.Section WHERE section_id = @section_id AND course_id = @course_id)
        BEGIN
            SET @message = 'Section does not exist for this course.';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Insert enrollment
        INSERT INTO university.Enrollment (enrollment_id, student_id, course_id, section_id, enrollment_date, grade)
        VALUES (
            (SELECT ISNULL(MAX(enrollment_id), 0) + 1 FROM university.Enrollment),
            @student_id,
            @course_id,
            @section_id,
            GETDATE(),
            NULL
        );

        SET @message = 'Student successfully enrolled in course: ' + @course_name;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Error handling and rollback
        ROLLBACK TRANSACTION;
        SET @message = ERROR_MESSAGE();
        RAISERROR('Error in sp_RegisterStudentInSection: %s', 16, 1, @message);
    END CATCH
END;
GO




DECLARE @msg NVARCHAR(255);
EXEC university.sp_RegisterStudentInSection
    @student_id = 4,
    @course_id = 10005,
    @section_id = 5,
    @message = @msg OUTPUT;

PRINT @msg;




ALTER TABLE university.Enrollment
ADD fees DECIMAL(10, 2) DEFAULT 1000.00;

UPDATE university.Enrollment
SET fees = 1000.00
WHERE fees IS NULL;




-- Add the 'discount_applied' column to the Enrollment table
ALTER TABLE university.Enrollment
ADD discount_applied BIT DEFAULT 0;
GO

-- Drop if exists
IF OBJECT_ID('university.sp_ApplyDiscountToEnrollment', 'P') IS NOT NULL
    DROP PROCEDURE university.sp_ApplyDiscountToEnrollment;
GO

-- Create the procedure to apply discount
CREATE PROCEDURE university.sp_ApplyDiscountToEnrollment
    @student_id INT,
    @course_id INT,
    @discount_percent DECIMAL(5, 2),
    @message NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Check if the student is enrolled in the course
        IF NOT EXISTS (
            SELECT 1 FROM university.Enrollment
            WHERE student_id = @student_id AND course_id = @course_id
        )
        BEGIN
            SET @message = 'Enrollment not found.';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Check if the discount has already been applied
        IF EXISTS (
            SELECT 1 FROM university.Enrollment
            WHERE student_id = @student_id AND course_id = @course_id AND discount_applied = 1
        )
        BEGIN
            SET @message = 'Discount has already been applied for this course.';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Apply the discount to the enrollment fees
        UPDATE university.Enrollment
        SET fees = fees - (fees * @discount_percent / 100),
            discount_applied = 1
        WHERE student_id = @student_id AND course_id = @course_id;

        SET @message = 'Discount applied successfully.';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Error handling and rollback
        ROLLBACK TRANSACTION;
        SET @message = 'Error applying discount: ' + ERROR_MESSAGE();
        RAISERROR('Error in sp_ApplyDiscountToEnrollment: %s', 16, 1, @message);
    END CATCH
END;
GO




DECLARE @message NVARCHAR(200);
EXEC university.sp_ApplyDiscountToEnrollment
    @student_id = 2,
    @course_id = 10001,
    @discount_percent = 10,
    @message = @message OUTPUT;

PRINT @message;

SELECT * FROM university.Enrollment WHERE student_id = 2;
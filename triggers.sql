-- Create a log table for name changes
CREATE TABLE university.Student_Name_Change_Log (
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    student_id INT,
    old_first_name VARCHAR(50),
    old_last_name VARCHAR(50),
    new_first_name VARCHAR(50),
    new_last_name VARCHAR(50),
    change_date DATETIME DEFAULT GETDATE()
);
GO




-- Drop the trigger if it already exists
IF OBJECT_ID('university.trg_StudentNameUpdate', 'TR') IS NOT NULL
    DROP TRIGGER university.trg_StudentNameUpdate;
GO

-- Create the AFTER UPDATE trigger with error handling
CREATE TRIGGER university.trg_StudentNameUpdate
ON university.Student
FOR UPDATE
AS
BEGIN
    BEGIN TRY
        -- Ensure the update is for name change (either first or last name)
        IF UPDATE(first_name) OR UPDATE(last_name)
        BEGIN
            INSERT INTO university.Student_Name_Change_Log (student_id, old_first_name, old_last_name, new_first_name, new_last_name)
            SELECT 
                inserted.student_id, 
                deleted.first_name, 
                deleted.last_name, 
                inserted.first_name, 
                inserted.last_name
            FROM inserted
            JOIN deleted ON inserted.student_id = deleted.student_id;
        END
    END TRY
    BEGIN CATCH
        -- Capture any errors and provide a message
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(), 
            @ErrorSeverity = ERROR_SEVERITY(), 
            @ErrorState = ERROR_STATE();

        -- Log the error to a log table for tracking purposes
        INSERT INTO university.Error_Log (error_message, error_severity, error_state, error_date)
        VALUES (@ErrorMessage, @ErrorSeverity, @ErrorState, GETDATE());

        -- Raise the error back to the calling application
        RAISERROR('Error occurred in trg_StudentNameUpdate: %s', @ErrorSeverity, @ErrorState, @ErrorMessage);
    END CATCH
END;
GO


-- Update a student's name
UPDATE university.Student
SET first_name = 'mai', last_name = 'mahmoud'
WHERE student_id = 2;

-- Check the log for changes
SELECT * FROM university.Student_Name_Change_Log ORDER BY change_date DESC;



SELECT * FROM university.Student_Name_Change_Log;



CREATE TABLE university.StudentDeletionLog (
    log_id INT IDENTITY PRIMARY KEY,
    student_id INT,
    reason NVARCHAR(200),
    attempted_at DATETIME
);


-- Drop the trigger if it already exists
IF OBJECT_ID('university.trg_StudentNameUpdate', 'TR') IS NOT NULL
    DROP TRIGGER university.trg_StudentNameUpdate;
GO

-- Create the AFTER UPDATE trigger with error handling
CREATE TRIGGER university.trg_StudentNameUpdate
ON university.Student
FOR UPDATE
AS
BEGIN
    BEGIN TRY
        -- Ensure the update is for name change (either first or last name)
        IF UPDATE(first_name) OR UPDATE(last_name)
        BEGIN
            INSERT INTO university.Student_Name_Change_Log (student_id, old_first_name, old_last_name, new_first_name, new_last_name)
            SELECT 
                inserted.student_id, 
                deleted.first_name, 
                deleted.last_name, 
                inserted.first_name, 
                inserted.last_name
            FROM inserted
            JOIN deleted ON inserted.student_id = deleted.student_id;
        END
    END TRY
    BEGIN CATCH
        -- Capture any errors and provide a message
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(), 
            @ErrorSeverity = ERROR_SEVERITY(), 
            @ErrorState = ERROR_STATE();
        
        -- Raise the error back to the calling application
        RAISERROR('Error occurred in trg_StudentNameUpdate: %s', @ErrorSeverity, @ErrorState, @ErrorMessage);
    END CATCH
END;
GO


-- Try deleting a student (modify student_id as needed)
DELETE FROM university.Student WHERE student_id = 4;
select * from university.Student WHERE student_id = 1;
SELECT * FROM university.Enrollment WHERE student_id = 1;

-- Check the log
SELECT * FROM university.StudentDeletionLog ORDER BY attempted_at DESC;

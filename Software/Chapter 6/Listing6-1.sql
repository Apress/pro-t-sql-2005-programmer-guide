-- Listing 6-1 from Chapter 6
USE AdventureWorks;
GO
-- Demonstrates a simple stored procedure
IF OBJECT_ID('dbo.GetEmployee') IS NOT NULL
    DROP PROCEDURE dbo.GetEmployee;
GO
CREATE PROCEDURE dbo.GetEmployee (@Emp_ID INT = 199,
    @Email_Address NVARCHAR(50) OUTPUT,
    @Full_Name NVARCHAR(100) OUTPUT)
AS
BEGIN
    DECLARE @i INT;
    SELECT @Email_Address = c.EmailAddress, 
        @Emp_ID = e.EmployeeID,
        @Full_Name = c.LastName + ' ' + c.MiddleName + ' ' + c.LastName
    FROM HumanResources.Employee e
    INNER JOIN Person.Contact c
        ON e.ContactID = c.ContactID
    WHERE e.EmployeeID = @Emp_ID;
    RETURN (
        CASE 
            WHEN @Email_Address IS NULL THEN 1
            ELSE 0
        END );
END;
GO
DECLARE @Email NVARCHAR(50),
    @Name NVARCHAR(100),
    @Result INT;
EXECUTE @Result = dbo.GetEmployee 123, @Email OUTPUT, @Name OUTPUT;
SELECT @Result AS Result,
    @Email AS Email,
    @Name AS [Name];
GO
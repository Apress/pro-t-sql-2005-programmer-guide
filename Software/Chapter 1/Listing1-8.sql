-- Sample program Listing 1-8 from Chapter 1

USE AdventureWorks;
GO
IF OBJECT_ID('dbo.GetOrAdd_ContactType') IS NOT NULL
    DROP PROCEDURE dbo.GetOrAdd_ContactType;
GO
CREATE PROCEDURE dbo.GetOrAdd_ContactType
(
    @Name NVARCHAR(50),
    @ContactTypeID INT OUTPUT
)
AS
    DECLARE @Err_Code AS INT;
    SELECT @Err_Code = 0;

    SELECT @ContactTypeID = ContactTypeID
    FROM Person.ContactType
    WHERE [Name] = @Name;

    IF @ContactTypeID IS NULL
    BEGIN
        INSERT 
        INTO Person.ContactType ([Name], ModifiedDate)
        SELECT @Name, CURRENT_TIMESTAMP;

        SELECT @Err_Code = @@error;
        IF @Err_Code = 0        -- If there’s an error skip next
            SELECT @ContactTypeID = SCOPE_IDENTITY();
    END
    RETURN @Err_Code;			-- Single exit point
GO

-- Sample program Listing 1-7 from Chapter 1

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

    IF @ContactTypeID IS NOT NULL
        RETURN;						-- Exit 1: if the ContactType exists

    INSERT 
    INTO Person.ContactType ([Name], ModifiedDate)
    SELECT @Name, CURRENT_TIMESTAMP;

    SELECT @Err_Code = @@error;
    IF @Err_Code <> 0
        RETURN @Err_Code;			-- Exit 2: if there is an error on INSERT

    SELECT @ContactTypeID = SCOPE_IDENTITY();

    RETURN @Err_Code;				-- Exit 3: after successful INSERT
GO
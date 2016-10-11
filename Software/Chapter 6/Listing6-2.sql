-- Listing 6-2 from Chapter 6
USE AdventureWorks;
GO
-- Demonstrates a simple stored procedure
IF OBJECT_ID('dbo.Upsert_CountryRegion') IS NOT NULL
    DROP PROCEDURE dbo.Upsert_CountryRegion;
GO
CREATE PROCEDURE dbo.Upsert_CountryRegion (@Code NVARCHAR(3),
    @Name NVARCHAR(50))
AS
BEGIN
    DECLARE @i INT,
        @err INT;
    SELECT @i = COUNT(*)
    FROM Person.CountryRegion
    WHERE CountryRegionCode = @Code;

    IF @i = 0
    BEGIN
        INSERT INTO Person.CountryRegion (CountryRegionCode, 
            [Name], 
            ModifiedDate)
        VALUES (@Code, @Name, CURRENT_TIMESTAMP);
        SELECT @err = @@error;
    END
    ELSE
    BEGIN
        UPDATE Person.CountryRegion
        SET [Name] = @Name,
            ModifiedDate = CURRENT_TIMESTAMP
        WHERE CountryRegionCode = @Code;
        SELECT @err = @@error;
    END;
    RETURN @err;
END;
GO
DECLARE @result INT;
EXEC @result = dbo.Upsert_CountryRegion @Code = 'IDM',
    @Name = 'Isla de Muerta';

SELECT N'Result Code = ' + CAST(@result AS NVARCHAR(10));

SELECT CountryRegionCode, [Name], ModifiedDate
FROM Person.CountryRegion;
GO
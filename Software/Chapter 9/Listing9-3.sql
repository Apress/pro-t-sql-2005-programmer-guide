-- Listing 9-3 from Chapter 9
USE AdventureWorks;
GO
-- Example of TRY...CATCH error handling
CREATE PROCEDURE dbo.TestError3
AS
BEGIN
    DECLARE @e INT;
    SELECT @e = 0;
    BEGIN TRY
        INSERT INTO Person.Address (AddressID)
        VALUES (1);
    END TRY
    BEGIN CATCH
        SELECT @e = ERROR_NUMBER();
        PRINT N'Error Code = ' + CAST(@e AS NVARCHAR(10));
        PRINT N'Error Procedure = ' + ERROR_PROCEDURE();
        PRINT N'Error Message = ' + ERROR_MESSAGE();
    END CATCH
    RETURN @e;
END
GO

DECLARE @ret INT;
EXEC @ret = dbo.TestError3;
PRINT N'Return value = ' + CAST(@ret AS NVARCHAR(10));
GO
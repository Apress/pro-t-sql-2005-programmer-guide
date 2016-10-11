-- Listing 9-2 from Chapter 9
USE AdventureWorks;
GO
-- Example of how to properly handle errors with @@error
IF OBJECT_ID('dbo.TestError2') IS NOT NULL
    DROP PROCEDURE dbo.TestError2;
GO
CREATE PROCEDURE dbo.TestError2
AS
BEGIN
    DECLARE @e INT;
    INSERT INTO Person.Address (AddressID)
    VALUES (1);
    -- By assigning @@error to a temporary variable we don't have to
    -- worry about resetting its value later
    SELECT @e = @@error;
    PRINT N'Error Code = ' + CAST(@e AS NVARCHAR(10));
    RETURN @e;		-- This will return the appropriate error code now
END
GO

DECLARE @ret INT;
EXEC @ret = dbo.TestError2;
PRINT N'Return value = ' + CAST(@ret AS NVARCHAR(10));
GO
-- Listing 9-1 from Chapter 9
USE AdventureWorks;
GO
-- Example of how NOT to handle errors with @@error
IF OBJECT_ID('dbo.TestError') IS NOT NULL
    DROP PROCEDURE dbo.TestError;
GO
CREATE PROCEDURE dbo.TestError
AS
BEGIN
    INSERT INTO Person.Address (AddressID)
    VALUES (1);
    -- The PRINT statement below resets @@error upon successful completion
    PRINT N'Error Code = ' + CAST(@@error AS NVARCHAR(10));
    RETURN @@error;		-- This will return 0 every time
END
GO

DECLARE @ret INT;
EXEC @ret = dbo.TestError;
PRINT N'Return value = ' + CAST(@ret AS NVARCHAR(10));
GO
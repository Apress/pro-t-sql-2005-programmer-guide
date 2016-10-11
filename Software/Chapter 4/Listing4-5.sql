-- Listing 4-5 from Chapter 4
USE AdventureWorks;
GO
-- Demonstrates Transact-SQL BREAK in a WHILE loop.
DECLARE @i INT;
SELECT @i = 1;
WHILE @i <= 10
BEGIN
    PRINT @i;
    SELECT @i = @i + 1;

    BREAK;  -- Force the WHILE loop to terminate

    PRINT 'The BREAK keyword ensures that this will never be printed.';
END;
GO
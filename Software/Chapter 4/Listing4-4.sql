-- Listing 4-4 from Chapter 4
USE AdventureWorks;
GO
-- Demonstrates Transact-SQL CONTINUE in a WHILE loop.
DECLARE @i INT;
SELECT @i = 1;
WHILE @i <= 10
BEGIN
    PRINT @i;
    SELECT @i = @i + 1;

    CONTINUE; -- Force the WHILE loop to re-start

    PRINT 'The CONTINUE keyword ensures that this will never be printed.';
END;
GO
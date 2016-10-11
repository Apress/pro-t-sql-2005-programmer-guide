-- Listing 4-3 from Chapter 4
USE AdventureWorks;
GO
-- Demonstrates Transact-SQL WHILE control-of-flow functionality
DECLARE @i INT;
SELECT @i = 1;
WHILE @i <= 10
BEGIN
    PRINT @i;
    SELECT @i = @i + 1;
END;
GO
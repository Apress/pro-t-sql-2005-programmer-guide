-- Sample program Listing 1-11 from Chapter 1

USE AdventureWorks;
GO
-- @i is not initialized, so the end result is @i = NULL
DECLARE @i INT;
SELECT @i = @i + 5;
SELECT @i;
GO

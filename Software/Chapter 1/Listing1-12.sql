-- Sample program Listing 1-12 from Chapter 1

USE AdventureWorks;
GO
-- @i is initialized to 0, so the end result is @i = 5
DECLARE @i INT;
SELECT @i = 0;		-- Added this statement to initialize @i to 0
SELECT @i = @i + 5;
SELECT @i;
GO

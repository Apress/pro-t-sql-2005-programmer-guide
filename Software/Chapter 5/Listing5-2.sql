-- Listing 5-2 from Chapter 5
USE AdventureWorks;
GO
-- Demonstrates a recursive UDF
IF OBJECT_ID('dbo.fnFactorial') IS NOT NULL
    DROP FUNCTION dbo.fnFactorial;
GO
CREATE FUNCTION dbo.fnFactorial(@n INT = 1)
RETURNS FLOAT
WITH RETURNS NULL ON NULL INPUT
AS
BEGIN
    RETURN 
        (CASE
            WHEN @n <= 0 THEN NULL
            WHEN @n > 1 THEN CAST(@n AS FLOAT) * dbo.fnFactorial(@n - 1)
            ELSE 1
        END);
END;
GO
SELECT dbo.fnFactorial(NULL);		-- Returns NULL
SELECT dbo.fnFactorial(-1);			-- Returns NULL
SELECT dbo.fnFactorial(0);			-- Returns NULL
SELECT dbo.fnFactorial(5);			-- Returns 120
SELECT dbo.fnFactorial(32);			-- Returns 2.63130836933694E+35
GO
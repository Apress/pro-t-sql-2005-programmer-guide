-- Listing 5-1 from Chapter 5
USE AdventureWorks;
GO
-- Demonstrates a scalar UDF
IF OBJECT_ID('dbo.fnCircleArea') IS NOT NULL
    DROP FUNCTION dbo.fnCircleArea;
GO
CREATE FUNCTION dbo.fnCircleArea (@radius FLOAT = 1.0)
RETURNS FLOAT
WITH RETURNS NULL ON NULL INPUT, SCHEMABINDING
AS
BEGIN
    RETURN PI() * POWER(@radius, 2);
END;
GO
SELECT dbo.fnCircleArea(10);
SELECT dbo.fnCircleArea(DEFAULT);
GO
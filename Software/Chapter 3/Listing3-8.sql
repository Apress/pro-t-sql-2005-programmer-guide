-- Listing 3-8 from Chapter 3
USE AdventureWorks;
GO
IF OBJECT_ID('dbo.fnPowers') IS NOT NULL
    DROP FUNCTION dbo.fnPowers;
GO
-- Demonstrates CROSS APPLY with a user-defined function.
CREATE FUNCTION dbo.fnPowers (@Num INT)
RETURNS TABLE
AS
RETURN
(
    SELECT @Num * @Num AS Squared_Result,
        @Num * @Num * @Num AS Cubed_Result
);
GO

CREATE TABLE #Numbers (Number INT NOT NULL PRIMARY KEY);
INSERT INTO #Numbers (Number) VALUES (1);
INSERT INTO #Numbers (Number) VALUES (2);
INSERT INTO #Numbers (Number) VALUES (3);
SELECT n.Number, 
    s.Squared_Result, 
    s.Cubed_Result
FROM #Numbers n
CROSS APPLY dbo.fnPowers (n.Number) s;
GO
DROP TABLE #Numbers;
GO
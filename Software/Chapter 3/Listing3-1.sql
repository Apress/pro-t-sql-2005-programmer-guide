-- Sample program Listing 3-1 from Chapter 3

USE AdventureWorks;
GO
-- Minimally-logged .WRITE method of NVARCHAR(MAX) data type
CREATE TABLE #WriteTest ([ID] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    BigText NVARCHAR(MAX) NOT NULL);

INSERT 
INTO #WriteTest (BigText)
VALUES (N'Transact-SQL Rocks.');

SELECT BigText
FROM #WriteTest;

UPDATE #WriteTest
SET BigText.WRITE(N' and Rolls.', 18, 11);

SELECT BigText
FROM #WriteTest;

DROP TABLE #WriteTest;
GO

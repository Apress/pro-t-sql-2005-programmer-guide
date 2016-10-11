-- Listing 3-7 from Chapter 3
USE AdventureWorks;
GO
-- Demonstrates INSERT TOP and DELETE TOP
CREATE TABLE #Queue (
    [ID] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL);

INSERT TOP (5)
INTO #Queue (FirstName)
    OUTPUT N'Enqueued: ' + INSERTED.FirstName
SELECT DISTINCT FirstName
    FROM Person.Contact;

DELETE TOP (3)
FROM #Queue 
    OUTPUT N'De-queued: ' + DELETED.FirstName;

DROP TABLE #Queue;
GO
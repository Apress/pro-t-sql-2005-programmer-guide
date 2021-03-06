-- Listing 3-17 from Chapter 3
USE AdventureWorks;
GO
-- Demonstrates NEWSEQUENTIALID function
CREATE TABLE #TestSeqID ([ID] UNIQUEIDENTIFIER 
    DEFAULT NEWSEQUENTIALID() PRIMARY KEY NOT NULL,
    Num INT NOT NULL);

INSERT INTO #TestSeqID (Num) VALUES (1);
INSERT INTO #TestSeqID (Num) VALUES (2);
INSERT INTO #TestSeqID (Num) VALUES (3);

SELECT [ID], Num
FROM #TestSeqID;

DROP TABLE #TestSeqID;
GO
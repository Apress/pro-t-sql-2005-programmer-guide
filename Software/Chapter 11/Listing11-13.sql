-- Listing 11-13 from Chapter 11
USE AdventureWorks;
GO

SELECT Resume.query(N'declare namespace
    ns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume";
    /ns:Resume/ns:Name') AS [NameXML]
FROM HumanResources.JobCandidate;
GO
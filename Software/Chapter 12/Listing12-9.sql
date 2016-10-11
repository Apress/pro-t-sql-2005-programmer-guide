-- Listing 12-9 from Chapter 12
USE AdventureWorks;
GO

SELECT Resume.query(N'//*:Name.First,
    //*:Name.Middle,
    //*:Name.Last,
    //*:Edu.Level')
FROM HumanResources.JobCandidate;
GO
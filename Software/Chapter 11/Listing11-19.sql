-- Listing 11-19 from Chapter 11
USE AdventureWorks;
GO

CREATE PRIMARY XML INDEX PXML_JobCandidate
ON HumanResources.JobCandidate (Resume);
GO

CREATE XML INDEX IXML_Education
ON HumanResources.JobCandidate (Resume)
USING XML INDEX PXML_JobCandidate
    FOR PATH;
GO
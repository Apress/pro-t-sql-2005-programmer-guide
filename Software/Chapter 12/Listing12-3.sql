-- Listing 12-3 from Chapter 12
USE AdventureWorks;
GO

SELECT ContactID AS N'*',
    N',' + EmailAddress,
    FirstName AS N'Person/Name/First',
    MiddleName AS N'Person/Name/Middle',
    LastName AS N'Person/Name/Last'
FROM Person.Contact
FOR XML PATH;
GO
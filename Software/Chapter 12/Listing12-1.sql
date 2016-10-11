-- Listing 12-1 from Chapter 12
USE AdventureWorks;
GO

SELECT ContactID AS 'Person/ID',
    FirstName AS 'Person/Name/First',
    MiddleName AS 'Person/Name/Middle',
    LastName AS 'Person/Name/Last',
    EmailAddress AS 'Person/Email'
FROM Person.Contact
FOR XML PATH;
GO
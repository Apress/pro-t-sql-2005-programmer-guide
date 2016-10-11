-- Listing 12-2 from Chapter 12
USE AdventureWorks;
GO

SELECT ContactID AS 'Person/@ID',
    EmailAddress AS 'Person/@Email',
    FirstName AS 'Person/Name/First',
    MiddleName AS 'Person/Name/Middle',
    LastName AS 'Person/Name/Last'
FROM Person.Contact
FOR XML PATH;
GO
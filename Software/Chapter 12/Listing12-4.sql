-- Listing 12-4 from Chapter 12
USE AdventureWorks;
GO

SELECT ContactID AS 'Person/@ContactID',
    EmailAddress AS 'Person/Email',
    FirstName AS 'Person/Name/First',
    MiddleName AS 'Person/Name/Middle',
    Phone AS 'Person/Phone',
    LastName AS 'Person/Name/Last'
FROM Person.Contact
FOR XML PATH;
GO
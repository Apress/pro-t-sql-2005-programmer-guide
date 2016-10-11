-- Listing 12-8 from Chapter 12
USE AdventureWorks;
GO

SELECT NameStyle AS N'processing-instruction(nameStyle)',
    ContactID AS N'Person/@ID',
    ModifiedDate AS N'comment()',
    Phone AS N'text()',
    FirstName AS N'Person/Name/First',
    MiddleName AS N'Person/Name/Middle',
    LastName AS N'Person/Name/Last',
    EmailAddress AS N'Person/Email'
FROM Person.Contact
FOR XML PATH;
GO
-- Listing 12-7 from Chapter 12
USE AdventureWorks;
GO

WITH XMLNAMESPACES('http://www.apress.com/xml/sampleSqlXmlNameSpace' as ns)
SELECT ContactID AS 'ns:Person/ID',
    FirstName AS 'ns:Person/Name/First',
    MiddleName AS 'ns:Person/Name/Middle',
    LastName AS 'ns:Person/Name/Last',
    EmailAddress AS 'ns:Person/Email'
FROM Person.Contact
FOR XML PATH;
GO
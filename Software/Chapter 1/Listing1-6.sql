-- Sample program Listing 1-6 from Chapter 1

USE AdventureWorks;
GO
SELECT i.CustomerID, 
    c.Title, 
    c.FirstName, 
    c.MiddleName,
    c.LastName, 
    c.Suffix, 
    c.Phone, 
    c.EmailAddress,
    c.EmailPromotion
FROM Sales.Individual i
INNER JOIN Person.Contact c
    ON c.ContactID = i.ContactID
INNER JOIN Sales.CustomerAddress ca
    ON ca.CustomerID = i.CustomerID;
GO
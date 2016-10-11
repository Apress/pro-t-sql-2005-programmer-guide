-- Listing 3-13 from Chapter 3
USE AdventureWorks;
GO
-- Demonstrates ROW_NUMBER function
DECLARE @start INT;
SELECT @start = 10;
WITH PageContacts AS
(
    SELECT ROW_NUMBER() OVER 
    (
        ORDER BY LastName, 
        FirstName, 
        MiddleName
    ) 
    AS PosNo, FirstName, MiddleName, LastName
    FROM Person.Contact
)
SELECT PosNo, FirstName, MiddleName, LastName
FROM PageContacts
WHERE PosNo BETWEEN @start AND @start + 9;
GO
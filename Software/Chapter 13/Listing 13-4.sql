-- Listing 13-4 from Chapter 13
USE AdventureWorks;
GO

SELECT c.name, c.colid
FROM dbo.syscolumns c
WHERE c.id = OBJECT_ID('Person.Contact')
ORDER BY c.colid;
GO
-- Listing 13-1 from Chapter 13
USE AdventureWorks;
GO

SELECT c.name, c.column_id
FROM sys.columns c
WHERE c.object_id = OBJECT_ID('Person.Contact')
ORDER BY c.column_id;
GO
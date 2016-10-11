-- Listing 13-2 from Chapter 13
USE AdventureWorks;
GO

SELECT s.name AS Schema_Name,
    t.name AS Table_Name,
    c.name AS Column_Name,
    c.column_id
FROM sys.schemas s
INNER JOIN sys.tables t
    ON s.schema_id = t.schema_id
INNER JOIN sys.columns c
    ON t.object_id = c.object_id
WHERE s.name = N'Person'
    AND t.name = N'Contact'
ORDER BY c.column_id;
GO
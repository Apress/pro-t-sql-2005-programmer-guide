-- Listing 4-14 from Chapter 4
USE AdventureWorks;
GO
-- COALESCE with NULLIF
DECLARE @s VARCHAR(10);
SELECT @s = 'A';
SELECT COALESCE(NULLIF(@s, 'A'), 'This is NULL or A');
GO
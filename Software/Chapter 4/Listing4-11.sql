-- Listing 4-11 from Chapter 4
USE AdventureWorks;
GO
-- CASE-style Pivot Table
SELECT t.CountryRegionCode,
    SUM (
        CASE 
            WHEN t.Name = 'Northwest' THEN 1
            ELSE 0
        END) AS Northwest_US,
    SUM (
        CASE 
            WHEN t.Name = 'Northeast' THEN 1
            ELSE 0
        END) AS Northeast_US,
    SUM (
        CASE 
            WHEN t.Name = 'Southwest' THEN 1
            ELSE 0
        END) AS Southwest_US,
    SUM (
        CASE 
            WHEN t.Name = 'Southeast' THEN 1
            ELSE 0
        END) AS Southeast_US,
    SUM (
        CASE 
            WHEN t.Name = 'Central' THEN 1
            ELSE 0
        END) AS Central_US
FROM Sales.SalesOrderHeader soh
    INNER JOIN Sales.SalesTerritory t
        ON soh.TerritoryID = t.TerritoryID
WHERE t.CountryRegionCode = 'US'
GROUP BY  t.CountryRegionCode;
GO
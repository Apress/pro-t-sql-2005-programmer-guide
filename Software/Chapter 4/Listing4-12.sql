-- Listing 4-12 from Chapter 4
USE AdventureWorks;
GO
-- PIVOT Operator
SELECT [CountryRegionCode], [Northwest], [Northeast], [Southwest], [Southeast], [Central]
FROM 
(
    SELECT CountryRegionCode, t.Name
    FROM Sales.SalesOrderHeader soh
        INNER JOIN Sales.SalesTerritory t
            ON soh.TerritoryID = t.TerritoryID
    WHERE t.CountryRegionCode = 'US'
) p
PIVOT
(
    COUNT (Name)
    FOR Name
    IN ([Northwest], [Northeast], [Southwest], [Southeast], [Central])
) AS pvt;
GO
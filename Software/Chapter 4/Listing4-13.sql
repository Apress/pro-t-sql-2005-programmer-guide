-- Listing 4-13 from Chapter 4
USE AdventureWorks;
GO
-- Dynamic SQL Pivot Table
DECLARE @sql NVARCHAR(MAX);
CREATE TABLE #temp (TerritoryID INT NOT NULL PRIMARY KEY,
    CountryRegion NVARCHAR(20) NOT NULL,
    CountryRegionCode NVARCHAR(3) NOT NULL);

INSERT INTO #temp (TerritoryID, CountryRegion, CountryRegionCode)
    SELECT DISTINCT TerritoryID, 
        Name, 
        CountryRegionCode
    FROM Sales.SalesTerritory;

DECLARE @i INT;

SELECT @i = MIN(TerritoryID)
    FROM #temp;

SELECT @sql = N'SELECT ';

WHILE @i <= 
    (
        SELECT MAX(TerritoryID) 
        FROM #temp
    )
BEGIN
    SELECT @sql = @sql + N'SUM (CASE ' +
        N'WHEN t.TerritoryID = ' + CAST(TerritoryID AS NVARCHAR(3)) + N' ' +
        N'THEN 1 ELSE 0 END) AS ' + QUOTENAME(CountryRegion + N'_' + CountryRegionCode)+
        CASE WHEN @i < (
                SELECT MAX(TerritoryID) 
                FROM #temp
            ) THEN N', '
            ELSE N' '
        END
    FROM #temp
    WHERE TerritoryID = @i;

    SELECT @i = @i + 1;
END;

SELECT @sql = @sql + N'FROM Sales.SalesOrderHeader soh ' +
    N'INNER JOIN Sales.SalesTerritory t ' +
    N'ON soh.TerritoryID = t.TerritoryID ' ;

EXEC (@sql);

DROP TABLE #temp;
GO
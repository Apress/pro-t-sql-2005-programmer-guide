-- Listing 3-12 from Chapter 3
USE AdventureWorks;
GO
-- Demonstrates PIVOT and UNPIVOT
CREATE TABLE #Pvt ([CA] INT NOT NULL,
    [MA] INT NOT NULL,
    [TX] INT NOT NULL,
    [WA] INT NOT NULL,
    PRIMARY KEY ([CA], [MA], [TX], [WA]));

INSERT INTO #Pvt ([CA], [MA], [TX], [WA])
SELECT  [CA],
    [MA],
    [TX],
    [WA]
FROM 
(
    SELECT sp.StateProvinceCode
    FROM Sales.CustomerAddress c
    INNER JOIN Person.Address a
        ON c.AddressID = a.AddressID
    INNER JOIN Person.StateProvince sp
        ON a.StateProvinceID = sp.StateProvinceID
) p
PIVOT
(
    COUNT (StateProvinceCode)
    FOR StateProvinceCode
        IN ([CA], [MA], [TX], [WA])
) AS pvt;

SELECT StateProvinceCode, Customer_Count
FROM
(
    SELECT [CA], 
        [MA], 
        [TX], 
        [WA]
    FROM #Pvt
) t
UNPIVOT 
(
    Customer_Count 
    FOR StateProvinceCode 
        IN  ([CA], [MA], [TX], [WA])
) AS unpvt;

DROP TABLE #Pvt;
GO
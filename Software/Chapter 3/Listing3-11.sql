-- Listing 3-11 from Chapter 3
USE AdventureWorks;
GO
-- Demonstrates PIVOT operator
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
GO
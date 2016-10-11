-- Listing 4-10 from Chapter 4
USE AdventureWorks;
GO
-- Demonstrates Searched CASE Expressions
SELECT SUM(AllCustomers.NumOfCustomers), AllCustomers.Area
FROM 
(
    SELECT COUNT(*) AS NumOfCustomers, sp.CountryRegionCode, 
        CASE 
            WHEN sp.StateProvinceCode IN ('CA', 'WA', 'OR') THEN 'West Coast'
            WHEN sp.StateProvinceCode IN ('HI', 'AK') THEN 'Pacific'
            WHEN sp.StateProvinceCode IN ('CT', 'MA', 'ME', 'NH', 'RI', 'VT') THEN 'New England'
            ELSE 'Elsewhere'
        END AS Area
    FROM Sales.CustomerAddress s
        INNER JOIN Person.Address p
            ON s.AddressID = p.AddressID
        INNER JOIN Person.StateProvince sp
            ON p.StateProvinceID = p.StateProvinceID
    WHERE CountryRegionCode = 'US'
    GROUP BY sp.CountryRegionCode, sp.StateProvinceCode
) AllCustomers
GROUP BY AllCustomers.Area;
GO
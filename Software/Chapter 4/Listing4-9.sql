-- Listing 4-9 from Chapter 4
USE AdventureWorks;
GO
-- Demonstrates Simple CASE Expressions
SELECT SUM(AllCustomers.NumOfCustomers), AllCustomers.Coast
FROM 
(
    SELECT COUNT(*) AS NumOfCustomers, 
        sp.CountryRegionCode, 
        CASE sp.StateProvinceCode
            WHEN 'CA' THEN 'West Coast'
            WHEN 'WA' THEN 'West Coast'
            WHEN 'OR' THEN 'West Coast'
            ELSE 'Elsewhere'
        END AS Coast
    FROM Sales.CustomerAddress s
        INNER JOIN Person.Address p
            ON s.AddressID = p.AddressID
        INNER JOIN Person.StateProvince sp
            ON p.StateProvinceID = p.StateProvinceID
    WHERE CountryRegionCode = 'US'
    GROUP BY sp.CountryRegionCode, 
        sp.StateProvinceCode
) AllCustomers
GROUP BY AllCustomers.Coast;
GO
-- Listing 7-5 from Chapter 7
USE AdventureWorks;
GO
-- Testing the trigger
INSERT INTO Production.Product(Name, 
    ProductNumber, 
    Size, 
    SizeUnitMeasureCode, 
    SafetyStockLevel, 
    ReorderPoint, 
    StandardCost, 
    ListPrice, 
    DaysToManufacture, 
    SellStartDate)
VALUES ('King Roadster-1000 Gold Plated, 48', 
    N'BK-K20Z-48', 
    N'18.9', 
    N'IN', 
    1000, 
    750, 
    1412.50, 
    2639.99, 
    2, 
    N'2006-08-19');
GO
SELECT Name, 
    ProductNumber, 
    Size, 
    SizeUnitMeasureCode
FROM Production.Product
WHERE ProductNumber = N'BK-K20Z-48';
GO

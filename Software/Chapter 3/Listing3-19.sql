-- Listing 3-19 from Chapter 3
USE AdventureWorks;
GO
-- Demonstrates OVER clause with aggregate functions
SELECT PurchaseOrderID, 
    ProductID, 
    SUM(OrderQty) OVER (PARTITION BY ProductId) AS TotalOrderQty
FROM Purchasing.PurchaseOrderDetail;
GO
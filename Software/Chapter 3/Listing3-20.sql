-- Listing 3-20 from Chapter 3
USE AdventureWorks;
GO
-- Demonstrates alternative to OVER clause with aggregate function:
-- Aggregate function in sub-query
SELECT pod.PurchaseOrderID, pod.ProductID, pqty.TotalOrderQty
FROM Purchasing.PurchaseOrderDetail pod
INNER JOIN (
    SELECT ProductID, SUM(OrderQty) AS TotalOrderQty
    FROM Purchasing.PurchaseOrderDetail
    GROUP BY ProductID
) pqty
ON pod.ProductID = pqty.ProductID;
GO
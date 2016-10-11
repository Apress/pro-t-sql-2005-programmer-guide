-- Listing 10-2 from Chapter 10
USE AdventureWorks;
GO
-- More complex dynamic SQL demonstration
DECLARE @min_product_id INT;
SELECT @min_product_id = 500;
DECLARE @sql_stmt NVARCHAR(128);
SELECT @sql_stmt = N'SELECT ProductID ' +
    N'FROM Production.Product ' +
    N'WHERE ProductID >= ' + CAST(@min_product_id AS NVARCHAR(10));
EXECUTE (@sql_stmt);
GO
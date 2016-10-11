-- Listing 10-5 from Chapter 10
USE AdventureWorks;
GO
-- Parameterized dynamic SQL
DECLARE @product_name NVARCHAR(50);
SELECT @product_name = N'Mountain%';
DECLARE @sql_stmt NVARCHAR(128);
SELECT @sql_stmt = N'SELECT ProductID, Name ' +
    N'FROM Production.Product ' +
    N'WHERE Name LIKE @name';
EXECUTE dbo.sp_executesql @sql_stmt, 
    N'@name NVARCHAR(50)', 
    @name = @product_name;
GO
-- Listing 10-6 from Chapter 10
USE AdventureWorks;
GO
-- Limited scope of dynamic SQL
-- This code will generate an error message when you try to access the temp table 
-- after it goes out of scope
DECLARE @sql_stmt NVARCHAR(512);
SELECT @sql_stmt = N'CREATE TABLE #Temp_ProductIDs ' +
    N'(ProductID INT NOT NULL PRIMARY KEY); ' +
    N'INSERT INTO #Temp_ProductIDs (ProductID) ' +
    N'SELECT ProductID ' +
    N'FROM Production.Product;' ;

EXECUTE (@sql_stmt);

-- The following SELECT statement will generate an error
SELECT ProductID
FROM #Temp_ProductIDs;

GO
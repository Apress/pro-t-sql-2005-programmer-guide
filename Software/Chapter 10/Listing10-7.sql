-- Listing 10-7 from Chapter 10
USE AdventureWorks;
GO

CREATE TABLE #Temp_ProductIDs
    (ProductID INT NOT NULL PRIMARY KEY);

DECLARE @sql_stmt NVARCHAR(512);

SELECT @sql_stmt = N'INSERT INTO #Temp_ProductIDs (ProductID) ' +
    N'SELECT ProductID ' +
    N'FROM Production.Product;' ;

EXECUTE (@sql_stmt);

SELECT ProductID
FROM #Temp_ProductIDs;
GO
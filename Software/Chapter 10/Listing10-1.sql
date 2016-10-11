-- Listing 10-1 from Chapter 10
USE AdventureWorks;
GO
-- Simple dynamic SQL demonstration
EXECUTE (N'SELECT ProductID FROM Production.Product');
GO
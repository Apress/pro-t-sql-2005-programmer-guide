-- Listing 3-18 from Chapter 3
USE AdventureWorks;
GO
-- Demonstrates SYNONYMs
CREATE SYNONYM AWCust
FOR AdventureWorks.Sales.Customer;

SELECT CustomerID,
    AccountNumber
FROM AWCust;

DROP SYNONYM AWCust;
GO
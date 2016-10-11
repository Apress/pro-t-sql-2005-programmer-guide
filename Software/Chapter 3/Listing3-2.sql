-- Script3-2.sql
USE AdventureWorks;
GO
-- Demonstrates recursive CTE
WITH OrgChart (EmployeeID, ContactID, ManagerID, Title) AS
(
    SELECT EmployeeID, 
        ContactID, 
        ManagerID, 
        Title
    FROM HumanResources.Employee
    WHERE ManagerID IS NULL
    UNION ALL
    SELECT e.EmployeeID, 
        e.ContactID, 
        e.ManagerID, 
        e.Title
    FROM HumanResources.Employee e
    INNER JOIN OrgChart o
    ON e.ManagerID = o.EmployeeID
)
SELECT EmployeeID, 
    ContactID, 
    ManagerID, 
    Title
FROM OrgChart
WHERE ManagerID = 109
OR ManagerID IS NULL;
GO
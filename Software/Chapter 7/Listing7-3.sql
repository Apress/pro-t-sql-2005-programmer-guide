-- Listing 7-3 from Chapter 7
USE AdventureWorks;
GO
-- Testing the Audit Logging trigger
INSERT INTO HumanResources.Department (Name, GroupName)
VALUES (N'Customer Service', N'Sales and Marketing');

INSERT INTO HumanResources.Department (Name, GroupName)
VALUES (N'Regulatory Compliance', N'Executive General and Administration');

DELETE FROM HumanResources.Department 
WHERE Name = N'Regulatory Compliance';

UPDATE HumanResources.Department 
SET Name = N'Customer Relations'
WHERE Name = N'Customer Service';

SELECT EntryNum, 
    TableName, 
    ActionType, 
    UserId, 
    ActionDate, 
    ActionDML
FROM HumanResources.ActionLog;
GO

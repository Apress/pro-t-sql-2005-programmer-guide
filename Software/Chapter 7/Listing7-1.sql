-- Listing 7-1 from Chapter 7
USE AdventureWorks;
GO
-- Sample AFTER UPDATE trigger
CREATE TRIGGER [HumanResources].[uDepartment]
ON [HumanResources].[Department] 
AFTER UPDATE
NOT FOR REPLICATION
AS 
BEGIN
    SET NOCOUNT ON;

    UPDATE [HumanResources].[Department]
    SET [HumanResources].[Department].[ModifiedDate] = GETDATE()
    FROM inserted
    WHERE inserted.[DepartmentID] = [HumanResources].[Department].[DepartmentID];
END;
GO
-- Listing 7-2 from Chapter 7
USE AdventureWorks;
GO
IF OBJECT_ID('HumanResources.Trg_DepartmentChangeAudit') IS NOT NULL
    DROP TRIGGER HumanResources.Trg_DepartmentChangeAudit;
IF OBJECT_ID('HumanResources.ActionLog') IS NOT NULL
    DROP TABLE HumanResources.ActionLog;
GO
-- Audit logging sample
CREATE TABLE HumanResources.ActionLog (
    EntryNum INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    TableName NVARCHAR(200) NOT NULL,
    ActionType NVARCHAR(10) NOT NULL,
    ActionDML NVARCHAR(500) NOT NULL,
    UserID NVARCHAR(50) NOT NULL,
    ActionDate DATETIME NOT NULL);
GO
-- AFTER INSERT, UPDATE, DELETE Trigger
CREATE TRIGGER HumanResources.Trg_DepartmentChangeAudit
ON HumanResources.Department
AFTER INSERT, UPDATE, DELETE
NOT FOR REPLICATION
AS
BEGIN
    IF (@@ROWCOUNT > 0)
    BEGIN
        SET NOCOUNT ON;
        DECLARE @inserted_count INT;
        DECLARE @deleted_count INT;
        SELECT @inserted_count = COUNT(*)
        FROM inserted;
        SELECT @deleted_count = COUNT(*)
        FROM deleted;
        -- First scenario: 1+ rows inserted, no deletes = INSERT statement
        IF (@inserted_count > 0) AND (@deleted_count = 0)
        BEGIN
            INSERT INTO HumanResources.ActionLog (TableName, 
                ActionType, 
                ActionDML,
                UserID, 
                ActionDate)
            SELECT N'HumanResources.Department', 
                    N'INSERT',
                    N'INSERT INTO HumanResources.Department (Name, GroupName) ' +
                    N'VALUES (N''' + REPLACE(name, N'''', N'''''') + N''', N''' + 
                    REPLACE(groupname, N'''', N'''''') + N''');',
                USER_NAME(), 
                CURRENT_TIMESTAMP
            FROM inserted;
        END
         -- Second scenatio: no inserted rows, 1+ rows deleted = DELETE statement
        ELSE IF (@inserted_count = 0) AND (@deleted_count > 0)
        BEGIN
            INSERT INTO HumanResources.ActionLog (TableName, 
                ActionType, 
                ActionDML,
                UserID, 
                ActionDate)
            SELECT N'HumanResources.Department', 
                    N'DELETE',
                    N'DELETE FROM HumanResources.Department ' +
                    N'WHERE name = N''' + REPLACE(name, N'''', N'''''') + N''';',
                USER_NAME(), 
                CURRENT_TIMESTAMP
            FROM deleted;
        END
        -- Third scenario: 1+ inserted rows and 1+ deleted rows = UPDATE statement
        ELSE IF (@inserted_count > 0) AND (@deleted_count > 0)
        BEGIN
            INSERT INTO HumanResources.ActionLog (TableName, 
                ActionType, 
                ActionDML,
                UserID, 
                ActionDate)
            SELECT N'HumanResources.Department', 
                    N'UPDATE',
                    N'UPDATE HumanResources.Department ' +
                    N'name = N''' + REPLACE(name, N'''', N'''''') + N''', ' +
                    N'groupname = ''' + REPLACE(groupname, N'''', N'''''') + N''' ' +
                    N'WHERE DepartmentID = ' + 
                    CAST(DepartmentID AS NVARCHAR(10)) + N';',
                USER_NAME(), 
                CURRENT_TIMESTAMP
            FROM inserted;
        END;
    END;
END;
GO

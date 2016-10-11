-- Listing 3-3
USE AdventureWorks;
GO
-- Demonstrates OUTPUT clause
INSERT INTO HumanResources.Shift ([Name], 
    StartTime,
    EndTime)
    OUTPUT 'INSERTED',
        CURRENT_USER,
        INSERTED.ShiftID
SELECT 'Swing Shift', '12:00:00 PM', '8:00:00 PM';

DELETE FROM HumanResources.Shift
    OUTPUT 'DELETED',
        CURRENT_USER,
        DELETED.ShiftID
WHERE [Name] = N'Swing Shift';
GO
-- Listing 4-7 from Chapter 4
USE AdventureWorks;
GO
-- Demonstrates Transact-SQL WAITFOR control-of-flow keyword.
PRINT 'Step 1 complete. ';
GO
DECLARE @time_to_pass NVARCHAR(8);
SELECT @time_to_pass = N'00:00:03';
WAITFOR DELAY @time_to_pass;
PRINT 'Step 2 completed three seconds later. ';
GO
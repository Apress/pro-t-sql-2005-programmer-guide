-- Listing 4-6 from Chapter 4
USE AdventureWorks;
GO
-- Demonstrates Transact-SQL GOTO control-of-flow keyword.
PRINT 'Step 1 Complete.';
GOTO Step3_Label;

PRINT 'Step 2 will not be printed.';

Step3_Label:
PRINT 'Step 3 Complete.';
GO
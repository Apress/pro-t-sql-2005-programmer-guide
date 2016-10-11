-- Listing 5-3 from Chapter 5
-- This script creates and populates a numbers table required by some of the
-- other sample programs.

-- This SELECT INTO statement uses the T-SQL IDENTITY function to quickly 
-- build a Numbers table
SELECT TOP 10000 IDENTITY(INT, 1, 1) AS Num 
INTO dbo.Numbers 
FROM sys.columns a 
    CROSS JOIN sys.columns b;
GO
-- A table isn’t a table without a Primary Key
ALTER TABLE dbo.Numbers 
    ADD CONSTRAINT PK_Num PRIMARY KEY CLUSTERED (Num);
GO
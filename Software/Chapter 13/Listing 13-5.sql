-- Listing 13-5 from Chapter 13
USE AdventureWorks;
GO

EXECUTE dbo.sp_columns @table_owner = 'Person', @table_name = 'Contact';
GO
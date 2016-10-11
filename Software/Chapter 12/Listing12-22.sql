-- Listing 12-22 from Chapter 12

-- This comparison will generate an error because the types of the XQuery comparison
-- are incompatible

USE AdventureWorks;
GO

DECLARE @x XML;
SELECT @x = N'';
SELECT @x.query(N'3.141592 eq "Pi"') ;
GO
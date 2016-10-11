-- Listing 12-24 from Chapter 12

-- This XQuery will generate an error because you cannot compare heterogenous
-- sequences
USE AdventureWorks;
GO

DECLARE @x xml;
SELECT @x = '';
SELECT @x.query('(xs:date("2006-10-09Z"), 6.02E23) > xs:date("2007-01-01Z")');
GO
-- Listing 12-25 from Chapter 12

-- This will generate an error; you cannot mix nodes and singleton atomic values
-- in sequences
USE AdventureWorks;
GO

DECLARE @x xml;
SELECT @x = '';
SELECT @x.query('(1, <myNode>Testing</myNode>)');
GO
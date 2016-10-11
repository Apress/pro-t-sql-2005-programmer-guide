-- Listing 4-1 from Chapter 4
USE AdventureWorks;
-- Uses the IF control-of-flow statement to demonstrate SQL three-valued logic
DECLARE @i INT;
SELECT @i = NULL;
IF @i = 10
    PRINT 'Boolean expression is True.';
ELSE IF NOT (@i = 10)
    PRINT 'Boolean expression is False.';
ELSE
    PRINT 'Boolean expression is Unknown.';
GO
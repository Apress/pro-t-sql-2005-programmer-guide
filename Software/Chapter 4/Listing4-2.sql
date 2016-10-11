-- Listing 4-2 from Chapter 4
USE AdventureWorks;
GO
-- Uses the IF control-of-flow statement to demonstrate Transact-SQL 
-- BEGIN...END multistatement blocks
DECLARE @direction NVARCHAR(6);
SELECT @direction = N'BOTTOM';
IF @direction = N'TOP'
BEGIN
    PRINT 'Start at the top!';

    SELECT TOP 100 FirstName, 
        MiddleName, 
        LastName
    FROM Person.Contact
    ORDER BY LastName ASC;
END
ELSE
BEGIN
    PRINT 'Start at the bottom!';

    SELECT TOP 100 FirstName, 
        MiddleName, 
        LastName
    FROM Person.Contact
    ORDER BY LastName DESC;
END;
GO

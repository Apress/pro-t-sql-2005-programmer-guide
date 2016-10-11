-- Examples for queries that exercise different SQL objects implemented by this assembly

-----------------------------------------------------------------------------------------
-- Stored procedure
-----------------------------------------------------------------------------------------
-- exec StoredProcedureName


-----------------------------------------------------------------------------------------
-- User defined function
-----------------------------------------------------------------------------------------
-- select dbo.FunctionName()


-----------------------------------------------------------------------------------------
-- User defined type
-----------------------------------------------------------------------------------------
DECLARE @c COMPLEX;
SELECT @c = '+100-10i';
DECLARE @d COMPLEX;
SELECT @d = '5i';
SELECT 'ADD: ' + @c.ToString() + ' , ' + @d.ToString(), 
    COMPLEX::CAdd(@c, @d).ToString();
SELECT 'DIV: ' + @c.ToString() + ' , ' + @d.ToString(), 
    COMPLEX::Div(@c, @d).ToString();
SELECT 'ONE: ' + COMPLEX::One.ToString();
SELECT 'PI: ' + COMPLEX::Pi.ToString();
SELECT @d = COMPLEX::Div(@d, COMPLEX::Pi);
SELECT 'SIN: ' + COMPLEX::Sin(@d).ToString();

-----------------------------------------------------------------------------------------
-- User defined type
-----------------------------------------------------------------------------------------
-- select dbo.AggregateName(Column1) from Table1

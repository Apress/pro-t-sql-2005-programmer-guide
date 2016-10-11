-- Listing 10-4 from Chapter 10
USE AdventureWorks;
GO
-- UDF to validate strings using simple validations techniques
IF OBJECT_ID('dbo.fnValidateString') IS NOT NULL
    DROP FUNCTION dbo.fnValidateString;
GO
CREATE FUNCTION dbo.fnValidateString (@string NVARCHAR(4000))
RETURNS INT
AS
BEGIN
    RETURN (
        SELECT SUM (
            CASE 
                WHEN SUBSTRING(@string, n.Num, 1) LIKE N'[A-Z0-9\_]' ESCAPE '\' THEN 0
                ELSE 1 
            END)
        FROM dbo.Numbers n
        WHERE n.Num <= LEN(@string) 
    );
END;
GO
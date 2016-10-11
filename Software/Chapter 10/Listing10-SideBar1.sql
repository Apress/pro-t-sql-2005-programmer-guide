-- Listing 10-SideBar1 from Chapter 10
USE AdventureWorks;
GO
-- UDF to escape single quotes, SQL-style
IF OBJECT_ID('dbo.fnEscapeQuotes') IS NOT NULL
    DROP FUNCTION dbo.fnEscapeQuotes;
GO
CREATE FUNCTION dbo.fnEscapeQuotes(@string NVARCHAR(4000))
RETURNS NVARCHAR(4000)
AS
BEGIN
    RETURN REPLACE(@string, '''', '''''');
END;
GO
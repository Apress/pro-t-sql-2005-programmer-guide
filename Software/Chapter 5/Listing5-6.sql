-- Listing 5-6 from Chapter 5
-- This script needs the Numbers table
USE AdventureWorks;
GO
-- Demonstrates a multistatement table-valued function (TVF)
IF OBJECT_ID('dbo.fnCommaSplit') IS NOT NULL
    DROP FUNCTION dbo.fnCommaSplit;
GO
CREATE FUNCTION dbo.fnCommaSplit (@String NVARCHAR(MAX))
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN
(
    WITH Splitter(Num, Element)
    AS
    (
        SELECT Num, 
            SUBSTRING(@String, 
                CASE Num
                    WHEN 1 THEN 1
                    ELSE Num + 1
                END,
                CASE CHARINDEX(N',', @String, Num + 1)
                    WHEN 0 THEN LEN(@String) - Num + 1
                    ELSE CHARINDEX(N',', @String, Num + 1) - Num -
                        CASE 
                            WHEN Num > 1 THEN 1
                            ELSE 0 
                        END
                END
            ) AS Element
        FROM dbo.Numbers
        WHERE Num <= LEN(@String)
            AND (SUBSTRING(@String, Num, 1) = N','
                OR Num = 1)
    )
    SELECT ROW_NUMBER() OVER (ORDER BY Num) AS Num,
        Element
    FROM Splitter
);
GO


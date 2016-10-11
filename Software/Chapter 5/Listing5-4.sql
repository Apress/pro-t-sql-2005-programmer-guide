-- Listing 5-4 from Chapter 5
-- This script needs the Numbers table.
USE AdventureWorks;
GO
-- Demonstrates NYSIIS encoding with procedural code in a UDF
IF OBJECT_ID('dbo.fnNYSIIS') IS NOT NULL
    DROP FUNCTION dbo.fnNYSIIS;
IF OBJECT_ID('dbo.NYSIIS_Replacements') IS NOT NULL
    DROP TABLE dbo.NYSIIS_Replacements;
GO
-- Create the NYSIIS replacement rules table
CREATE TABLE dbo.NYSIIS_Replacements 
   (Location NVARCHAR(10) NOT NULL,
    NGram NVARCHAR(10) NOT NULL,
    Replacement NVARCHAR(10) NOT NULL,
    PRIMARY KEY (Location, NGram));

-- The end-of-name n-gram rules
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement) 
    VALUES (N'End', N'AY', N'YY');
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement) 
    VALUES (N'End', N'DT', N'DD');
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement) 
    VALUES (N'End', N'EE', N'YY');
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement) 
    VALUES (N'End', N'EY', N'YY');
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement) 
    VALUES (N'End', N'IE', N'YY');
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement) 
    VALUES (N'End', N'IY', N'YY');
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement) 
    VALUES (N'End', N'ND', N'DD');
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement) 
    VALUES (N'End', N'NT', N'DD');
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement) 
    VALUES (N'End', N'OY', N'YY');
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement) 
    VALUES (N'End', N'RD', N'DD');
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement)
    VALUES (N'End', N'RT', N'DD');
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement) 
    VALUES (N'End', N'UY', N'YY');

-- The middle-of-name n-gram rules
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement) 
    VALUES (N'Mid', N'A', N'A');
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement) 
    VALUES (N'Mid', N'E', N'A');
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement) 
    VALUES (N'Mid', N'I', N'A');
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement) 
    VALUES (N'Mid', N'K', N'C');
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement) 
    VALUES (N'Mid', N'M', N'N');
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement) 
    VALUES (N'Mid', N'O', N'A');
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement)
    VALUES (N'Mid', N'Q', N'G');
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement) 
    VALUES (N'Mid', N'U', N'A');
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement) 
    VALUES (N'Mid', N'Z', N'S');
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement) 
    VALUES (N'Mid', N'AW', N'AA');
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement) 
    VALUES (N'Mid', N'EV', N'AF');
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement) 
    VALUES (N'Mid', N'EW', N'AA');
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement) 
    VALUES (N'Mid', N'IW', N'AA');
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement) 
    VALUES (N'Mid', N'KN', N'NN');
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement) 
    VALUES (N'Mid', N'OW', N'AA');
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement) 
    VALUES (N'Mid', N'PH', N'FF');
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement) 
    VALUES (N'Mid', N'UW', N'AA');
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement) 
    VALUES (N'Mid', N'SCH', N'SSS');

-- The start-of-name n-gram rules
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement)
    VALUES (N'Start', N'K', N'C');
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement)
    VALUES (N'Start', N'KN', N'NN');
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement) 
    VALUES (N'Start', N'PF', N'FF');
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement) 
    VALUES (N'Start', N'PH', N'FF');
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement) 
    VALUES (N'Start', N'MAC', N'MCC');
INSERT INTO NYSIIS_Replacements (Location, NGram, Replacement) 
    VALUES (N'Start', N'SCH', N'SSS');
GO
CREATE FUNCTION dbo.fnNYSIIS (@Name NVARCHAR(50))
RETURNS NVARCHAR(50)
WITH RETURNS NULL ON NULL INPUT, SCHEMABINDING
AS
BEGIN
    DECLARE @Result NVARCHAR(50);   -- This will contain our end result
    SELECT @Result = UPPER(@Name);

    -- Replace the start n-gram
    SELECT TOP 1 @Result = STUFF(@Result, 1, LEN(NGram), Replacement)
    FROM dbo.NYSIIS_Replacements
    WHERE Location = N'Start'
        AND SUBSTRING(@Result, 1, LEN(NGram)) = NGram
    ORDER BY LEN(NGram) DESC;

    -- Replace the end n-gram
    SELECT TOP 1 @Result = STUFF(@Result, LEN(@Result) - LEN(NGram) + 1,
        LEN(NGram), Replacement)
    FROM dbo.NYSIIS_Replacements
    WHERE Location = N'End'
        AND SUBSTRING(@Result, LEN(@Result) - LEN(NGram) + 1, LEN(NGram)) = NGram
    ORDER BY LEN(NGram) DESC;

    -- Store the first letter of the name
    DECLARE @first_letter NCHAR(1)
    SELECT @first_letter = SUBSTRING(@Result, 1, 1);

    -- Replace all middle n-grams
    DECLARE @replacement NVARCHAR(10);
    DECLARE @i INT;
    SELECT @i = 1;
    WHILE @i <= LEN(@Result)
    BEGIN
        SELECT @replacement = NULL;

        -- Grab the middle-of-name replacement n-gram
        SELECT TOP 1 @replacement = Replacement
        FROM dbo.NYSIIS_Replacements
        WHERE Location = N'Mid'
            AND SUBSTRING(@Result, @i, LEN(NGram)) = NGram
        ORDER BY LEN(NGram) DESC;

        -- If we found a replacement, apply it
        IF @replacement IS NOT NULL
            SELECT @Result = STUFF(@Result, @i, LEN(@replacement), @replacement);

        -- Move on to the next n-gram
        SELECT @i = @i + COALESCE(LEN(@replacement), 1);
    END;

    -- Replace the first character with the first letter we saved at the start
    SELECT @Result = STUFF(@Result, 1, 1, @first_letter);

    -- Here we apply our special rules for the ‘H’ character
    SELECT @Result = 
        STUFF(@Result, Num, 1, 
            CASE SUBSTRING(@Result, Num, 1)
                WHEN N'H'
                THEN
                    CASE 
                        WHEN SUBSTRING(@Result, Num + 1, 1) NOT IN (N'A', N'E', N'I', N'O', N'U') 
                            OR SUBSTRING(@Result, Num - 1, 1) NOT IN (N'A', N'E', N'I', N'O', N'U')
                        THEN SUBSTRING(@Result, Num - 1, 1)
                        ELSE N'H'
                    END
                ELSE SUBSTRING(@Result, Num, 1)
            END)
    FROM dbo.Numbers 
    WHERE Num <= LEN(@Result);

    -- Here we replace the first letter of any sequence of two side-by-side duplicate
    -- letters with a period '.'
    SELECT @Result = 
        STUFF(@Result, Num, 1, 
            CASE SUBSTRING(@Result, Num, 1)
                WHEN SUBSTRING(@Result, Num + 1, 1) THEN N'.' 
                ELSE SUBSTRING(@Result, Num, 1) 
            END) 
    FROM dbo.Numbers 
    WHERE Num <= LEN(@Result);

    -- Next we replace all periods '.' with an empty string ''
    SELECT @Result = REPLACE(@Result, N'.', N'');

    -- Remove trailing 'S' characters
    WHILE RIGHT(@Result, 1) = N'S'
        SELECT @Result = STUFF(@Result, LEN(@Result), 1, N'');

    -- Remove trailing vowels
    WHILE RIGHT(@Result, 1) = N'A'
        SELECT @Result = STUFF(@Result, LEN(@Result), 1, N'');

    RETURN @Result;
END;
GO
SELECT LastName,
    dbo.fnNYSIIS(LastName) AS NYSIIS
FROM Person.Contact
GROUP BY LastName;
GO
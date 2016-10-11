-- Listing 4-8 from Chapter 4
USE AdventureWorks;
GO
-- Demonstrates Transact-SQL TRY...CATCH control-of-flow keywords.
CREATE TABLE #test_error (i INT NOT NULL PRIMARY KEY);

BEGIN TRY
    INSERT INTO #test_error (i) VALUES (1);
    INSERT INTO #test_error (i) VALUES (1); -- This INSERT causes the error.
END TRY
BEGIN CATCH
    PRINT ERROR_NUMBER();
    PRINT ERROR_SEVERITY();
    PRINT ERROR_STATE();
    PRINT ERROR_PROCEDURE();
    PRINT ERROR_LINE();
    PRINT ERROR_MESSAGE();
END CATCH

DROP TABLE #test_error;
GO
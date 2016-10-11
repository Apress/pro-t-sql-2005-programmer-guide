-- Listing 6-4 from Chapter 6
USE AdventureWorks;
GO
-- Demonstrates a stored procedure to solve the Towers of Hanoi
IF OBJECT_ID('dbo.ShowTowers') IS NOT NULL
    DROP PROCEDURE dbo.ShowTowers;
IF OBJECT_ID('dbo.MoveOneDisc') IS NOT NULL
    DROP PROCEDURE dbo.MoveOneDisc;
IF OBJECT_ID('dbo.MoveDiscs') IS NOT NULL
    DROP PROCEDURE dbo.MoveDiscs;
IF OBJECT_ID('dbo.SolveTowers') IS NOT NULL
    DROP PROCEDURE dbo.SolveTowers;
GO
-- This stored procedure displays all the discs in the appropriate
-- towers.
CREATE PROCEDURE dbo.ShowTowers
AS
BEGIN
    -- Each disc is displayed as a series of asterisks (*), centered, with 
    -- the appropriate width. Using FULL OUTER JOIN allows us to show all 
    -- three towers side by side in a single query.
    SELECT REPLICATE(' ', COALESCE(5 - a.Disc, 0)) +  
            REPLICATE('**', COALESCE(a.Disc, 0)) AS Tower_A, 
        REPLICATE(' ', COALESCE(5 - b.Disc, 0)) + 
            REPLICATE('**', COALESCE(b.Disc, 0)) AS Tower_B, 
        REPLICATE(' ', COALESCE(5 - c.Disc, 0)) + 
            REPLICATE('**', COALESCE(c.Disc, 0)) AS Tower_C
    FROM #TowerA a
    FULL OUTER JOIN #TowerB b
        ON a.Disc = b.Disc
    FULL OUTER JOIN #TowerC c
        ON a.Disc = b.Disc;
END;
GO

-- This SP moves a single disc from the specified source tower to the
-- specified destination tower.
CREATE PROCEDURE dbo.MoveOneDisc (@Source NCHAR(1),
    @Dest NCHAR(1))
AS
BEGIN
    -- @Top is the smallest disc on the source tower
    DECLARE @Top INT;
    -- We use IF ... ELSE to get the smallest disc from the source tower
    IF @Source = N'A'
    BEGIN
        -- This gets the smallest disc from Tower A
        SELECT @Top = MIN(Disc)
        FROM #TowerA;
        -- Then we delete it
        DELETE FROM #TowerA 
        WHERE Disc = @Top;
    END ELSE IF @Source = N'B'
    BEGIN
        -- This gets the smallest disc from Tower B
        SELECT @Top = MIN(Disc)
        FROM #TowerB;
        -- Then we delete it
        DELETE FROM #TowerB
        WHERE Disc = @Top;
    END ELSE IF @Source = N'C'
    BEGIN
        -- This gets the smallest disc from Tower C
        SELECT @Top = MIN(Disc)
        FROM #TowerC;
        -- Then we delete it
        DELETE FROM #TowerC
        WHERE Disc = @Top;
    END
    -- Print out the disc move performed
    PRINT N'Move Disc #' + CAST(COALESCE(@Top, 0) AS NCHAR(1)) + N' from Tower ' +
        @Source + N' to Tower ' + @Dest;
    -- Perform the move: INSERT the disc from the source tower to the
    -- destination tower
    IF @Dest = N'A'
        INSERT INTO #TowerA (Disc) VALUES (@Top);
    ELSE IF @Dest = N'B'
        INSERT INTO #TowerB (Disc) VALUES (@Top);
    ELSE IF @Dest = N'C'
        INSERT INTO #TowerC (Disc) VALUES (@Top);
    -- Show the towers
    EXECUTE dbo.ShowTowers;
END;
GO

-- This SP moves multiple discs recursively
CREATE PROCEDURE dbo.MoveDiscs (@DiscNum INT, 
    @MoveNum INT OUTPUT,
    @Source NCHAR(1) = N'A',
    @Dest NCHAR(1) = N'C',
    @Aux NCHAR(1) = N'B'
)
AS
BEGIN
    -- If the number of discs to move is 0, we're done
    IF @DiscNum = 0 
        PRINT N'Done';
    ELSE
    BEGIN
        -- If the number of discs to move is 1, go ahead and move it
        IF @DiscNum = 1
        BEGIN
            -- Increase the move counter
            SELECT @MoveNum = @MoveNum + 1;
            -- And move one disc from source to destination
            EXEC dbo.MoveOneDisc @Source, @Dest
        END
        ELSE
        BEGIN
            DECLARE @n INT
            SELECT @n = @DiscNum - 1
            -- Move (@DiscNum - 1) discs from Source to Auxiliary tower
            EXEC dbo.MoveDiscs @n, @MoveNum OUTPUT, @Source, @Aux, @Dest;
            -- Move 1 Disc from Source to Destination tower
            EXEC dbo.MoveDiscs 1, @MoveNum OUTPUT, @Source, @Dest, @Aux;
            -- Move (@DiscNum - 1) discs from Auxiliary to Destination tower
            EXEC dbo.MoveDiscs @n, @MoveNum OUTPUT, @Aux, @Dest, @Source;
        END;
    END;
END;
GO

-- This SP creates the three towers and populates Tower A with 5 discs
CREATE PROCEDURE dbo.SolveTowers
AS
BEGIN
    -- SET NOCOUNT ON to eliminate system messages that will clutter up
    -- the Message display
    SET NOCOUNT ON
    -- Create the three towers: Tower A = Source, Tower B = Auxiliary,
    -- Tower C = Destination
    CREATE TABLE #TowerA (Disc INT PRIMARY KEY NOT NULL);
    CREATE TABLE #TowerB (Disc INT PRIMARY KEY NOT NULL);
    CREATE TABLE #TowerC (Disc INT PRIMARY KEY NOT NULL);
    -- Populate Tower A with 5 discs
    INSERT INTO #TowerA (Disc) VALUES (1);
    INSERT INTO #TowerA (Disc) VALUES (2);
    INSERT INTO #TowerA (Disc) VALUES (3);
    INSERT INTO #TowerA (Disc) VALUES (4);
    INSERT INTO #TowerA (Disc) VALUES (5);
    -- Initialize the move number to 0
    DECLARE @MoveNum INT;
    SELECT @MoveNum = 0;
    -- Show the initial state of the towers
    EXECUTE dbo.ShowTowers;
    -- Solve the puzzle. Notice we don’t need to specify the parameters with defaults
    EXECUTE dbo.MoveDiscs 5, @MoveNum OUTPUT;
    -- How many moves did it take?
    PRINT N'Solved in ' + CAST (@MoveNum AS NVARCHAR(10)) + N' moves.';
    -- Drop the temp tables
    DROP TABLE #TowerC;
    DROP TABLE #TowerB;
    DROP TABLE #TowerA;
    -- SET NOCOUNT OFF before we exit
    SET NOCOUNT OFF
END;
GO
-- Solve the puzzle
EXECUTE dbo.SolveTowers;
GO
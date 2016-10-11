-- Listing 7-4 from Chapter 7
USE AdventureWorks;
GO
IF OBJECT_ID('Production.Trg_EnforceStandardSizes') IS NOT NULL
    DROP TRIGGER Production.Trg_EnforceStandardSizes;
GO
-- AFTER INSERT, UPDATE trigger to enforce standard sizes
CREATE TRIGGER Production.Trg_EnforceStandardSizes
ON Production.Product
AFTER INSERT, UPDATE
NOT FOR REPLICATION
AS
BEGIN
    IF (@@ROWCOUNT > 0) AND (UPDATE(SizeUnitMeasureCode) OR UPDATE(Size))
    BEGIN
        SET NOCOUNT ON;
        IF EXISTS(SELECT SizeUnitMeasureCode 
            FROM inserted
            WHERE SizeUnitMeasureCode 
            NOT IN (N'M', N'DM', N'CM', N'MM', N'IN'))
        BEGIN
            RAISERROR ('Invalid Size Unit Measure Code.', 14, 127);
            ROLLBACK TRANSACTION;
        END
        ELSE
        BEGIN
            UPDATE Production.Product
            SET SizeUnitMeasureCode = N'CM',
                Size = CAST(CAST(CASE i.SizeUnitMeasureCode
                    WHEN N'M' THEN CAST(i.Size AS FLOAT) * 100.0
                    WHEN N'DM' THEN CAST(i.Size AS FLOAT) * 10.0
                    WHEN N'CM' THEN CAST(i.Size AS FLOAT)
                    WHEN N'MM' THEN CAST(i.Size AS FLOAT) * 0.10
                    WHEN N'IN' THEN CAST(i.Size AS FLOAT) * 2.54
                    END
                AS INTEGER) AS NCHAR(5))
            FROM inserted i
            WHERE Production.Product.ProductID = i.ProductID;
        END;
    END;
END;
GO

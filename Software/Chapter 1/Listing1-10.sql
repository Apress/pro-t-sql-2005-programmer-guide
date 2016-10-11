-- Sample program Listing 1-10 from Chapter 1

USE AdventureWorks;
GO
SELECT o.name
FROM sys.objects o
LEFT  JOIN sys.views v
    ON o.object_id = v.object_id;
GO

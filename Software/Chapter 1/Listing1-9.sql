-- Sample program Listing 1-9 from Chapter 1

USE AdventureWorks;
GO
-- This query generates a very elaborate error message because it is using
-- the deprecated *= join operator
SELECT o.name
FROM sys.objects o, 
     sys.views v
WHERE o.object_id *= v.object_id;
GO

-- Listing 12-21 from Chapter 12
USE AdventureWorks;
GO

DECLARE @x XML;
SELECT @x = N'<?xml version = "1.0" ?>
<Animal>
    Cat
</Animal>';

SELECT @x.query(N'9 eq 9.0                     (: 9 is equal to 9.0 :)');
SELECT @x.query(N'4 gt 3                       (: 4 is greater than 3 :)');
SELECT @x.query(N'(/Animal/text())[1] lt "Dog" (: Cat is less than Dog :)') ;
GO
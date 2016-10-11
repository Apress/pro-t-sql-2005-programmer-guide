-- Listing 12-23 from Chapter 12
USE AdventureWorks;
GO

DECLARE @x xml;
SELECT @x = '';
SELECT @x.query('(3.141592, 1) = (2, 3.141592)                   (: true :) ');
SELECT @x.query('(1.0, 2.0, 3.0) = 1                             (: true :) ');
SELECT @x.query('("Joe", "Harold") < "Adam"                      (: false :) ');
SELECT @x.query('xs:date("1999-01-01Z") < xs:date("2006-01-01Z") (: true :)');
GO
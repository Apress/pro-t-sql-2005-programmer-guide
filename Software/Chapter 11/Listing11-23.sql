-- Listing 11-23 from Chapter 11

-- This script requires the scripts in Listing 11-21 and the SQLCLR SP from
-- Listing 11-22
USE AdventureWorks;
GO

EXECUTE XmlToHtml @xml, @xslt, 'c:\adventureworks-inventory.html';
GO
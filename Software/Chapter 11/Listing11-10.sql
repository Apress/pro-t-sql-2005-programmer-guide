-- Listing 11-10 from Chapter 11
USE AdventureWorks;
GO

DECLARE @x XML;
CREATE TABLE XmlPurchaseOrders(PoNum INT NOT NULL PRIMARY KEY,
	XmlPO XML);
GO

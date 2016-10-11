-- Listing 8-4 from Chapter 8
USE AdventureWorks;
GO
-- Sign by Asymmetric Key
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Test_P@ssw0rd';
 
CREATE ASYMMETRIC KEY TestAsymKey
WITH ALGORITHM = RSA_512

DECLARE @quote NVARCHAR(4000);
SELECT @quote = N'Alas, poor Yorick!';
SELECT @quote;

SELECT SignByAsymKey(AsymKey_ID(N'TestAsymKey'), @quote);

DROP ASYMMETRIC KEY TestAsymKey;

DROP MASTER KEY;
GO
-- Listing 8-3 from Chapter 8
USE AdventureWorks;
GO
-- Encrypt/Decrypt by Asymmetric Key
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Test_P@ssw0rd';
 
CREATE ASYMMETRIC KEY TestAsymKey
WITH ALGORITHM = RSA_512

DECLARE @credit_card NVARCHAR(26);
SELECT @credit_card = N'9000 1234 5678 9012';
SELECT @credit_card;

DECLARE @enc_credit_card VARBINARY(64);
SELECT @enc_credit_card = EncryptByAsymKey(AsymKey_ID(N'TestAsymKey'), @credit_card);
SELECT @enc_credit_card;

DECLARE @dec_credit_card NVARCHAR(26);
SELECT @dec_credit_card = DecryptByAsymKey(AsymKey_ID(N'TestAsymKey'), @enc_credit_card);
SELECT @dec_credit_card;

DROP ASYMMETRIC KEY TestAsymKey;

DROP MASTER KEY;
GO
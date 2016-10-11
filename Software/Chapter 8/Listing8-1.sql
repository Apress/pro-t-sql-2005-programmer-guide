-- Listing 8-1 from Chapter 8
USE AdventureWorks;
GO
-- Encryption by certificate sample
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Test_P@ssw0rd';
 
CREATE CERTIFICATE TestCertificate
    WITH SUBJECT = 'Adventureworks Test Certificate',
    EXPIRY_DATE = '10/31/2026';

DECLARE @s NVARCHAR(58);
SELECT @s = N'This is a test string to encrypt';
SELECT @s;

DECLARE @e VARBINARY(128);
SELECT @e = EncryptByCert(Cert_ID('TestCertificate'), @s);
SELECT @e;

DECLARE @d NVARCHAR(58);
SELECT @d = DecryptByCert(Cert_ID('TestCertificate'), @e);
SELECT @d;

DROP CERTIFICATE TestCertificate;

DROP MASTER KEY;
GO
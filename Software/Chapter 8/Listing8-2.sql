-- Listing 8-2 from Chapter 8
USE AdventureWorks;
GO
-- SignByCert sample
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Test_P@ssw0rd';
 
CREATE CERTIFICATE TestCertificate
    WITH SUBJECT = 'Adventureworks Test Certificate',
    EXPIRY_DATE = '10/31/2026';

DECLARE @speech NVARCHAR(4000);
SELECT @speech = N'Four score and seven years ago, our fathers brought ' +
	N'forth on this continent a new nation, conceived in Liberty, ' +
	N'and dedicated to the proposition that all men are created ' +
	N'equal. ';
SELECT @speech;

SELECT SignByCert(Cert_ID(N'TestCertificate'), @speech);

DROP CERTIFICATE TestCertificate;

DROP MASTER KEY;
GO
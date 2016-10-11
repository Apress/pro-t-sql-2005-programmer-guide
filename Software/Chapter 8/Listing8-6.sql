-- Listing 8-6 from Chapter 8
USE AdventureWorks;
GO
-- Hashing and encryption by pass phrase
DECLARE @plaintext NVARCHAR(256)
DECLARE @enctext VARBINARY(512)
DECLARE @dectext NVARCHAR(256)

SELECT @plaintext = N'To be, or not to be: that is the question: ' +
    N'Whether ''tis nobler in the mind to suffer ' +
    N'The slings and arrows of outrageous fortune, ' +
    N'Or to take arms against a sea of troubles '

SELECT @enctext = EncryptByPassPhrase (N'Shakespeare', @plaintext);
SELECT @dectext = CAST (DecryptByPassPhrase (N'Shakespeare', @enctext) AS NVARCHAR(128));

SELECT @plaintext;
SELECT @enctext;
SELECT @dectext;
SELECT HashBytes ('SHA1', @plaintext);
GO
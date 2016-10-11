-- Listing 8-5 from Chapter 8
USE AdventureWorks;
GO
-- Encryption and Decryption by Symmetric Key
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Test_P@ssw0rd';

CREATE CERTIFICATE TestCertificate
    WITH SUBJECT = 'AdventureWorks Test Certificate',
    EXPIRY_DATE = '10/31/2036';

CREATE SYMMETRIC KEY TestSymmetricKey
    WITH ALGORITHM = TRIPLE_DES
    ENCRYPTION BY CERTIFICATE TestCertificate;

OPEN SYMMETRIC KEY TestSymmetricKey
    DECRYPTION BY CERTIFICATE TestCertificate;

CREATE TABLE #Temp (ContactID   INT PRIMARY KEY,
    FirstName   NVARCHAR(200),
    MiddleName  NVARCHAR(200),
    LastName    NVARCHAR(200),
    eFirstName  VARBINARY(200),
    eMiddleName VARBINARY(200),
    eLastName   VARBINARY(200));

INSERT
    INTO #Temp (ContactID, eFirstName, eMiddleName, eLastName)
    SELECT ContactID,
        EncryptByKey(Key_GUID('TestSymmetricKey'), FirstName),
        EncryptByKey(Key_GUID('TestSymmetricKey'), MiddleName),
        EncryptByKey(Key_GUID('TestSymmetricKey'), LastName)
FROM Person.Contact
    WHERE ContactID <= 100;

UPDATE #Temp
    SET FirstName = DecryptByKey(eFirstName),
        MiddleName = DecryptByKey(eMiddleName),
        LastName = DecryptByKey(eLastName);

SELECT ContactID,
    FirstName,
    MiddleName,
    LastName,
    eFirstName,
    eMiddleName,
    eLastName
FROM #Temp;

DROP TABLE #Temp;
CLOSE SYMMETRIC KEY TestSymmetricKey;

DROP SYMMETRIC KEY TestSymmetricKey;
DROP CERTIFICATE TestCertificate;
DROP MASTER KEY;
GO
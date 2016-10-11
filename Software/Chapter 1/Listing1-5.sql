-- Sample program Listing 1-5 from Chapter 1

USE AdventureWorks;
GO
SELECT I.CUSTOMERID, C.TITLE, C.FIRSTNAME, C.MIDDLENAME,
    C.LASTNAME, C.SUFFIX, C.PHONE, C.EMAILADDRESS,
    C.EMAILPROMOTION
FROM SALES.INDIVIDUAL I
INNER JOIN PERSON.CONTACT C
    ON C.CONTACTID = I.CONTACTID
INNER JOIN SALES.CUSTOMERADDRESS CA
    ON CA.CUSTOMERID = I.CUSTOMERID;
GO
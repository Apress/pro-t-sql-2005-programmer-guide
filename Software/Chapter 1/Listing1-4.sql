-- Sample program Listing 1-4 from Chapter 1

USE AdventureWorks;
GO
SELECT e.EmployeeID, 
    c.Title, 
    c.FirstName, 
    c.MiddleName,
    c.LastName, 
    c.Suffix, 
    e.Title AS JobTitle, 
    c.Phone, 
    c.EmailAddress, 
    c.EmailPromotion, 
    a.AddressLine1, 
    a.AddressLine2, 
    a.City, 
    sp.Name AS StateProvinceName, 
    a.PostalCode, 
    cr.Name AS CountryRegionName, 
    c.AdditionalContactInfo 
FROM HumanResources.Employee e 
INNER JOIN Person.Contact c 
    ON c.ContactID = e.ContactID 
INNER JOIN HumanResources.EmployeeAddress ea 
    ON e.EmployeeID = ea.EmployeeID 
INNER JOIN Person.Address a 
    ON ea.AddressID = a.AddressID 
INNER JOIN Person.StateProvince sp 
    ON sp.StateProvinceID = a.StateProvinceID
INNER JOIN Person.CountryRegion cr 
    ON cr.CountryRegionCode = sp.CountryRegionCode;
GO
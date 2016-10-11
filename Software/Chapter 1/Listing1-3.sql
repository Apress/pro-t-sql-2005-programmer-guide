-- Sample program Listing 1-3 from Chapter 1

USE AdventureWorks;
GO
SELECT [HumanResources].[Employee].[EmployeeID], [Person].[Contact].[Title],
[Person].[Contact].[FirstName], [Person].[Contact].[MiddleName],
[Person].[Contact].[LastName], [Person].[Contact].[Suffix], 
[HumanResources].[Employee].[Title] AS [JobTitle], [Person].[Contact].[Phone], 
[Person].[Contact].[EmailAddress], [Person].[Contact].[EmailPromotion], 
[Person].[Address].[AddressLine1], [Person].[Address].[AddressLine2], 
[Person].[Address].[City], [Person].[StateProvince].[Name] AS [StateProvinceName], 
[Person].[Address].[PostalCode], [Person].[CountryRegion].[Name] AS 
[CountryRegionName], [Person].[Contact].[AdditionalContactInfo] FROM 
[HumanResources].[Employee] INNER JOIN [Person].[Contact] ON 
[Person].[Contact].[ContactID] = [HumanResources].[Employee].[ContactID] INNER JOIN 
[HumanResources].[EmployeeAddress] ON [HumanResources].[Employee].[EmployeeID] = 
[HumanResources].[EmployeeAddress].[EmployeeID] INNER JOIN [Person].[Address] ON 
[HumanResources].[EmployeeAddress].[AddressID] = [Person].[Address].[AddressID] INNER 
JOIN [Person].[StateProvince] ON [Person].[StateProvince].[StateProvinceID] = 
[Person].[Address].[StateProvinceID] INNER JOIN [Person].[CountryRegion] ON 
[Person].[CountryRegion].[CountryRegionCode] = [Person].[StateProvince].[CountryRegionCode]
GO
-- Listing 11-9 from Chapter 11
USE AdventureWorks;
GO

DECLARE @docHandle INT;
DECLARE @xmlDocument NVARCHAR(MAX);
SET @xmlDocument = N'<Customers>
    <Customer CustomerID="1234" ContactName="Larry" CompanyName="APress">
        <Orders>
            <Order OrderDate="2006-04-25T13:22:18"/>
            <Order OrderDate="2006-05-10T12:35:49"/>
        </Orders>
    </Customer>
    <Customer CustomerID="4567" ContactName="Bill" CompanyName="Microsoft">
        <Orders>
            <Order OrderDate="2006-03-12T18:32:39"/>
            <Order OrderDate="2006-05-11T17:56:12"/>
        </Orders>
    </Customer>
</Customers>';

EXECUTE sp_xml_preparedocument @docHandle OUTPUT, @xmlDocument;

CREATE TABLE #OrderInfo (CustomerID NCHAR(4) NOT NULL,
    CustomerName NVARCHAR(50) NOT NULL,
    CompanyName NVARCHAR(50) NOT NULL,
    OrderDate NVARCHAR(50) NOT NULL,
    PRIMARY KEY(CustomerID, CustomerName, CompanyName, OrderDate));

INSERT INTO #OrderInfo (CustomerID, CustomerName, CompanyName, OrderDate)
SELECT CustomerID,
    CustomerName,
    CompanyName,
    OrderDate
FROM OPENXML(@docHandle, N'/Customers/Customer/Orders/Order')
WITH (CustomerID NCHAR(4) N'../../@CustomerID',
    CustomerName NVARCHAR(50) N'../../@ContactName',
    CompanyName NVARCHAR(50) N'../../@CompanyName',
    OrderDate DATETIME);

SELECT CustomerID,
    CustomerName,
    CompanyName,
    OrderDate
FROM #OrderInfo;

DROP TABLE #OrderInfo;

EXECUTE sp_xml_removedocument @docHandle;
GO
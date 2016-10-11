-- Listing 16-4 from Chapter 16
USE AdventureWorks;
GO

CREATE ENDPOINT AdvSalesEndpoint
    STATE = STARTED
AS HTTP
(
    PATH = N'/AdvSalesSql',
    AUTHENTICATION = (INTEGRATED),
    PORTS = (CLEAR),
    SITE = N'*'
)
FOR SOAP
(
    WEBMETHOD N'GetSalespersonList'
    (
        NAME = N'AdventureWorks.Sales.GetSalespersonList',
        FORMAT = ROWSETS_ONLY
    ),
    WEBMETHOD N'GetSalesPersonSales'
    (
        NAME = N'AdventureWorks.Sales.GetSalesPersonSales',
        FORMAT = ROWSETS_ONLY
    ),
    WEBMETHOD 'GetSalesTotal'
    (
        NAME = N'AdventureWorks.Sales.GetSalesTotal'
    ),
    WSDL = DEFAULT,
    DATABASE = N'AdventureWorks',
    SCHEMA = STANDARD
);
GO



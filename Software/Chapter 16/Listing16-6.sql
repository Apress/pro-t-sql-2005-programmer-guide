-- Listing 16-6 from Chapter 16
USE AdventureWorks;
GO

CREATE ENDPOINT AdvAdHocEndpoint
    STATE = STARTED
AS HTTP (
    PATH = N'/AdvAdhocSql',
    AUTHENTICATION = (INTEGRATED),
    PORTS = (CLEAR),
    SITE = N'*'
)
FOR SOAP (
    WSDL = DEFAULT,
    DATABASE = N'AdventureWorks',
    SCHEMA = STANDARD,
    BATCHES = ENABLED
);
GO




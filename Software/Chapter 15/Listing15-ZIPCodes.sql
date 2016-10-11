-- Listing 15-ZIPCodes from Chapter 15

-- This script needs to be run to create the ZIP Codes table before
-- the code in Listing 15-5 is run

CREATE TABLE ZipCodes (ZIP CHAR(5) NOT NULL PRIMARY KEY,
    Latitude NUMERIC(8, 4) NOT NULL,
    Longitude NUMERIC(8, 4) NOT NULL,
    City NVARCHAR(50) NOT NULL,
    State CHAR(2) NOT NULL)
GO

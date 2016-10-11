-- Listing 12-20 from Chapter 12
USE AdventureWorks;
GO

DECLARE @x XML;
SELECT @x = N'<?xml version = "1.0"?>
<Geocode>
    <Info ID = "1">
        <Location Type = "Business">
            <Name>APress, Inc.</Name>
            <Address>
                <Street>2560 Ninth St, Ste 219</Street>
                <City>Berkeley</City>
                <State>CA</State>
                <Zip>94710-2500</Zip>
                <Country>US</Country>
            </Address>
        </Location>
    </Info>
</Geocode>';

SELECT @x.query(N'element Companies
    {
        element FirstCompany
        {
            attribute CompanyID
            {
                (//Info/@ID)[1]
            },
            (//Info/Location/Name)[1]
        }
    }');
GO
-- Listing 12-19 from Chapter 12
USE AdventureWorks;
GO

DECLARE @x XML;
SELECT @x = N'<?xml version = "1.0"?>
<Geocode>
    <Info ID = "1">
        <Location Type = "Business">
            <Name>APress, Inc.</Name>
        </Location>
    </Info>
    <Info ID = "2">
        <Location Type = "Business">
            <Name>Google, Inc.</Name>
        </Location>
    </Info>
</Geocode>';

SELECT @x.query(N'<Companies>
    {
        //Info/Location/Name
    }
</Companies>');
GO
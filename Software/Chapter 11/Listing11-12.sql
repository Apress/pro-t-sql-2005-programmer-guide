-- Listing 11-12 from Chapter 11
USE AdventureWorks;
GO

CREATE XML SCHEMA COLLECTION AddressSchemaCollection
AS N'<?xml version="1.0" encoding="utf-16" ?>
    <xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema">
        <xsd:element name="Address">
            <xsd:complexType>
                <xsd:sequence>
                    <xsd:element name="Latitude" type="xsd:decimal" />
                    <xsd:element name="Longitude" type="xsd:decimal" />
                    <xsd:element name="Street" type="xsd:string" />
                    <xsd:element name="City" type="xsd:string" />
                    <xsd:element name="State" type="xsd:string" />
                    <xsd:element name="Zip" type="xsd:string" />
                    <xsd:element name="Country" type="xsd:string" />
                </xsd:sequence>
            </xsd:complexType>
        </xsd:element>
    </xsd:schema>';
GO

DECLARE @x XML (CONTENT AddressSchemaCollection);

SELECT @x = N'<?xml version="1.0" ?>
<Address>
    <Latitude>47.642737</Latitude>
    <Longitude>-122.130395</Longitude>
    <Street>ONE MICROSOFT WAY</Street>
    <City>REDMOND</City>
    <State>WA</State>
    <Zip>98052</Zip>
    <Country>US</Country>
</Address>';

SELECT @x;

DROP XML SCHEMA COLLECTION AddressSchemaCollection;
GO
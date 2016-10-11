-- Examples for queries that exercise different SQL objects implemented by this assembly

-----------------------------------------------------------------------------------------
-- Stored procedure
-----------------------------------------------------------------------------------------
-- Listing 11-22 from Chapter 11

DECLARE @xml XML;
SELECT @xml = (
	SELECT p.ProductNumber AS '@Id',
		p.Name AS 'Name',
		p.Color AS 'Color',
		p.ListPrice AS 'ListPrice',
		p.SizeUnitMeasureCode AS 'Size/@UOM',
		p.Size AS 'Size',
		p.WeightUnitMeasureCode AS 'Weight/@UOM',
		p.Weight AS 'Weight',
		(
			SELECT COALESCE(SUM(i.Quantity), 0)
			FROM Production.ProductInventory i
			WHERE i.ProductID = p.ProductID
		) AS 'QuantityOnHand'
	FROM Production.Product p
	WHERE FinishedGoodsFlag = 1
	ORDER BY p.Name
	FOR XML PATH ('Product'),
		ROOT ('Products')
);

DECLARE @xslt XML;
SELECT @xslt = N'<?xml version="1.0" encoding="utf-16"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/Products">
        <html>
            <head>
                <title>AdventureWorks Product Listing Report</title>
                <style type="text/css">
                    tr.row-heading {
                        background-color: 000099;
                        color: ffffff;
                        font-family: tahoma, arial, helvetica, sans-serif;
                        font-size: 12px;
                    }
                    tr.row-light {
                        background-color: ffffff;
                        font-family: tahoma, arial, helvetica, sans-serif;
                        font-size: 12px;
                    }
                    tr.row-dark {
                        background-color: 00ffff;
                        font-family: tahoma, arial, helvetica, sans-serif;
                        font-size: 12px;
                    }
                    td.col-right {
                        text-align: right;
                    }
                </style>
            </head>
            <body>
                <table>
                    <tr class="row-heading">
                        <th>ID</th>
                        <th>Product Name</th>
                        <th>On Hand</th>
                        <th>List Price</th>
                        <th>Color</th>
                        <th>Size</th>
                        <th>Weight</th>
                    </tr>
                    <xsl:for-each select="Product">
                        <xsl:element name="tr">
                            <xsl:choose>
                                <xsl:when test="position() mod 2 = 0">
                                    <xsl:attribute name="class">row-light</xsl:attribute>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:attribute name="class">row-dark</xsl:attribute>
                                </xsl:otherwise>
                            </xsl:choose>
                            <td><xsl:value-of select="@Id"/></td>
                            <td><xsl:value-of select="Name"/></td>
                            <td class="col-right">
                                <xsl:value-of select="QuantityOnHand"/>
                            </td>
                            <td class="col-right"><xsl:value-of select="ListPrice"/></td>
                            <td><xsl:value-of select="Color"/></td>
                            <td class="col-right">
                                <xsl:value-of select="Size"/>
                                <xsl:value-of select="Size/@UOM"/>
                            </td>
                            <td class="col-right">
                                <xsl:value-of select="Weight"/>
                                <xsl:value-of select="Weight/@UOM"/>
                            </td>
                        </xsl:element>
                    </xsl:for-each>
                </table>
		    </body>
        </html>
    </xsl:template>
</xsl:stylesheet>';

EXECUTE XmlToHtml @xml, @xslt, N'c:\adventureworks-inventory.html'; 



-----------------------------------------------------------------------------------------
-- User defined function
-----------------------------------------------------------------------------------------
-- select dbo.FunctionName()


-----------------------------------------------------------------------------------------
-- User defined type
-----------------------------------------------------------------------------------------
-- CREATE TABLE test_table (col1 UserType)
-- go
--
-- INSERT INTO test_table VALUES (convert(uri, 'Instantiation String 1'))
-- INSERT INTO test_table VALUES (convert(uri, 'Instantiation String 2'))
-- INSERT INTO test_table VALUES (convert(uri, 'Instantiation String 3'))
--
-- select col1::method1() from test_table



-----------------------------------------------------------------------------------------
-- User defined type
-----------------------------------------------------------------------------------------
-- select dbo.AggregateName(Column1) from Table1


select 'To run your project, please edit the Test.sql file in your project. This file is located in the Test Scripts folder in the Solution Explorer.'

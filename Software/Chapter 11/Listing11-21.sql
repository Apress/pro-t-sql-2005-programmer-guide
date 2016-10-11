-- Listing 11-21 from Chapter 11
USE AdventureWorks;
GO

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
GO

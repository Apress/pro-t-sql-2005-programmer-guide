using System;
using System.Xml;
using System.Xml.Xsl;
using System.Data.SqlClient;
using System.Data.SqlTypes;

namespace Apress.Samples
{
    public partial class XSLT
    {
        [Microsoft.SqlServer.Server.SqlProcedure]
        public static void XmlToHtml(SqlXml RawXml,
                SqlXml XslStyleSheet,
                SqlString OutputPage)
        {
            // Create and load the XslCompiledTransform object
            XslCompiledTransform xslt = new XslCompiledTransform();
            XmlDocument xmldoc1 = new XmlDocument();
            xmldoc1.LoadXml(XslStyleSheet.Value);
            xslt.Load(xmldoc1);
            // Create and load the Raw XML document
            XmlDocument xml = new XmlDocument();
            xml.LoadXml(RawXml.Value);
            // Create the XmlTextWriter for output to HTML document
            XmlTextWriter htmlout = new XmlTextWriter(OutputPage.Value,
                System.Text.Encoding.Unicode);
            // Perform the transformation
            xslt.Transform(xml, htmlout);
            // Close the XmlTextWriter
            htmlout.Close();
        }
    }
};

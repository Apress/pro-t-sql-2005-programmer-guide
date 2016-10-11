Imports System.Data.SqlTypes
Imports System.Xml
Imports System.Xml.Xsl

Namespace APress.Samples
    Partial Public Class XSLT
        <Microsoft.SqlServer.Server.SqlProcedure()> _
        Public Shared Sub XmlToHtml(ByVal RawXml As SqlXml, _
            ByVal XslStyleSheet As SqlXml, _
            ByVal OutputPage As SqlString)
            ' Create and load the XslCompiledTransform object
            Dim xslt As New XslCompiledTransform()
            Dim xmldoc1 As New XmlDocument()
            xmldoc1.LoadXml(XslStyleSheet.Value)
            xslt.Load(xmldoc1)
            ' Create and load the Raw XML document
            Dim xml As New XmlDocument()
            xml.LoadXml(RawXml.Value)
            ' Create the XmlTextWriter for output to HTML document
            Dim htmlout As New XmlTextWriter(OutputPage.Value, _
            System.Text.Encoding.Unicode)
            ' Perform the transformation
            xslt.Transform(xml, htmlout)
            ' Close the XmlTextWriter
            htmlout.Close()
        End Sub
    End Class
End Namespace


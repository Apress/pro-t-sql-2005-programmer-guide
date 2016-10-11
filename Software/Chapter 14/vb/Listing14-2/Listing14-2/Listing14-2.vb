Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Data.SqlTypes
Imports Microsoft.SqlServer.Server
Imports System.Xml
Imports System.Runtime.InteropServices

Namespace APress.Samples
    Partial Public Class Sql
        <SqlFunction(IsDeterministic:=False, _
            DataAccess:=DataAccessKind.None, _
            TableDefinition:="title nvarchar(256), link nvarchar(256), " & _
                "pubdate datetime, description nvarchar(max)", _
            FillRowMethodName:="GetRow")> _
        Public Shared Function GetYahooNews() As IEnumerable
            Dim xmlsource As New _
                XmlTextReader("http://rss.news.yahoo.com/rss/topstories")
            Dim newsxml As New XmlDocument
            newsxml.Load(xmlsource)
            xmlsource.Close()
            Return newsxml.SelectNodes("//rss/channel/item")
        End Function

        Private Shared Sub GetRow(ByVal o As Object, _
            <Out()> ByRef title As SqlString, _
            <Out()> ByRef link As SqlString, _
            <Out()> ByRef pubdate As SqlDateTime, _
            <Out()> ByRef description As SqlString)
            Dim element As XmlElement
            element = DirectCast(o, XmlElement)
            title = element.SelectSingleNode("./title").InnerText
            link = element.SelectSingleNode("./link").InnerText
            pubdate = CType(element.SelectSingleNode("./pubDate").InnerText, _
                DateTime)
            description = element.SelectSingleNode("./description").InnerText
        End Sub
    End Class
End Namespace

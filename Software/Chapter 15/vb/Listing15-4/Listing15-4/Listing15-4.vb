Imports System.Data.SqlClient
Imports System.Xml

Namespace APress.Samples
    Module XmlReaderQuery
        Sub Main()
            Dim name As String = "SMITH"
            Dim sqlstmt As String = "SELECT ContactID, FirstName, " & _
                " COALESCE(MiddleName, '') AS MiddleName, LastName " & _
                " FROM Person.Contact " & _
                " WHERE LastName = @name FOR XML AUTO"
            Dim sqlcon As SqlConnection = Nothing
            Dim sqlcmd As SqlCommand = Nothing
            Dim sqlxr As XmlReader = Nothing
            Try
                sqlcon = New SqlConnection("SERVER=(local); " & _
                    "INITIAL CATALOG=AdventureWorks;INTEGRATED SECURITY=SSPI;")
                sqlcon.Open()
                sqlcmd = New SqlCommand(sqlstmt, sqlcon)
                sqlcmd.Parameters.Add("@name", SqlDbType.NVarChar, 50).Value = name
                sqlxr = sqlcmd.ExecuteXmlReader()
                Do While (sqlxr.Read())
                    Console.WriteLine("{0}" & ControlChars.Tab & _
                        "{1}," & ControlChars.Tab & _
                        "{2}" & ControlChars.Tab & _
                        "{3}" & ControlChars.Tab, _
                        sqlxr.Item("ContactID").ToString(), _
                        sqlxr.Item("LastName").ToString(), _
                        sqlxr.Item("FirstName").ToString(), _
                        sqlxr.Item("MiddleName").ToString())
                Loop
            Catch ex As Exception
                Console.WriteLine(ex.Message)
            Finally
                If Not (sqlxr Is Nothing) Then
                    sqlxr.Close()
                End If
                If Not (sqlcmd Is Nothing) Then
                    sqlcmd.Dispose()
                End If
                If Not (sqlcon Is Nothing) Then
                    sqlcon.Dispose()
                End If
            End Try
            Console.WriteLine("Press any key...")
            Console.ReadKey()
        End Sub
    End Module
End Namespace

Imports System.Data.SqlClient

Namespace APress.Samples
    Module ParameterizedQuery
        Sub Main()
            Dim name As String = "SMITH"
            Dim sqlstmt As String = _
                "SELECT ContactID, FirstName, MiddleName, LastName " & _
                " FROM Person.Contact " & _
                " WHERE LastName = @name"
            Dim sqlcon As SqlConnection = Nothing
            Dim sqlcmd As SqlCommand = Nothing
            Dim sqldr As SqlDataReader = Nothing
            Try
                sqlcon = New SqlConnection("SERVER=(local); " & _
                    "INITIAL CATALOG=AdventureWorks;INTEGRATED SECURITY=SSPI;")
                sqlcon.Open()
                sqlcmd = New SqlCommand(sqlstmt, sqlcon)
                sqlcmd.Parameters.Add("@name", SqlDbType.NVarChar, 50).Value = name
                sqldr = sqlcmd.ExecuteReader()
                Do While (sqldr.Read())
                    Console.WriteLine("{0}" & ControlChars.Tab & _
                        "{1}," & ControlChars.Tab & _
                        "{2}" & ControlChars.Tab & _
                        "{3}" & ControlChars.Tab, _
                        sqldr.Item("ContactID").ToString(), _
                        sqldr.Item("LastName").ToString(), _
                        sqldr.Item("FirstName").ToString(), _
                        sqldr.Item("MiddleName").ToString())
                Loop
            Catch ex As Exception
                Console.WriteLine(ex.Message)
            Finally
                If Not (sqldr Is Nothing) Then
                    sqldr.Close()
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

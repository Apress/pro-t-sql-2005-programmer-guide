Imports System
Imports System.Data
Imports System.Data.SqlClient

Namespace APress.Samples
    Module DataReaderExample
        Sub Main()
            Dim sqlConStr As String = "DATA SOURCE=(local);" & _
                "INITIAL CATALOG=AdventureWorks;" & _
                "INTEGRATED SECURITY=SSPI;"
            Dim sqlStmt As String = "SELECT DepartmentId, " & _
                "     Name, " & _
                "     GroupName, " & _
                "     ModifiedDate " & _
                " FROM HumanResources.Department " & _
                " ORDER BY DepartmentId"
            Dim sqlCon As SqlConnection = Nothing
            Dim sqlCmd As SqlCommand = Nothing
            Dim sqlDr As SqlClient.SqlDataReader = Nothing
            Try
                sqlCon = New SqlConnection(sqlConStr)
                sqlCon.Open()
                sqlCmd = New SqlCommand(sqlStmt, sqlCon)
                sqlDr = sqlCmd.ExecuteReader()
                Do While sqlDr.Read()
                    Console.WriteLine("{0}" & ControlChars.Tab & _
                        "{1}" & ControlChars.Tab & _
                        "{2}" & ControlChars.Tab & _
                        "{3}", sqlDr.Item("DepartmentId").ToString(), _
                        sqlDr.Item("Name").ToString(), _
                        sqlDr.Item("GroupName").ToString(), _
                        sqlDr.Item("ModifiedDate").ToString())
                Loop
            Catch ex As SqlException
                Console.WriteLine(ex.Message)
            Finally
                If Not (sqlDr Is Nothing) Then
                    sqlDr.Close()
                End If
                If Not (sqlCmd Is Nothing) Then
                    sqlCmd.Dispose()
                End If
                If Not (sqlCon Is Nothing) Then
                    sqlCon.Dispose()
                End If
            End Try
            Console.Write("Press a Key to Continue...")
            Console.ReadKey()
        End Sub
    End Module
End Namespace


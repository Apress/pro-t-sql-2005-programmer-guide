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
            Dim sqlDa As SqlClient.SqlDataAdapter = Nothing
            Dim ds As DataSet = Nothing
            Try
                sqlDa = New SqlClient.SqlDataAdapter(sqlStmt, sqlConStr)
                ds = New DataSet
                sqlDa.Fill(ds)
                For Each dr As DataRow In ds.Tables(0).Rows
                    Console.WriteLine("{0}" & ControlChars.Tab & _
                        "{1}" & ControlChars.Tab & _
                        "{2}" & ControlChars.Tab & _
                        "{3}", dr.Item("DepartmentId").ToString(), _
                        dr.Item("Name").ToString(), _
                        dr.Item("GroupName").ToString(), _
                        dr.Item("ModifiedDate").ToString())
                Next
            Catch ex As SqlException
                Console.WriteLine(ex.Message)
            Finally
                If Not (ds Is Nothing) Then
                    ds.Dispose()
                End If
                If Not (sqlDa Is Nothing) Then
                    sqlDa.Dispose()
                End If
            End Try
            Console.Write("Press a Key to Continue...")
            Console.ReadKey()
        End Sub
    End Module
End Namespace


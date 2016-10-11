Imports System.Data
Imports System.Data.SqlClient

' This is an example of how *NOT* to build a dynamic client-side query string

Namespace Apress.Samples
    Module Module1

        Sub Main()
            Dim SqlCon As New SqlConnection("SERVER=(local);INITIAL " & _
                "CATALOG=AdventureWorks;INTEGRATED SECURITY=SSPI;")
            SqlCon.Open()
            Dim Name As String = "Mountain%"
            Dim SqlCmd As New SqlCommand("SELECT ProductId, Name FROM " & _
                "Production.Product WHERE Name LIKE '" & Name & "'", SqlCon)
            Dim SqlDr As SqlDataReader = SqlCmd.ExecuteReader()
            While (SqlDr.Read())
                Console.WriteLine("Item {0} = {1}", SqlDr.Item("ProductId"), SqlDr.Item("Name"))
            End While
            SqlDr.Close()
            SqlCmd.Dispose()
            SqlCon.Dispose()
        End Sub

    End Module
End Namespace

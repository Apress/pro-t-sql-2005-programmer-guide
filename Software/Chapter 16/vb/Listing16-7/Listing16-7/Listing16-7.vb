Imports System.Data
Imports System.Net

Public Class Form1

    Private Sub btnQuery_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnQuery.Click
        ' Create web services proxy class
        Dim proxy As New localhost.AdvAdHocEndpoint

        ' Assign credentials to proxy
        proxy.Credentials = CredentialCache.DefaultCredentials

        ' Define the parameterized query here. Notice the leading @ is left on 
        ' the parameter name in the query
        Dim sql As String = "SELECT ContactID, FirstName, MiddleName, LastName " & _
            " FROM Person.Contact " & _
            " WHERE LastName = @LastName"

        ' Create a parameter for the parameterized query
        Dim p As New localhost.SqlParameter
        p.sqlDbType = localhost.sqlDbTypeEnum.VarChar
        p.maxLength = 50
        ' Notice the leading @ is stripped off the parameter name here
        p.name = "LastName"
        p.Value = txtLastName.Text

        ' Call the sqlbatch web method with the query string and parameter array.
        ' Notice we have to create an array and put the parameter in it here
        Dim ds As DataSet = CType(proxy.sqlbatch(sql, _
            New localhost.SqlParameter() {p})(0), DataSet)

        ' Bind the data grid view to the result
        dgvResults.DataSource = ds.Tables(0)
    End Sub

End Class

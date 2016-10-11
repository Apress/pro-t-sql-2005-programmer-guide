Imports System.Data
Imports System.Net

Public Class Form1

    Private Sub Form1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        ' Create a web service proxy using the SQL Server HTTP endpoint
        Dim proxy As New localhost.AdvSalesEndpoint
        ' Set the integrated security credentials
        proxy.Credentials = CredentialCache.DefaultCredentials
        ' Bind the combo box to the results of the web method call
        Me.cboSalesPerson.ValueMember = "SalespersonId"
        Me.cboSalesPerson.DisplayMember = "FullName"
        ' Call the web method
        Me.cboSalesPerson.DataSource = proxy.GetSalespersonList().Tables(0)
    End Sub

    Private Sub cboSalesPerson_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboSalesPerson.SelectedIndexChanged
        ' Create a web service proxy using the SQL Server HTTP endpoint
        Dim proxy As New localhost.AdvSalesEndpoint
        ' Set the integrated security credentials
        proxy.Credentials = CredentialCache.DefaultCredentials
        ' Bind the data grid to the results of the web method call
        Me.dgvSales.DataSource = proxy.GetSalesPersonSales(New SqlTypes.SqlInt32(Me.cboSalesPerson.SelectedValue)).Tables(0)
        ' Populate the text box with the results of the second web method call
        Me.txtTotalSales.Text = proxy.GetSalesTotal(New SqlTypes.SqlInt32(Me.cboSalesPerson.SelectedValue)).Value.ToString("C")
    End Sub

    Private Sub btnExit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnExit.Click
        ' Exit the application
        Application.Exit()
    End Sub
End Class

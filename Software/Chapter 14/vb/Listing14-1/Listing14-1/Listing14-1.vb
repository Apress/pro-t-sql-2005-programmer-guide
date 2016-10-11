Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Data.SqlTypes
Imports Microsoft.SqlServer.Server

Namespace APress.Samples
    Partial Public Class Sql
        <SqlFunction(DataAccess:=DataAccessKind.None, _
            IsDeterministic:=True)> _
        Public Shared Function Fahrenheit2Celsius(ByVal f As SqlDouble) As SqlDouble
            Dim c As New SqlDouble
            c = (5.0 / 9.0) * (f - 32.0)
            Return c
        End Function
    End Class
End Namespace


Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Data.SqlTypes
Imports Microsoft.SqlServer.Server

Namespace APress.Samples
    Partial Public Class Sql
        <SqlProcedure()> _
        Public Shared Sub GetEnvironmentVars()
            Try
                Dim environmentList As New SortedList
                For Each de As DictionaryEntry In _
                    Environment.GetEnvironmentVariables()
                    environmentList(de.Key) = de.Value
                Next
                Dim record As New SqlDataRecord( _
                    New SqlMetaData("VarName", SqlDbType.NVarChar, 1024), _
                    New SqlMetaData("VarValue", SqlDbType.NVarChar, 4000))
                SqlContext.Pipe.SendResultsStart(record)
                For Each de As DictionaryEntry In environmentList
                    record.SetValue(0, de.Key)
                    record.SetValue(1, de.Value)
                    SqlContext.Pipe.SendResultsRow(record)
                Next
                SqlContext.Pipe.SendResultsEnd()
            Catch ex As Exception
                SqlContext.Pipe.Send(ex.Message)
            End Try
        End Sub
    End Class
End Namespace

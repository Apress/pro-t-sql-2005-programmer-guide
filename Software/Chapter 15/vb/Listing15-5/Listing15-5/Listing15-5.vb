Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.IO

' This code requires the script in Listing15-ZIPCodes be run first to create the
' ZIPCodes table in the AdventureWorks database.

Namespace APress.Samples
    Module ZipImport

        Sub Main()
            Dim sw As New Stopwatch
            sw.Start()
            Dim rowcount As Integer = DoImport()
            sw.Stop()
            Console.WriteLine("{0} Rows Imported in {1} Seconds.", _
                rowcount, (sw.ElapsedMilliseconds / 1000.0))
            Console.WriteLine("Press a Key...")
            Console.ReadKey()
        End Sub

        Function DoImport() As Integer
            Dim sqlcon As String = "DATA SOURCE=(local); " & _
                "INITIAL CATALOG=AdventureWorks;INTEGRATED SECURITY=SSPI;"
            Dim srcfile As String = "..\..\ZIPCodes.txt"
            Dim dt As DataTable = Nothing
            Using bulkCopier As New SqlClient.SqlBulkCopy(sqlcon)
                bulkCopier.DestinationTableName = "ZIPCodes"
                Try
                    dt = LoadSourceFile(srcfile)
                    bulkCopier.WriteToServer(dt)
                Catch ex As SqlException
                    Console.WriteLine(ex.Message)
                End Try
            End Using
            Return dt.Rows.Count
        End Function

        Function LoadSourceFile(ByVal srcfile As String) As DataTable
            Dim loadtable As New DataTable
            Dim loadcolumn As New DataColumn
            Dim loadrow As DataRow

            With loadcolumn
                .DataType = Type.GetType("System.String")
                .ColumnName = "ZIP"
                .Unique = True
            End With
            loadtable.Columns.Add(loadcolumn)

            loadcolumn = New DataColumn()
            With loadcolumn
                .DataType = System.Type.GetType("System.Double")
                .ColumnName = "Latitude"
                .Unique = False
            End With
            loadtable.Columns.Add(loadcolumn)

            loadcolumn = New DataColumn()
            With loadcolumn
                .DataType = System.Type.GetType("System.Double")
                .ColumnName = "Longitude"
                .Unique = False
            End With
            loadtable.Columns.Add(loadcolumn)

            loadcolumn = New DataColumn()
            With loadcolumn
                .DataType = System.Type.GetType("System.String")
                .ColumnName = "City"
                .Unique = False
            End With
            loadtable.Columns.Add(loadcolumn)

            loadcolumn = New DataColumn()
            With loadcolumn
                .DataType = System.Type.GetType("System.String")
                .ColumnName = "State"
                .Unique = False
            End With
            loadtable.Columns.Add(loadcolumn)

            Using sr As New StreamReader(srcfile)
                Dim record As String
                record = sr.ReadLine()
                Do While Not (record Is Nothing)
                    Dim s() As String = record.Split(ControlChars.Tab)
                    loadrow = loadtable.NewRow()
                    loadrow("ZIP") = s(0)
                    loadrow("Latitude") = s(1)
                    loadrow("Longitude") = s(2)
                    loadrow("City") = s(3)
                    loadrow("State") = s(4)
                    loadtable.Rows.Add(loadrow)
                    record = sr.ReadLine()
                Loop
            End Using
            Return loadtable
        End Function
    End Module
End Namespace

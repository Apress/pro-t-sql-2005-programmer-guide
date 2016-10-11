Imports System
Imports System.Data
Imports System.Data.SqlClient

Namespace APress.Samples
    Module SqlResultTests

        Sub Main()
            ' Create and open a native SqlClient connection to SQL Server 2005
            Dim sqlcon As New SqlConnection("SERVER=(local);" & _
                "INITIAL CATALOG=AdventureWorks;INTEGRATED SECURITY=SSPI;" & _
                "MULTIPLEACTIVERESULTSETS=TRUE;")
            sqlcon.Open()
            ' Create two SqlCommands to retrieve two result sets
            Dim sqlcmd1 As New SqlCommand("SELECT DepartmentID, Name, GroupName " & _
                "FROM HumanResources.Department", sqlcon)
            Dim sqlcmd2 As New SqlCommand( _
                "SELECT ShiftID, Name, StartTime, EndTime " & _
                "FROM HumanResources.Shift", sqlcon)
            ' Open the first result set
            Dim sqldr1 As SqlDataReader = sqlcmd1.ExecuteReader()
            ' Open the second result set
            Dim sqldr2 As SqlDataReader = sqlcmd2.ExecuteReader()
            ' Output the results of the first result set
            Console.WriteLine("===========")
            Console.WriteLine("Departments")
            Console.WriteLine("===========")
            While (sqldr1.Read())
                Console.WriteLine(String.Format("{0}" & ControlChars.Tab & "{1}" & _
                    ControlChars.Tab & "{2}", sqldr1.Item("DepartmentID"), _
                    sqldr1.Item("Name"), sqldr1.Item("GroupName")))
            End While
            ' Output the results of the second result set
            Console.WriteLine("======")
            Console.WriteLine("Shifts")
            Console.WriteLine("======")
            While (sqldr2.Read())
                Console.WriteLine(String.Format("{0}" & ControlChars.Tab & "{1}" & _
                    ControlChars.Tab & "{2}" & ControlChars.Tab & "{3}", _
                    sqldr2.Item("ShiftID"), sqldr2.Item("Name"), _
                    sqldr2.Item("StartTime"), _
                    sqldr2.Item("EndTime")))
            End While
            ' Clean up
            sqldr1.Close()
            sqldr2.Close()
            sqlcmd1.Dispose()
            sqlcmd2.Dispose()
            sqlcon.Dispose()
            ' Exit the program
            Console.WriteLine("Press a key to end.")
            Console.ReadKey()
        End Sub

    End Module
End Namespace

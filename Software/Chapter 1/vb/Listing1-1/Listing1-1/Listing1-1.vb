Imports System
Imports System.IO

Namespace APress.Samples

    Module Module1
        Sub Main()
            ' Opens the Person_Contact file for input. The file is located
            ' two directories above the bin\* directory, so a relative path
            ' is used.
            Dim sr As New StreamReader("..\\..\\Person_Contact.txt")
            Dim FirstName As String = Nothing
            ' Reads in each first name
            FirstName = sr.ReadLine()
            Do While Not (FirstName Is Nothing)
                ' Writes each first name to the console
                Console.WriteLine(FirstName)
                FirstName = sr.ReadLine()
            Loop
            ' Dispose of the StreamReader
            sr.Dispose()
            ' Wait for user to press a key to exit
            Console.WriteLine("Press a key to end")
            Console.ReadKey()
        End Sub
    End Module
End Namespace
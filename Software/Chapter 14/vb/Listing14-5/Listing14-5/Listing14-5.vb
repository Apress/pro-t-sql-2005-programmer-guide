Imports System.Data.SqlTypes
Imports Microsoft.SqlServer.Server
Imports System.Text.RegularExpressions

' This is the scaled-down version of the Complex Number UDT from the
' book.  The full-blown version is written in C# and is located in the
' cs directory.

Namespace APress.Examples
    <Serializable()> _
    <SqlUserDefinedType(Format.Native, IsByteOrdered:=True)> _
    Public Structure Complex
        Implements INullable

        Public real As Double
        Public imaginary As Double
        Private m_Null As Boolean

        Private Shared ReadOnly rx As New System.Text.RegularExpressions.Regex( _
            "^(?<Imaginary>[+-]?([0-9]+|[0-9]*\.[0-9]+))[i|I]$|" & _
            "^(?<Real>[+-]?([0-9]+|[0-9]*\.[0-9]+))$|" & _
            "^(?<Real>[+-]?([0-9]+|[0-9]*\.[0-9]+))(?<Imaginary>[+-]?" & _
            "([0-9]+|[0-9]*\.[0-9]+))[i|I]$")

        Public Shared Function Parse(ByVal s As SqlString) As Complex
            Dim u As Complex = New Complex
            If s.IsNull Then
                u = Null
            Else
                Dim m As System.Text.RegularExpressions.MatchCollection = _
                    rx.Matches(s.Value)
                If (m.Count = 0) Then
                    Throw (New FormatException("Invalid Complex Number Format."))
                End If
                Dim real_str As String = m.Item(0).Groups("Real").Value
                Dim imaginary_str As String = m.Item(0).Groups("Imaginary").Value
                If (real_str = "" AndAlso imaginary_str = "") Then
                    Throw (New FormatException("Invalid Complex Number Format."))
                End If
                If (real_str = "") Then
                    u.real = 0.0
                Else
                    u.real = Convert.ToDouble(real_str)
                End If
                If (imaginary_str = "") Then
                    u.imaginary = 0.0
                Else
                    u.imaginary = Convert.ToDouble(imaginary_str)
                End If
            End If
            Return u
        End Function

        Public Overrides Function ToString() As String
            Dim sign As String = ""
            If Me.imaginary >= 0.0 Then
                sign = "+"
            End If
            Return Me.real.ToString + sign + Me.imaginary.ToString + "i"
        End Function

        Public ReadOnly Property IsNull() As Boolean Implements INullable.IsNull
            Get
                Return m_Null
            End Get
        End Property

        Public Shared ReadOnly Property Null() As Complex
            Get
                Dim h As Complex = New Complex
                h.m_Null = True
                Return h
            End Get
        End Property

        Public Sub New(ByVal r As Double, ByVal i As Double)
            Me.real = r
            Me.imaginary = i
        End Sub

        Public Shared Operator +(ByVal n1 As Complex, ByVal n2 As Complex) As _
            Complex
            Dim u As Complex
            If (n1.IsNull() OrElse n2.IsNull()) Then
                u = Null
            Else
                u = New Complex(n1.real + n2.real, n1.imaginary + n2.imaginary)
            End If
            Return u
        End Operator

        Public Shared Operator /(ByVal n1 As Complex, ByVal n2 As Complex) As _
            Complex
            Dim u As Complex
            If (n1.IsNull() OrElse n2.IsNull()) Then
                u = Null
            Else
                If (n2.real = 0.0 AndAlso n2.imaginary = 0.0) Then
                    Throw New DivideByZeroException("Complex Number Division By Zero Exception.")
                End If
                u = New Complex(((n1.real * n2.real) + _
                    (n1.imaginary * n2.imaginary)) / _
                    ((n2.real ^ 2 + n2.imaginary ^ 2)), _
                    ((n1.imaginary * n2.real) - (n1.real * n2.imaginary)) / _
                    ((n2.real ^ 2 + n2.imaginary ^ 2)))
            End If
            Return u
        End Operator

        Public Shared Function CAdd(ByVal n1 As Complex, ByVal n2 As Complex) As _
            Complex
            Return n1 + n2
        End Function

        Public Shared Function Div(ByVal n1 As Complex, ByVal n2 As Complex) As _
            Complex
            Return n1 / n2
        End Function

    End Structure
End Namespace

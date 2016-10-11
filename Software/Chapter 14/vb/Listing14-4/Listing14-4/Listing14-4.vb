Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Data.SqlTypes
Imports Microsoft.SqlServer.Server

Namespace APress.Samples
    <Serializable()> _
    <SqlUserDefinedAggregate(Format.Native)> _
    Public Structure Range

        Private min As SqlDouble
        Private max As SqlDouble

        Public Sub Init()
            Me.min = SqlDouble.Null
            Me.max = SqlDouble.Null
        End Sub

        Public Sub Accumulate(ByVal value As SqlDouble)
            If Not value.IsNull Then
                If Me.min.IsNull OrElse value < Me.min Then
                    Me.min = value
                End If
                If Me.max.IsNull OrElse value > Me.max Then
                    Me.max = value
                End If
            End If
        End Sub

        Public Sub Merge(ByVal tempRange As Range)
            If (Me.min.IsNull OrElse tempRange.min < Me.min) Then
                Me.min = tempRange.min
            End If
            If (Me.min.IsNull OrElse tempRange.max > Me.max) Then
                Me.max = tempRange.max
            End If
        End Sub

        Public Function Terminate() As SqlDouble
            Dim result As SqlDouble = SqlDouble.Null
            If Not (Me.min.IsNull OrElse Me.max.IsNull) Then
                result = Me.max - Me.min
            End If
            Return result
        End Function
    End Structure
End Namespace

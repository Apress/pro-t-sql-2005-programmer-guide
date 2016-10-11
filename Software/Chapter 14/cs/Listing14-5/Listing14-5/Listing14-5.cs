// The Complex UDT allows you to represent and manipulate complex numbers
// in T-SQL via the SQLCLR.  Complex numbers are represented with the format:
//    a + bi

// Where a is the "real" part of the complex number, b is the "imaginary part", and
// the literal letter "i" is used to represent the imaginary number (square root of -1).
// If b is negative, the format is:
//    a - bi

// The UDT exposes a few useful constants including:
//    Pi:     The complex number representation of the constant Pi (3.14159265358979+0i)
//    i:       The complex number representation of the constant i (0+1i)
//    One: The complex number representation of the constant 1 (1+0i)
//    Two: The complex number representation of the constant 2 (2+0i)

// The exposed methods of the UDT include:
//    CAdd(n1, n2):  Adds the complex numbers n1 and n2
//    Sub(n1, n2):     Subtracts the complex number n2 from n1
//    Mult(n1, n2):     Multiplies the complex numbers n1 and n2
//    Div(n1, n2):       Divides the complex number n1 by n2
//    Neg(n1):           Returns the negative of the complex number n1
//    Conj(n1):          Returns the conjugate of the complex number n1
//    Abs(n1):            Returns the absolute value of the complex number n1
//    Exp(n1):            Returns the exponential function of a complex number n1
//    Power(n1, n2):  Returns the result of the complex number n1 to the n2 power
//    Sqrt(n1):           Returns the square root of the complex number n1
//    Ln(n1):              Returns the natural logarithm of the complex number n1
//    Log(n1):            Returns the base-10 logarithm of the complex number n1
//    Sin(n1):             Sine of a complex number
//    Sinh(n1):           Hyperbolic sine of a complex number
//    Cos(n1):            Cosine of a complex number
//    Cosh(n1):          Hyperbolic cosine of a complex number
//    Sec(n1):            Secant of a complex number
//    Sech(n1):          Hyperbolic secant of a complex number
//    Csc(n1):            Cosecant of a complex number
//    Csch(n1):          Hyperbolic cosecant of a complex number
//    Tan(n1):            Tangent of a complex number
//    Tanh(n1):          Hyperbolic tangent of a complex number
//    Cot(n1):             Cotangent of a complex number
//    Coth(n1):           Hyperbolic cotangent of a complex number

using System;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;
using System.Text.RegularExpressions;

namespace APress.Sample
{
    [Serializable]
    [Microsoft.SqlServer.Server.SqlUserDefinedType(Format.Native, IsByteOrdered = true)]
    public struct Complex : INullable
    {

        #region "Complex Number UDT Fields/Components"

        public Double real;
        public Double imaginary;
        private bool m_Null;

        #endregion

        #region "Complex Number Parsing, Constructor, and Required Methods/Properties"

        private static readonly Regex rx = new Regex(
            "^(?<Imaginary>[+-]?([0-9]+|[0-9]*\\.[0-9]+))[i|I]$|" +
            "^(?<Real>[+-]?([0-9]+|[0-9]*\\.[0-9]+))$|" +
            "^(?<Real>[+-]?([0-9]+|[0-9]*\\.[0-9]+))(?<Imaginary>[+-]?([0-9]+|[0-9]*\\.[0-9]+))[i|I]$");

        public static Complex Parse(SqlString s)
        {
            Complex u = new Complex();
            if (s.IsNull)
                u = Null;
            else
            {
                MatchCollection m = rx.Matches(s.Value);
                if (m.Count == 0)
                    throw (new FormatException("Invalid Complex Number Format."));
                String real_str = m[0].Groups["Real"].Value;
                String imaginary_str = m[0].Groups["Imaginary"].Value;
                if (real_str == "" && imaginary_str == "")
                    throw (new FormatException("Invalid Complex Number Format."));
                if (real_str == "")
                    u.real = 0.0;
                else
                    u.real = Convert.ToDouble(real_str);
                if (imaginary_str == "")
                    u.imaginary = 0.0;
                else
                    u.imaginary = Convert.ToDouble(imaginary_str);
            }
            return u;
        }

        public override String ToString()
        {
            String sign = "";
            if (this.imaginary >= 0.0)
                sign = "+";
            return this.real.ToString() + sign + this.imaginary.ToString() + "i";
        }

        public bool IsNull
        {
            get
            {
                return m_Null;
            }
        }

        public static Complex Null
        {
            get
            {
                Complex h = new Complex();
                h.m_Null = true;
                return h;
            }
        }

        public Complex(Double r, Double i)
        {
            this.real = r;
            this.imaginary = i;
            this.m_Null = false;
        }

        #endregion

        #region "Useful Complex Number Constants"
        // The property "i" is the Complex number 0 + 1i. Defined here because
        // it is useful in some calculations
        public static Complex i
        {
            get
            {
                return new Complex(0, 1);
            }
        }

        // The property "Pi" is the Complex representation of the number 
        // Pi (3.141592... + 0i)

        public static Complex Pi
        {
            get
            {
                return new Complex(Math.PI, 0);
            }
        }

        // The property "One" is the Complex number representation of the 
        // number 1 (1 + 0i)
        public static Complex One
        {
            get
            {
                return new Complex(1, 0);
            }
        }

        // The property "Two" is the Complex number representation of the 
        // number 2 (2 + 0i)
        public static Complex Two
        {
            get
            {
                return new Complex(2, 0);
            }
        }
        #endregion

        #region "Complex Number Basic Operators"

        // Complex number addition
        public static Complex operator +(Complex n1, Complex n2)
        {
            Complex u;
            if (n1.IsNull || n2.IsNull)
                u = Null;
            else
                u = new Complex(n1.real + n2.real, n1.imaginary + n2.imaginary);
            return u;
        }

        // Complex number subtraction
        public static Complex operator -(Complex n1, Complex n2)
        {
            Complex u;
            if (n1.IsNull || n2.IsNull)
                u = Null;
            else
                u = new Complex(n1.real - n2.real, n1.imaginary - n2.imaginary);
            return u;
        }

        // Complex number multiplication
        public static Complex operator *(Complex n1, Complex n2)
        {
            Complex u;
            if (n1.IsNull || n2.IsNull)
                u = Null;
            else
                u = new Complex((n1.real * n2.real) - (n1.imaginary * n2.imaginary),
                    (n1.real * n2.imaginary) + (n2.real * n1.imaginary));
            return u;
        }

        // Complex number division
        public static Complex operator /(Complex n1, Complex n2)
        {
            Complex u;
            if (n1.IsNull || n2.IsNull)
                u = Null;
            else
            {
                if (n2.real == 0.0 && n2.imaginary == 0.0)
                    throw new DivideByZeroException("Complex Number Division By Zero Exception.");
                u = new Complex(((n1.real * n2.real) + (n1.imaginary * n2.imaginary)) /
                    ((Math.Pow(n2.real, 2) + Math.Pow(n2.imaginary, 2))),
                    ((n1.imaginary * n2.real) - (n1.real * n2.imaginary)) /
                    ((Math.Pow(n2.real, 2) + Math.Pow(n2.imaginary, 2))));
            }
            return u;
        }

        // Unary minus operator
        public static Complex operator -(Complex n1)
        {
            Complex u;
            if (n1.IsNull)
                u = Null;
            else
                u = new Complex(-n1.real, -n1.imaginary);
            return u;
        }

        // Exponentation operator
        public static Complex operator ^(Complex n1, Complex n2)
        {
            Complex u;
            if (n1.IsNull || n2.IsNull)
                u = Null;
            else
                u = Exp(n2 * Ln(n1));
            return u;
        }
        #endregion

        #region "Exposed Mathematical Basic Operator Methods"

        // Add complex number n2 to n1
        public static Complex CAdd(Complex n1, Complex n2)
        {
            return n1 + n2;
        }

        // Subtract complex number n2 from n1
        public static Complex Sub(Complex n1, Complex n2)
        {
            return n1 - n2;
        }

        // Multiply complex number n1 * n2
        public static Complex Mult(Complex n1, Complex n2)
        {
            return n1 * n2;
        }

        // Divide complex number n1 by n2
        public static Complex Div(Complex n1, Complex n2)
        {
            return n1 / n2;
        }

        // Returns negated complex number
        public static Complex Neg(Complex n1)
        {
            return -n1;
        }

        // Returns conjugate of complex number
        public static Complex Conj(Complex n1)
        {
            Complex u;
            if (n1.IsNull)
                u = Null;
            else
                u = new Complex(n1.real, -n1.imaginary);
            return u;
        }

        // Returns absolute value of a complex number
        public static Complex Abs(Complex n1)
        {
            Complex u;
            if (n1.IsNull)
                u = Null;
            else
                u = new Complex(Math.Sqrt(Math.Pow(n1.real, 2) + Math.Pow(n1.imaginary, 2)), 0.0);
            return u;
        }

        #endregion

        #region "Complex Number Exponentiation, Roots, Powers"

        // The exponential function of a complex number
        public static Complex Exp(Complex n1)
        {
            Complex u;
            if (n1.IsNull)
                u = Null;
            else
                u = new Complex((Math.Exp(n1.real) * Math.Cos(n1.imaginary)),
                (Math.Exp(n1.real) * Math.Sin(n1.imaginary)));
            return u;
        }

        // Returns the square root of a complex number
        public static Complex Sqrt(Complex n1)
        {
            return n1 ^ new Complex(0.5, 0);
        }

        // Raises a complex number n1 to the power n2
        public static Complex Power(Complex n1, Complex n2)
        {
            return n1 ^ n2;
        }

        // Complex number natural logarithm
        public static Complex Ln(Complex n1)
        {
            Complex u;
            if (n1.IsNull)
                u = Null;
            else
                u = new Complex((Math.Log(Math.Pow((Math.Pow(n1.real, 2) + Math.Pow(n1.imaginary, 2)), (0.5)))), Math.Atan2(n1.imaginary, n1.real));
            return u;
        }

        // Complex number base-10 logarithm
        public static Complex Log(Complex n1)
        {
            return Ln(n1) / Ln(new Complex(10, 0));
        }

        #endregion

        #region "Complex Number Trigonometric and Hyperbolic Functions"
        // Sine of a complex number
        public static Complex Sin(Complex n1)
        {
            return (Exp(n1 * i) - Exp(-n1 * i)) / (Two * i);
        }

        // Hyperbolic Sine of a complex number
        public static Complex Sinh(Complex n1)
        {
            return (Exp(n1) - Exp(-n1)) / Two;
        }

        // Cosine of a complex number
        public static Complex Cos(Complex n1)
        {
            return (Exp(n1 * i) + Exp(-n1 * i)) / Two;
        }

        // Hyperbolic cosine of a complex number
        public static Complex Cosh(Complex n1)
        {
            return (Exp(n1) + Exp(-n1)) / Two;
        }

        // Tangent of a complex number
        public static Complex Tan(Complex n1)
        {
            return Sin(n1) / Cos(n1);
        }

        // Hyperbolic tangent of a complex number
        public static Complex Tanh(Complex n1)
        {
            return Sinh(n1) / Cosh(n1);
        }

        // Cotangent of a complex number
        public static Complex Cot(Complex n1)
        {
            return Cos(n1) / Sin(n1);
        }

        // Hyperbolic cotangent of a complex number
        public static Complex Coth(Complex n1)
        {
            return Cosh(n1) / Sinh(n1);
        }

        // Secant of a complex number
        public static Complex Sec(Complex n1)
        {
            return One / Cos(n1);
        }

        // Hyperbolic secant of a complex number
        public static Complex Sech(Complex n1)
        {
            return One / Cosh(n1);
        }

        // Cosecant of a complex number
        public static Complex Csc(Complex n1)
        {
            return One / Sin(n1);
        }

        // Hyperbolic cosecant of a complex number
        public static Complex Csch(Complex n1)
        {
            return One / Sinh(n1);
        }

        #endregion
    }
}


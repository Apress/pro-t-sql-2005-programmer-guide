using System;
using System.Data;
using System.Data.SqlClient;

namespace Apress.Samples
{
    class Program
    {
        static void Main(string[] args)
        {
            SqlConnection SqlCon = new SqlConnection("SERVER=(local);INITIAL " +
                "CATALOG=AdventureWorks;INTEGRATED SECURITY=SSPI;");
            SqlCon.Open();
            SqlCommand SqlCmd = new SqlCommand("SELECT ProductId, Name FROM " +
                "Production.Product WHERE Name LIKE @name", SqlCon);
            SqlCmd.Parameters.Add("@name", SqlDbType.NVarChar, 50).Value = "Mountain%";
            SqlDataReader SqlDr = SqlCmd.ExecuteReader();
            while (SqlDr.Read())
            {
                Console.WriteLine("Item {0} = {1}", SqlDr.GetValue(0), SqlDr.GetValue(1));
            }
            SqlDr.Close();
            SqlCmd.Dispose();
            SqlCon.Dispose();
        }
    }
}

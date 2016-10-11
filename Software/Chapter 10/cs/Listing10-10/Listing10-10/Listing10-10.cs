using System;
using System.Data;
using System.Data.SqlClient;

namespace Apress.Samples
{
    class Program
    {
        static void Main(string[] args)
        {
            // This is an example of how *NOT* to build a dynamic client-side query string
            SqlConnection SqlCon = new SqlConnection("SERVER=(local);INITIAL " +
                "CATALOG=AdventureWorks;INTEGRATED SECURITY=SSPI;");
            SqlCon.Open();
            string Name = "Mountain%";
            SqlCommand SqlCmd = new SqlCommand("SELECT ProductId, Name FROM " +
                "Production.Product WHERE Name LIKE '" + Name + "'", SqlCon);
            SqlDataReader SqlDr = SqlCmd.ExecuteReader();
            while (SqlDr.Read())
            {
                Console.WriteLine("Item {0} = {1}", SqlDr["ProductId"], SqlDr["Name"]);
            }
            SqlDr.Close();
            SqlCmd.Dispose();
            SqlCon.Dispose();
        }
    }
}

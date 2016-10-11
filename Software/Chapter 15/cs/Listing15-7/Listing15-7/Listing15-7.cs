using System;
using System.Data;
using System.Data.SqlClient;

namespace Apress.Samples
{
    class SqlResultTests
    {
        private static void Main(string[] args)
        {
            // Create and open a native SqlClient connection to SQL Server 2005
            SqlConnection sqlcon = new SqlConnection("SERVER=(local);" +
                "INITIAL CATALOG=AdventureWorks;INTEGRATED SECURITY=SSPI;" +
                "MULTIPLEACTIVERESULTSETS=TRUE;");
            sqlcon.Open();

            // Create two SqlCommands to retrieve two result sets
            SqlCommand sqlcmd1 = new SqlCommand("SELECT DepartmentID, Name, " +
                "GroupName FROM HumanResources.Department", sqlcon);
            SqlCommand sqlcmd2 = new SqlCommand("SELECT ShiftID, Name, " +
                "StartTime, EndTime FROM HumanResources.Shift", sqlcon);

            // Open the first result set
            SqlDataReader sqldr1 = sqlcmd1.ExecuteReader();

            // Open the second result set
            SqlDataReader sqldr2 = sqlcmd2.ExecuteReader();

            // Output the results of the first result set
            Console.WriteLine("===========");
            Console.WriteLine("Departments");
            Console.WriteLine("===========");
            while (sqldr1.Read())
            {
                Console.WriteLine(String.Format("{0}\t{1}\t{2}",
                    sqldr1["DepartmentID"], sqldr1["Name"],
                    sqldr1["GroupName"]));
            }

            // Output the results of the second result set
            Console.WriteLine("======");
            Console.WriteLine("Shifts");
            Console.WriteLine("======");
            while (sqldr2.Read())
            {
                Console.WriteLine(String.Format("{0}\t{1}\t{2}\t{3}",
                    sqldr2["ShiftID"], sqldr2["Name"], sqldr2["StartTime"],
                    sqldr2["EndTime"]));
            }

            // Clean up
            sqldr1.Close();
            sqldr2.Close();
            sqlcmd1.Dispose();
            sqlcmd2.Dispose();
            sqlcon.Dispose();

            // Exit the program
            Console.WriteLine("Press a key to end.");
            Console.ReadKey();
        }
    }
}

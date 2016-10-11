using System;
using System.Data;
using System.Data.SqlClient;

namespace APress.Samples
{
    class ParameterizedQuery
    {
        static void Main(string[] args)
        {
            String name = "SMITH";
            String sqlstmt = "SELECT ContactID, FirstName, MiddleName, LastName " +
                " FROM Person.Contact " +
                " WHERE LastName = @name";
            SqlConnection sqlcon = null;
            SqlCommand sqlcmd = null;
            SqlDataReader sqldr = null;
            try
            {
                sqlcon = new SqlConnection("SERVER=(local); " +
                    "INITIAL CATALOG=AdventureWorks;INTEGRATED SECURITY=SSPI;");
                sqlcon.Open();
                sqlcmd = new SqlCommand(sqlstmt, sqlcon);
                sqlcmd.Parameters.Add("@name", SqlDbType.NVarChar, 50).Value = name;
                sqldr = sqlcmd.ExecuteReader();
                while (sqldr.Read())
                {
                    Console.WriteLine("{0}\t{1}\t{2}\t{3}",
                        sqldr["ContactID"].ToString(),
                        sqldr["LastName"].ToString(), 
                        sqldr["FirstName"].ToString(),
                        sqldr["MiddleName"].ToString());
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                if (sqldr != null)
                {
                    sqldr.Close();
                }
                if (sqlcmd != null)
                {
                    sqlcmd.Dispose();
                }
                if (sqlcon != null)
                {
                    sqlcon.Dispose();
                }
            }
            Console.WriteLine("Press any key...");
            Console.ReadKey();
        }
    }
}

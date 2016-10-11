using System;
using System.Data;
using System.Data.SqlClient;
using System.Xml;

namespace APress.Samples
{
    class XmlReaderQuery
    {
        static void Main(string[] args)
        {
            String name = "SMITH";
            String sqlstmt = "SELECT ContactID, FirstName, " +
                " COALESCE(MiddleName, '') AS MiddleName, LastName " +
                " FROM Person.Contact " +
                " WHERE LastName = @name FOR XML AUTO";
            SqlConnection sqlcon = null;
            SqlCommand sqlcmd = null;
            XmlReader sqlxr = null;
            try
            {
                sqlcon = new SqlConnection("SERVER=(local); " +
                    "INITIAL CATALOG=AdventureWorks;INTEGRATED SECURITY=SSPI;");
                sqlcon.Open();
                sqlcmd = new SqlCommand(sqlstmt, sqlcon);
                sqlcmd.Parameters.Add("@name", SqlDbType.NVarChar, 50).Value = name;
                sqlxr = sqlcmd.ExecuteXmlReader();
                while (sqlxr.Read())
                {
                    Console.WriteLine("{0}\t{1}\t{2}\t{3}",
                        sqlxr["ContactID"].ToString(),
                        sqlxr["LastName"].ToString(), 
                        sqlxr["FirstName"].ToString(), 
                        sqlxr["MiddleName"].ToString());
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                if (sqlxr != null)
                {
                    sqlxr.Close();
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

using System;
using System.Data;
using System.Data.SqlClient;

namespace APress.Samples
{
    class DataReaderExample
    {
        static void Main(string[] args)
        {
            String sqlConStr = "DATA SOURCE=(local);" +
                "INITIAL CATALOG=AdventureWorks;" +
                "INTEGRATED SECURITY=SSPI;";
            String sqlStmt = "SELECT DepartmentId, " +
                "     Name, " +
                "     GroupName, " +
                "     ModifiedDate " +
                " FROM HumanResources.Department " +
                " ORDER BY DepartmentId";
            SqlDataAdapter sqlDa = null;
            DataSet ds = null;
            try
            {
                sqlDa = new SqlDataAdapter(sqlStmt, sqlConStr);
                ds = new DataSet();
                sqlDa.Fill(ds);
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    Console.WriteLine("{0}\t{1}\t{2}\t{3}",
                        dr["DepartmentId"].ToString(), 
                        dr["Name"].ToString(), 
                        dr["GroupName"].ToString(), 
                        dr["ModifiedDate"].ToString());
                }
            }
            catch (SqlException ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                if (ds != null)
                {
                    ds.Dispose();
                }
                if (sqlDa != null)
                {
                    sqlDa.Dispose();
                }
            }
            Console.Write("Press a Key to Continue...");
            Console.ReadKey();
        }
    }
}

using System;
using System.Data;
using System.Xml;
using System.IO;
using System.Data.SqlClient;
using System.Diagnostics;

// This sample requires that the T-SQL script Listing5-ZIPCodes.sql be run first
// to create the ZIPCodes table in the AdventureWorks database

namespace Apress.Samples
{
    class ZipImport
    {
        private static void Main(string[] args)
        {
            Stopwatch sw = new Stopwatch();
            sw.Start();
            int rowcount = DoImport();
            sw.Stop();
            Console.WriteLine("{0} Rows Imported in {1} Seconds.",
                rowcount, (sw.ElapsedMilliseconds / 1000.0));
            Console.WriteLine("Press a Key...");
            Console.ReadKey();
        }

        private static int DoImport()
        {
            String sqlcon = "DATA SOURCE=(local); " +
                "INITIAL CATALOG=AdventureWorks;INTEGRATED SECURITY=SSPI;";
            String srcfile = "..\\..\\ZIPCodes.txt";
            DataTable dt = null;
            using (SqlBulkCopy bulkCopier = new SqlBulkCopy(sqlcon))
            {
                bulkCopier.DestinationTableName = "ZIPCodes";
                try
                {
                    dt = LoadSourceFile(srcfile);
                    bulkCopier.WriteToServer(dt);
                }
                catch (SqlException ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }
            return dt.Rows.Count;
        }

        private static DataTable LoadSourceFile(String srcfile)
        {
            DataTable loadtable = new DataTable();
            DataColumn loadcolumn = new DataColumn();
            DataRow loadrow;
            loadcolumn.DataType = Type.GetType("System.String");
            loadcolumn.ColumnName = "ZIP";
            loadcolumn.Unique = true;
            loadtable.Columns.Add(loadcolumn);
            loadcolumn = new DataColumn();
            loadcolumn.DataType = System.Type.GetType("System.Double");
            loadcolumn.ColumnName = "Latitude";
            loadcolumn.Unique = false;
            loadtable.Columns.Add(loadcolumn);
            loadcolumn = new DataColumn();
            loadcolumn.DataType = System.Type.GetType("System.Double");
            loadcolumn.ColumnName = "Longitude";
            loadcolumn.Unique = false;
            loadtable.Columns.Add(loadcolumn);
            loadcolumn = new DataColumn();
            loadcolumn.DataType = System.Type.GetType("System.String");
            loadcolumn.ColumnName = "City";
            loadcolumn.Unique = false;
            loadtable.Columns.Add(loadcolumn);
            loadcolumn = new DataColumn();
            loadcolumn.DataType = System.Type.GetType("System.String");
            loadcolumn.ColumnName = "State";
            loadcolumn.Unique = false;
            loadtable.Columns.Add(loadcolumn);
            using (StreamReader sr = new StreamReader(srcfile))
            {
                String record = sr.ReadLine();
                while (record != null)
                {
                    String[] s = record.Split('\t');
                    loadrow = loadtable.NewRow();
                    loadrow["ZIP"] = s[0];
                    loadrow["Latitude"] = s[1];
                    loadrow["Longitude"] = s[2];
                    loadrow["City"] = s[3];
                    loadrow["State"] = s[4];
                    loadtable.Rows.Add(loadrow);
                    record = sr.ReadLine();
                }
            }
            return loadtable;
        }
    }
}

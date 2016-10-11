using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;
using System.Collections;

namespace APress.Samples
{
    public partial class Sql
    {
        [Microsoft.SqlServer.Server.SqlProcedure]
        public static void GetEnvironmentVars()
        {
            try
            {
                SortedList environmentList = new SortedList();
                foreach (DictionaryEntry de in Environment.GetEnvironmentVariables())
                {
                    environmentList[de.Key] = de.Value;
                }
                SqlDataRecord record = new SqlDataRecord(new SqlMetaData("VarName", SqlDbType.NVarChar, 1024),
                    new SqlMetaData("VarValue", SqlDbType.NVarChar, 4000));
                SqlContext.Pipe.SendResultsStart(record);
                foreach (DictionaryEntry de in environmentList)
                {
                    record.SetValue(0, de.Key);
                    record.SetValue(1, de.Value);
                    SqlContext.Pipe.SendResultsRow(record);
                }
                SqlContext.Pipe.SendResultsEnd();
            }
            catch (Exception ex)
            {
                SqlContext.Pipe.Send(ex.Message);
            }
        }
    };
}

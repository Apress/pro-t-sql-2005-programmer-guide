using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;

namespace APress.Samples
{
    public partial class UserDefinedFunctions
    {
        [Microsoft.SqlServer.Server.SqlFunction(DataAccess=DataAccessKind.None,
            IsDeterministic=true)]
        public static SqlDouble Fahrenheit2Celsius(SqlDouble f)
        {
            SqlDouble c = new SqlDouble();
            c = (5.0 / 9.0) * (f - 32.0);
            return c;
        }
    }
};


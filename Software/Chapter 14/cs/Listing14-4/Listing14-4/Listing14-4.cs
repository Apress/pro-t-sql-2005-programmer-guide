using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;

namespace APress.Samples
{
    [Serializable]
    [Microsoft.SqlServer.Server.SqlUserDefinedAggregate(Format.Native)]
    public struct Range
    {
        private SqlDouble min;
        private SqlDouble max;

        public void Init()
        {
            this.min = SqlDouble.Null;
            this.max = SqlDouble.Null;
        }

        public void Accumulate(SqlDouble Value)
        {
            if (!Value.IsNull)
            {
                if (this.min.IsNull || Value < this.min)
                    this.min = Value;
                if (this.max.IsNull || Value > this.max)
                    this.max = Value;
            }
        }

        public void Merge(Range tempRange)
        {
            if (this.min.IsNull || tempRange.min < this.min)
                this.min = tempRange.min;
            if (this.min.IsNull || tempRange.max > this.max)
                this.max = tempRange.max;
        }

        public SqlDouble Terminate()
        {
            SqlDouble result = new SqlDouble();
            result = SqlDouble.Null;
            if (!this.min.IsNull && !this.max.IsNull)
                result = this.max - this.min;
            return result;
        }
    };
}
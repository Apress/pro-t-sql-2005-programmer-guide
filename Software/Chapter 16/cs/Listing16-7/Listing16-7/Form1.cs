using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Net;

namespace Apress.Samples
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void btnQuery_Click(object sender, EventArgs e)
        {
            // Create web services proxy class
            localhost.AdvAdHocEndpoint proxy = new localhost.AdvAdHocEndpoint();

            // Assign credentials to proxy
            proxy.Credentials = CredentialCache.DefaultCredentials;

            // Define the parameterized query here. Notice the leading @ is left on 
            // the parameter name in the query
            string sql = "SELECT ContactID, FirstName, MiddleName, LastName " +
                " FROM Person.Contact " +
                " WHERE LastName = @LastName";

            // Create a parameter for the parameterized query
            localhost.SqlParameter p = new localhost.SqlParameter();
            p.sqlDbType = localhost.sqlDbTypeEnum.VarChar;
            p.maxLength = 50;
            // Notice the leading @ is stripped off the parameter name here
            p.name = "LastName";
            p.Value = txtLastName.Text;

            // Call the sqlbatch web method with the query string and parameter array.
            // Notice we have to create an array and put the parameter in it here
            localhost.SqlParameter [] p1 = { p };
            DataSet ds = (DataSet)(proxy.sqlbatch(sql, ref p1))[0];

            // Bind the data grid view to the result
            dgvResults.DataSource = ds.Tables[0];
        }
    }
}
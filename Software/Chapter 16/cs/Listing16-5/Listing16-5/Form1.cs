using System;
using System.Net;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace APress.Samples
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            // Create a web service proxy using the SQL Server HTTP endpoint
            localhost.AdvSalesEndpoint proxy = new localhost.AdvSalesEndpoint();

            // Set the integrated security credentials
            proxy.Credentials = CredentialCache.DefaultCredentials;

            // Bind the combo box to the results of the web method call
            this.cboSalesPerson.ValueMember = "SalespersonId";
            this.cboSalesPerson.DisplayMember = "FullName";

            // Call the web method
            this.cboSalesPerson.DataSource = proxy.GetSalespersonList().Tables[0];
        }

        private void cboSalesPerson_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Create a web service proxy using the SQL Server HTTP endpoint
            localhost.AdvSalesEndpoint proxy = new localhost.AdvSalesEndpoint();

            // Set the integrated security credentials
            proxy.Credentials = CredentialCache.DefaultCredentials;

            // Bind the data grid view to the results of the web method call
            this.dgvSales.DataSource = proxy.GetSalesPersonSales(new
                System.Data.SqlTypes.SqlInt32((int)this.cboSalesPerson.SelectedValue)).Tables[0];

            // Populate the text box with the results of the second web method call
            this.txtTotalSales.Text = proxy.GetSalesTotal(new
                System.Data.SqlTypes.SqlInt32((int)this.cboSalesPerson.SelectedValue)).Value.ToString("C");
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            // Exit the application
            Application.Exit();
        }

    }
}
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Threading;

namespace EPOLICE
{
    public partial class Registration : System.Web.UI.Page
    {
        SqlConnection conn;
        MySqlCommand comm;
        SqlDataAdapter adap;
        DataSet ds;

        protected void Page_Load(object sender, EventArgs e)
        { 
            if (!IsPostBack)
            {
                Random rnd = new Random();
                txtAdminID.Text = rnd.Next(1000, 9999).ToString();
            }
        }

        protected void btnRegisterAdmin_Click(object sender, EventArgs e)
        {
            string connStr = "Server=localhost;User Id=root;Password=root;Database=mydb;";
            MySqlConnection conn = new MySqlConnection(connStr);

            conn.Open();

            int adminId = int.Parse(txtAdminID.Text);
            string password = txtAdminName.Text + txtAdminID.Text;
            string insert_query = "INSERT INTO administrator(Admin_ID, Admin_First_Name, Admin_Last_Name, Phone_Num, Email, Admin_Password) " +
                          "VALUES (@id, @fName, @lName, @pNum, @email, @adminPass)";

            comm = new MySqlCommand(insert_query, conn);
            comm.Parameters.AddWithValue("@id", adminId);
            comm.Parameters.AddWithValue("@fName", txtAdminName.Text);
            comm.Parameters.AddWithValue("@lName", txtAdminSurname.Text);
            comm.Parameters.AddWithValue("@pNum", txtPhoneNum.Text);
            comm.Parameters.AddWithValue("@email", txtEmail.Text);
            comm.Parameters.AddWithValue("@adminPass", password);

            Session["AdminID"] = adminId;


            comm.ExecuteNonQuery();

            lblMessage.Text = "Admin registered successfully! Admin ID: " + adminId+
                ". Your password is: " + password;
            lblMessage.ForeColor = System.Drawing.Color.Green;

            Random rnd = new Random();
            txtAdminID.Text = rnd.Next(1000, 9999).ToString();


            conn.Close();

            btnGoToLogin.Visible = true;

        }

        protected void btnGoToLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");

        }
    }
}
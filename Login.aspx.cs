using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace EPOLICE
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (ddlRole.SelectedItem.ToString() == "Officer")
            {
                txtLoginAdmin.Visible = false;
                txtLoginPass.Visible = false;
                lblID.Visible = false;
                lblPassword.Visible = false;
            }
            else
            {
                txtLoginAdmin.Visible = true;
                txtLoginPass.Visible = true;
                lblID.Visible = true;
                lblPassword.Visible = true;
            }


        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (ddlRole.SelectedItem.ToString() == "Admin")
            {
                string connStr = "Server=localhost;User Id=root;Password=root;Database=mydb;";
                using (MySqlConnection conn = new MySqlConnection(connStr))
                {
                    conn.Open();

                    string query = "SELECT * FROM administrator WHERE Admin_ID = @id AND Admin_Password = @pass";
                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@id", txtLoginAdmin.Text.Trim());
                    cmd.Parameters.AddWithValue("@pass", txtLoginPass.Text.Trim());

                    MySqlDataReader dr = cmd.ExecuteReader();

                    if (dr.HasRows) // If a row is returned → login success
                    {
                        Session["AdminID"] = txtLoginAdmin.Text;
                        Response.Redirect("Homepage.aspx");
                    }
                    else
                    {
                        lblMessage.Text = "Invalid Admin ID or Password!";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
                }
            }
            else
            {
                Session["LoginState"] = "Officer";
                Response.Redirect("Homepage.aspx");
            }

        }
    }
}
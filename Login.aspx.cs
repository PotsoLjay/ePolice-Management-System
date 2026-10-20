using System;
using System.Web.UI;
using MySql.Data.MySqlClient;

namespace EPOLICE
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Arriving on the login page (including via the Logout link) always ends any previous session.
            if (!IsPostBack)
            {
                Session.Clear();
            }

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
                int adminId;
                string password = txtLoginPass.Text.Trim();

                if (!int.TryParse(txtLoginAdmin.Text.Trim(), out adminId) || password.Length == 0)
                {
                    ShowError("Invalid Admin ID or Password!");
                    return;
                }

                bool loginOk = false;

                using (MySqlConnection conn = Db.CreateConnection())
                {
                    conn.Open();

                    string storedPassword = null;
                    using (MySqlCommand cmd = new MySqlCommand(
                        "SELECT Admin_Password FROM administrator WHERE Admin_ID = @id", conn))
                    {
                        cmd.Parameters.AddWithValue("@id", adminId);
                        object result = cmd.ExecuteScalar();
                        if (result != null && result != DBNull.Value)
                        {
                            storedPassword = result.ToString();
                        }
                    }

                    if (PasswordHasher.IsHashed(storedPassword))
                    {
                        loginOk = PasswordHasher.Verify(password, storedPassword);
                    }
                    else if (PasswordHasher.LegacyPlainTextMatches(password, storedPassword))
                    {
                        // Account created before hashing was added: accept it once, then store a hash instead.
                        loginOk = true;
                        UpgradeLegacyPassword(conn, adminId, password);
                    }
                }

                if (loginOk)
                {
                    Session.Clear();
                    Session["AdminID"] = adminId;
                    Response.Redirect("Homepage.aspx");
                }
                else
                {
                    ShowError("Invalid Admin ID or Password!");
                }
            }
            else
            {
                Session.Clear();
                Session["LoginState"] = "Officer";
                Response.Redirect("Homepage.aspx");
            }
        }

        private void UpgradeLegacyPassword(MySqlConnection conn, int adminId, string password)
        {
            try
            {
                using (MySqlCommand cmd = new MySqlCommand(
                    "UPDATE administrator SET Admin_Password = @hash WHERE Admin_ID = @id", conn))
                {
                    cmd.Parameters.AddWithValue("@hash", PasswordHasher.Hash(password));
                    cmd.Parameters.AddWithValue("@id", adminId);
                    cmd.ExecuteNonQuery();
                }
            }
            catch (MySqlException)
            {
                // Most likely the Admin_Password column is still VARCHAR(45).
                // Run Migrations/001_widen_admin_password.sql. Login still works in the meantime.
            }
        }

        private void ShowError(string message)
        {
            lblMessage.Text = message;
            lblMessage.ForeColor = System.Drawing.Color.Red;
        }
    }
}

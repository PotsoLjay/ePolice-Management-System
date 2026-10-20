using System;
using System.Web.UI;
using MySql.Data.MySqlClient;

namespace EPOLICE
{
    public partial class Registration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Only the master administrator (Admin ID 0) may create new administrator accounts.
            if (!IsMasterAdmin())
            {
                Response.Redirect("Login.aspx", true);
                return;
            }

            if (!IsPostBack)
            {
                txtAdminID.Text = GetNextAdminId().ToString();
            }
        }

        protected void btnRegisterAdmin_Click(object sender, EventArgs e)
        {
            if (!IsMasterAdmin())
            {
                Response.Redirect("Login.aspx", true);
                return;
            }

            if (!Page.IsValid)
            {
                return;
            }

            string firstName = txtAdminName.Text.Trim();
            string lastName = txtAdminSurname.Text.Trim();
            int adminId;

            if (firstName.Length == 0 || lastName.Length == 0 || !int.TryParse(txtAdminID.Text, out adminId))
            {
                ShowMessage("Please enter the first name and last name.", System.Drawing.Color.Red);
                return;
            }

            // A random temporary password is generated and only its hash is stored.
            string temporaryPassword = PasswordHasher.GenerateTemporaryPassword(10);

            try
            {
                using (MySqlConnection conn = Db.CreateConnection())
                {
                    conn.Open();

                    using (MySqlCommand comm = new MySqlCommand(
                        "INSERT INTO administrator(Admin_ID, Admin_First_Name, Admin_Last_Name, Phone_Num, Email, Admin_Password) " +
                        "VALUES (@id, @fName, @lName, @pNum, @email, @adminPass)", conn))
                    {
                        comm.Parameters.AddWithValue("@id", adminId);
                        comm.Parameters.AddWithValue("@fName", firstName);
                        comm.Parameters.AddWithValue("@lName", lastName);
                        comm.Parameters.AddWithValue("@pNum", txtPhoneNum.Text.Trim());
                        comm.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
                        comm.Parameters.AddWithValue("@adminPass", PasswordHasher.Hash(temporaryPassword));
                        comm.ExecuteNonQuery();
                    }
                }
            }
            catch (MySqlException ex)
            {
                if (ex.Number == 1062)
                {
                    // Duplicate Admin ID: pick the next free one and let the user try again.
                    txtAdminID.Text = GetNextAdminId().ToString();
                    ShowMessage("That Admin ID was already taken. A new one has been assigned, please click Register again.", System.Drawing.Color.Red);
                }
                else
                {
                    ShowMessage("Could not register the administrator. Please check the database and try again.", System.Drawing.Color.Red);
                }
                return;
            }

            ShowMessage(
                "Admin registered successfully! Admin ID: " + adminId +
                ". Temporary password: " + temporaryPassword +
                " (shown only once, write it down and share it securely).",
                System.Drawing.Color.Green);

            txtAdminName.Text = string.Empty;
            txtAdminSurname.Text = string.Empty;
            txtPhoneNum.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtAdminID.Text = GetNextAdminId().ToString();

            btnGoToLogin.Visible = true;
        }

        protected void btnGoToLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("Homepage.aspx");
        }

        private bool IsMasterAdmin()
        {
            int id;
            return Session["AdminID"] != null
                && int.TryParse(Session["AdminID"].ToString(), out id)
                && id == 0;
        }

        private int GetNextAdminId()
        {
            using (MySqlConnection conn = Db.CreateConnection())
            {
                conn.Open();

                using (MySqlCommand cmd = new MySqlCommand(
                    "SELECT GREATEST(COALESCE(MAX(Admin_ID), 0), 999) + 1 FROM administrator", conn))
                {
                    return Convert.ToInt32(cmd.ExecuteScalar());
                }
            }
        }

        private void ShowMessage(string text, System.Drawing.Color color)
        {
            lblMessage.Text = text;
            lblMessage.ForeColor = color;
        }
    }
}

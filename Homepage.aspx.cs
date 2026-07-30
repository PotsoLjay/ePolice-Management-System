using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using MySql.Data.MySqlClient;

public partial class Homepage : System.Web.UI.Page
{
    DataSet ds;
    MySqlCommand comm;
    MySqlDataAdapter adap;


    protected void Page_Load(object sender, EventArgs e)
    {
        string connStr = "Server=localhost;User Id=root;Password=root;Database=mydb;";
        MySqlConnection conn = new MySqlConnection(connStr);

        if (Session["LoginState"] !=null)
        {
            if (Session["LoginState"].ToString() == "Officer")
            {
                regLink.Visible = false;
                updatelink.Visible = false;
                delLink.Visible = false;
                gvAdmin.Visible = false;
                register.Visible = false;
                update.Visible = false;
                delete.Visible = false;
            }
        }

        if (Session["AdminID"] != null)
        {
            int AdminId = Convert.ToInt32(Session["AdminID"]);

            // Master Login
            if (AdminId != 0000)
            {
                gvAdmin.Visible = false;
                updatelink.Visible = false;
            }
        }

        

        if (!IsPostBack)
        {
            Random rnd = new Random();
            txtCaseNum.Text = rnd.Next(10000, 99999).ToString();
            Calendar1.SelectedDate = DateTime.Today; 
        }
     
        conn.Open();

        string displayCases = "SELECT * FROM `case`"; 
        adap = new MySqlDataAdapter(displayCases, conn);
        ds = new DataSet();
        adap.Fill(ds);
        gvCases.DataSource = ds;
        gvCases.DataBind();

        string displayVictims= "SELECT * FROM victim";
        adap = new MySqlDataAdapter(displayVictims, conn);
        ds = new DataSet();
        adap.Fill(ds);
        gvVictims.DataSource = ds;
        gvVictims.DataBind();

        string displaySuspects= "SELECT * FROM suspect";
        adap = new MySqlDataAdapter(displaySuspects, conn);
        ds = new DataSet();
        adap.Fill(ds);
        gvSuspects.DataSource = ds;
        gvSuspects.DataBind();

        string displayEvidence= "SELECT * FROM evidence";
        adap = new MySqlDataAdapter(displayEvidence, conn);
        ds = new DataSet();
        adap.Fill(ds);
        gvEvidence.DataSource = ds;
        gvEvidence.DataBind();

        string displayDocuments= "SELECT * FROM documents";
        adap = new MySqlDataAdapter(displayDocuments, conn);
        ds = new DataSet();
        adap.Fill(ds);
        gvWitnesses.DataSource = ds;
        gvWitnesses.DataBind();

        string displayAdmins= "SELECT * FROM administrator";
        adap = new MySqlDataAdapter(displayAdmins, conn);
        ds = new DataSet();
        adap.Fill(ds);
        gvAdmin.DataSource = ds;
        gvAdmin.DataBind();

        conn.Close();
    }

    protected void btnRegisterCase_Click(object sender, EventArgs e)
    {
        string connStr = "Server=localhost;User Id=root;Password=root;Database=mydb;";
        MySqlConnection conn = new MySqlConnection(connStr);

        conn.Open();


        int adminId = Convert.ToInt32(Session["AdminID"]);
        Session["AdminID"] = adminId;
        int caseId = int.Parse(txtCaseNum.Text);
        string insert_query = "INSERT INTO `case`(`Case_ID`, Admin_ID, `Location`, `Date`, `Crime_Committed`) " +
                      "VALUES (@id, @adminID, @location, @date, @crime)";

        comm = new MySqlCommand(insert_query, conn);
        comm.Parameters.AddWithValue("@id", caseId);
        comm.Parameters.AddWithValue("@adminID", adminId);
        comm.Parameters.AddWithValue("@location", txtLocation.Text);
        comm.Parameters.AddWithValue("@date", DateTime.Parse(txtDate.Text));
        comm.Parameters.AddWithValue("@crime", ddlCrimes.SelectedItem.ToString());
        comm.ExecuteNonQuery();


        lblMessage.Text = "Case registered successfully! Case Number: " + caseId;
        Response.Write("txtLocation: " + txtLocation.Text + "<br>");
        Response.Write("ddlCrimes: " + ddlCrimes.SelectedItem?.Text + "<br>");

        // Save Case_ID in session for later use
        Session["CaseID"] = caseId;

        Random rnd = new Random();
        txtCaseNum.Text = rnd.Next(10000, 99999).ToString();

        conn.Close();   
       
    }

    protected void btnUpload_Click(object sender, EventArgs e)
    {
        if (FileUploadImage.HasFile)
        {
            try
            {
                string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif" };
                string fileExtension = System.IO.Path.GetExtension(FileUploadImage.FileName).ToLower();

                if (allowedExtensions.Contains(fileExtension))
                {
                    string uploadFolderPath = Server.MapPath("~/Images/");
                    if (!Directory.Exists(uploadFolderPath))
                    {
                        Directory.CreateDirectory(uploadFolderPath);
                    }

                    string fileName = Path.GetFileName(FileUploadImage.FileName);
                    string filePath = Path.Combine(uploadFolderPath, fileName);

                    FileUploadImage.SaveAs(filePath);

                    ImagePreview.ImageUrl = "~/Images/" + fileName;
                    ImagePreview.Visible = true;

                    // Store the image URL in a session variable
                    Session["EvidenceImageUrl"] = "~/Images/" + fileName;

                    lblMessage.Text = "Image uploaded successfully!";
                    lblMessage.ForeColor = System.Drawing.Color.MintCream;
                }
                else
                {
                    lblMessage.Text = "Invalid file type. Only JPG, JPEG, PNG, and GIF files are allowed.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error uploading image: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }
        else
        {
            lblMessage.Text = "Please select an image to upload.";
            lblMessage.ForeColor = System.Drawing.Color.Red;
        }
    }

    protected void btnRegComplainant_Click(object sender, EventArgs e)
    {
        string connStr = "Server=localhost;User Id=root;Password=root;Database=mydb;";
        MySqlConnection conn = new MySqlConnection(connStr);

        conn.Open();

        int victimId = int.Parse(txtVictimNum.Text);
        int adminId = Convert.ToInt32(Session["AdminID"]);
        int caseId = Convert.ToInt32(Session["CaseID"]);
              
        string getCaseIdQuery = "SELECT Case_ID FROM `case` WHERE Case_ID = @caseID";
        MySqlCommand getCaseIdCmd = new MySqlCommand(getCaseIdQuery, conn);
        getCaseIdCmd.Parameters.AddWithValue("@caseID", caseId);

        object caseResult = getCaseIdCmd.ExecuteScalar();
        if (caseResult == null)
        {
            lblDisplayVictim.Text = "Error: The case does not exist.";
            return;
        }

        string insert_query = "INSERT INTO victim (Victim_ID, Victim_First_Name, Victim_Last_Name, Victim_Phone_Number, Address, Admin_ID, Case_ID) " +
                              "VALUES (@victimID, @victimFName, @victimLName, @victimPNum, @victimAdd, @adminID, @caseID)";

        comm = new MySqlCommand(insert_query, conn);
        comm.Parameters.AddWithValue("@victimID", victimId);
        comm.Parameters.AddWithValue("@victimFName", txtVictimFirst.Text);
        comm.Parameters.AddWithValue("@victimLName", txtVictimLast.Text);
        comm.Parameters.AddWithValue("@victimPNum", txtVictimPhone.Text);
        comm.Parameters.AddWithValue("@victimAdd", txtVictimAddress.Text);
        comm.Parameters.AddWithValue("@adminID", adminId);
        comm.Parameters.AddWithValue("@caseID", caseId);
        comm.ExecuteNonQuery();

        lblDisplayVictim.Text = "Victim registered successfully! Victim Number: " + victimId;

        conn.Close();
    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        string connStr = "Server=localhost;User Id=root;Password=root;Database=mydb;";
        MySqlConnection conn = new MySqlConnection(connStr);

        conn.Open();

        int adminId = Convert.ToInt32(Session["AdminID"]);
        int caseId = Convert.ToInt32(Session["CaseID"]);

        string getCaseIdQuery = "SELECT Case_ID FROM `case` WHERE Case_ID = @caseID";
        MySqlCommand getCaseIdCmd = new MySqlCommand(getCaseIdQuery, conn);
        getCaseIdCmd.Parameters.AddWithValue("@caseID", caseId);

        object caseResult = getCaseIdCmd.ExecuteScalar();
        if (caseResult == null)
        {
            lblDisplayVictim.Text = "Error: The case does not exist.";
            return;
        }

        //int adminId = int.Parse(txtAdminID.Text);
        //string password = txtAdminName.Text + txtAdminID.Text;
        string insert_query = "INSERT INTO suspect(Suspect_ID, Suspect_First_Name, Suspect_Last_Name,  Suspect_Address, Admin_ID, Case_ID) " +
                      "VALUES (@id, @sName, @lName, @address, @admin, @caseID)";

        comm = new MySqlCommand(insert_query, conn);
        comm.Parameters.AddWithValue("@id", txtSuspectNum.Text);
        comm.Parameters.AddWithValue("@sName", txtSuspectFirst.Text);
        comm.Parameters.AddWithValue("@lName", txtSuspectLast.Text);
        comm.Parameters.AddWithValue("@address", txtSuspectAddress.Text);
        comm.Parameters.AddWithValue("@admin", adminId);
        comm.Parameters.AddWithValue("@caseID", caseId);

        Session["AdminID"] = adminId;


        comm.ExecuteNonQuery();
        lblDisplayVictim0.Text = "Victim registered successfully! Victim Number: " + txtSuspectNum.Text;

    }

    protected void Button4_Click(object sender, EventArgs e)
    {
        string connStr = "Server=localhost;User Id=root;Password=root;Database=mydb;";
        MySqlConnection conn = new MySqlConnection(connStr);

        conn.Open();

        int adminId = Convert.ToInt32(Session["AdminID"]);
        int caseId = Convert.ToInt32(Session["CaseID"]);

        string getCaseIdQuery = "SELECT Case_ID FROM `case` WHERE Case_ID = @caseID";
        MySqlCommand getCaseIdCmd = new MySqlCommand(getCaseIdQuery, conn);
        getCaseIdCmd.Parameters.AddWithValue("@caseID", caseId);

        object caseResult = getCaseIdCmd.ExecuteScalar();
        if (caseResult == null)
        {
            lblDisplayVictim.Text = "Error: The case does not exist.";
            return;
        }

        byte[] imgByte = File.ReadAllBytes("C:\\Users\\vezul\\OneDrive\\Pictures\\Saved Pictures\\Screenshots\\Case.png");

        //int adminId = int.Parse(txtAdminID.Text);
        //string password = txtAdminName.Text + txtAdminID.Text;
        string insert_query = "INSERT INTO evidence(Evidence_ID, Case_ID, Description_Of_Evidence,  Admin_ID, Photo_URL) " +
                      "VALUES (@id, @caseID, @description, @admin, @photo)";

        comm = new MySqlCommand(insert_query, conn);
        comm.Parameters.AddWithValue("@id", txtEvidenceNum.Text);
        comm.Parameters.AddWithValue("@caseID", caseId);
        comm.Parameters.AddWithValue("@description", txtEvidenceDescription.Text);
        comm.Parameters.AddWithValue("@admin", adminId);
        //comm.Parameters.AddWithValue("@photo", "Case.png");
        comm.Parameters.AddWithValue("@photo", imgByte);

        Session["AdminID"] = adminId;


        comm.ExecuteNonQuery();
        lblDisplayVictim1.Text = "Victim registered successfully! Victim Number: " + txtEvidenceNum.Text;
    }

    protected void btnCaseDocument_Click(object sender, EventArgs e)
    {
        int adminId = Convert.ToInt32(Session["AdminID"]);

        string connStr = "Server=localhost;User Id=root;Password=root;Database=mydb;";
        MySqlConnection conn = new MySqlConnection(connStr);

        conn.Open();

        DateTime selectedDate = Calendar1.SelectedDate;


         //int adminId = int.Parse(txtAdminID.Text);
        //string password = txtAdminName.Text + txtAdminID.Text;
        string insert_query = "INSERT INTO documents(Document_ID, Document_Type, Date_of_Upload, Description_of_Doc, Admin_ID) " +
                      "VALUES (@id, @type, @date, @description, @admin)";

        comm = new MySqlCommand(insert_query, conn);
        comm.Parameters.AddWithValue("@id", txtDocNum.Text);
        comm.Parameters.AddWithValue("@type", ddlDocumentType.SelectedItem.ToString());
        comm.Parameters.AddWithValue("@date", selectedDate);
        comm.Parameters.AddWithValue("@description", txtDocDescription.Text);
        comm.Parameters.AddWithValue("@admin", adminId);
        

        Session["AdminID"] = adminId;


        comm.ExecuteNonQuery();
        lblSuccess.Text = "Case document number " + txtDocNum.Text + " was uploaded successfully!";
    }

    protected void btnDeleteCase_Click(object sender, EventArgs e)
    {
        string connStr = "Server=localhost;User Id=root;Password=root;Database=mydb;";
        MySqlConnection conn = new MySqlConnection(connStr);

        conn.Open();

        string getCaseIdQuery = "DELETE FROM `case` WHERE Case_ID = @caseID";
        MySqlCommand getCaseIdCmd = new MySqlCommand(getCaseIdQuery, conn);
        getCaseIdCmd.Parameters.AddWithValue("@caseID", txtCaseDelete.Text);
        getCaseIdCmd.ExecuteNonQuery();
        lblDelete.Text = "Case Number " + txtCaseDelete.Text + " was successfully deleted!";
        conn.Close();
    }

    protected void btnUpdateCase_Click(object sender, EventArgs e)
    {
        string connStr = "Server=localhost;User Id=root;Password=root;Database=mydb;";
        MySqlConnection conn = new MySqlConnection(connStr);

        conn.Open();

        string update_query = "UPDATE `case` " + "SET `Location` = @location, `Date` = @date, `Crime_Committed` = @crime " + "WHERE `Case_ID` = @caseID";

        comm = new MySqlCommand(update_query, conn);
        comm.Parameters.AddWithValue("@caseID", txtCaseNum.Text);
        comm.Parameters.AddWithValue("@location", txtLocation.Text);
        comm.Parameters.AddWithValue("@date", DateTime.Parse(txtDate.Text));
        comm.Parameters.AddWithValue("@crime", ddlCrimes.SelectedItem.ToString());
        comm.ExecuteNonQuery();

        lblMessage.Text = "Case number " + txtCaseNum.Text + " was updated successfully!";

        conn.Close();
    }

    protected void btnUpdateComplainant_Click(object sender, EventArgs e)
    {
        string connStr = "Server=localhost;User Id=root;Password=root;Database=mydb;";
        MySqlConnection conn = new MySqlConnection(connStr);

        conn.Open();

        string update_query = "UPDATE victim " +
                        "SET Victim_First_Name = @fName, Victim_Last_Name = @lName, Victim_Phone_Number = @pNum, " +
                        "Address = @address " +
                        "WHERE Victim_ID = @victimID";


        comm = new MySqlCommand(update_query, conn);

        try
        {
            comm.Parameters.AddWithValue("@victimID", int.Parse(txtVictimNum.Text));
            comm.Parameters.AddWithValue("@fName", txtVictimFirst.Text);
            comm.Parameters.AddWithValue("@lName", txtVictimLast.Text);
            comm.Parameters.AddWithValue("@pNum", txtVictimPhone.Text);
            comm.Parameters.AddWithValue("@address", txtVictimAddress.Text);

            comm.ExecuteNonQuery();

            if (!IsPostBack)
            {
                lblDisplayVictim.Text = "Case number " + txtCaseNum.Text + " was updated successfully!";
            }
        }
        catch (MySqlException ex)
        {
            lblDisplayVictim.ForeColor = System.Drawing.Color.Red;
            lblDisplayVictim.Text = "SQL Error: " + ex.Message;
        }


        conn.Close();

    }

    protected void btnUpdateSuspect_Click(object sender, EventArgs e)
    {
        string connStr = "Server=localhost;User Id=root;Password=root;Database=mydb;";
        MySqlConnection conn = new MySqlConnection(connStr);

        conn.Open();

        string update_query = "UPDATE `suspect` " + "SET `Suspect_First_Name` = @name, `Suspect_Last_Name` = @surname, `Suspect_Address` = @address " + "WHERE `Suspect_ID` = @suspectID";

        comm = new MySqlCommand(update_query, conn);
        comm.Parameters.AddWithValue("@name", txtSuspectFirst.Text);
        comm.Parameters.AddWithValue("@surname", txtSuspectLast.Text);
        comm.Parameters.AddWithValue("@address", txtSuspectAddress.Text);
        comm.Parameters.AddWithValue("@suspectID", int.Parse(txtSuspectNum.Text));

        comm.ExecuteNonQuery();

        lblDisplayVictim0.Text = "Suspect number " + txtSuspectNum.Text + " was updated successfully!";

        conn.Close();

    }

    protected void btnDeleteComplainant_Click(object sender, EventArgs e)
    {
        string connStr = "Server=localhost;User Id=root;Password=root;Database=mydb;";
        using (MySqlConnection conn = new MySqlConnection(connStr))
        {
            conn.Open();

            string deleteQuery = "DELETE FROM victim WHERE Victim_ID = @victimID";
            comm = new MySqlCommand(deleteQuery, conn);
            comm.Parameters.AddWithValue("@victimID", txtVictimNum.Text);

            int rowsAffected = comm.ExecuteNonQuery();

            if (rowsAffected > 0)
            {
                lblDisplayVictim.Text = "Victim number " + txtVictimNum.Text + " was deleted successfully!";
            }
            else
            {
                lblDisplayVictim.Text = "No victim found with ID " + txtVictimNum.Text;
            }
        }
    }

    protected void btnDeleteSuspect_Click(object sender, EventArgs e)
    {
        string connStr = "Server=localhost;User Id=root;Password=root;Database=mydb;";
        using (MySqlConnection conn = new MySqlConnection(connStr))
        {
            conn.Open();

            string deleteQuery = "DELETE FROM suspect WHERE Suspect_ID = @suspectID";
            comm = new MySqlCommand(deleteQuery, conn);
            comm.Parameters.AddWithValue("@suspectID", txtSuspectNum.Text);

            int rowsAffected = comm.ExecuteNonQuery();

            if (rowsAffected > 0)
            {
                lblDisplayVictim0.Text = "Suspect number " + txtSuspectNum.Text + " was deleted successfully!";
            }
            else
            {
                lblDisplayVictim0.Text = "No suspect found with ID " + txtSuspectNum.Text;
            }
        }
    }

    protected void btnRegisterEvidence_Click1(object sender, EventArgs e)
    {
        // Check if an image was uploaded and its path is in the session
        if (Session["EvidenceImageUrl"] == null)
        {
            lblDisplayVictim1.Text = "Please upload an image first.";
            lblDisplayVictim1.ForeColor = System.Drawing.Color.Red;
            return;
        }

        // Retrieve the image path from the session
        string photoUrl = Session["EvidenceImageUrl"].ToString();

        string connStr = "Server=localhost;User Id=root;Password=root;Database=mydb;";
        MySqlConnection conn = new MySqlConnection(connStr);

        try
        {
            conn.Open();
            int adminId = Convert.ToInt32(Session["AdminID"]);
            int caseId = Convert.ToInt32(Session["CaseID"]);

            string insert_query = "INSERT INTO evidence(Evidence_ID, Case_ID, Description_Of_Evidence, Admin_ID, Photo_URL) " +
                                  "VALUES (@id, @caseID, @description, @admin, @photo)";

            MySqlCommand comm = new MySqlCommand(insert_query, conn);
            comm.Parameters.AddWithValue("@id", txtEvidenceNum.Text);
            comm.Parameters.AddWithValue("@caseID", caseId);
            comm.Parameters.AddWithValue("@description", txtEvidenceDescription.Text);
            comm.Parameters.AddWithValue("@admin", adminId);
            comm.Parameters.AddWithValue("@photo", photoUrl); // Use the URL from the session

            comm.ExecuteNonQuery();

            lblDisplayVictim1.Text = "Evidence registered successfully! Evidence Number: " + txtEvidenceNum.Text;
            lblDisplayVictim1.ForeColor = System.Drawing.Color.Green;

            // Clear the session variable after successful registration to prevent re-use
            Session["EvidenceImageUrl"] = null;
        }
        catch (Exception ex)
        {
            lblDisplayVictim1.Text = "An error occurred during registration: " + ex.Message;
            lblDisplayVictim1.ForeColor = System.Drawing.Color.Red;
        }
        finally
        {
            if (conn.State == System.Data.ConnectionState.Open)
            {
                conn.Close();
            }
        }
    }

    protected void btnUpdateEvidence_Click(object sender, EventArgs e)
    {
        // 1. Get connection string and establish connection
        string connStr = "Server=localhost;User Id=root;Password=root;Database=mydb;";
        MySqlConnection conn = new MySqlConnection(connStr);

        try
        {
            conn.Open();

            // 2. Retrieve necessary IDs from Session (assuming they are set elsewhere)
            // Ensure these Session variables are correctly populated when the page loads or form is submitted
            if (Session["AdminID"] == null || Session["CaseID"] == null)
            {
                lblDisplayVictim1.Text = "Error: Admin ID or Case ID not found in session. Cannot update evidence.";
                lblDisplayVictim1.ForeColor = System.Drawing.Color.Red;
                return;
            }

            int adminId = Convert.ToInt32(Session["AdminID"]);
            int caseId = Convert.ToInt32(Session["CaseID"]);

            // Get the Evidence ID from the textbox to identify which record to update
            string evidenceId = txtEvidenceNum.Text.Trim();

            // Validate Evidence ID
            if (string.IsNullOrEmpty(evidenceId))
            {
                lblDisplayVictim1.Text = "Please enter an Evidence Number to update.";
                lblDisplayVictim1.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string update_query;
            string photoUrl = null; // Initialize photoUrl to null

            // 3. Handle optional new image upload
            if (FileUploadImage.HasFile)
            {
                // Define allowed extensions (optional, but recommended for security)
                string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif" };
                string fileExtension = Path.GetExtension(FileUploadImage.FileName).ToLower();

                if (!allowedExtensions.Contains(fileExtension))
                {
                    lblDisplayVictim1.Text = "Invalid file type. Only JPG, JPEG, PNG, and GIF files are allowed.";
                    lblDisplayVictim1.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                // Generate a unique filename or use original and save the uploaded image
                string fileName = Path.GetFileName(FileUploadImage.FileName);
                string uploadFolderPath = Server.MapPath("~/Images/Evidence/"); // Consider using a dedicated 'Evidence' subfolder

                if (!Directory.Exists(uploadFolderPath))
                {
                    Directory.CreateDirectory(uploadFolderPath);
                }

                string filePath = Path.Combine(uploadFolderPath, fileName);

                // Save the file to the server's file system
                FileUploadImage.SaveAs(filePath);

                // Update the ImagePreview and session
                ImagePreview.ImageUrl = "~/Images/Evidence/" + fileName;
                ImagePreview.Visible = true;
                Session["EvidenceImageUrl"] = "~/Images/Evidence/" + fileName; // Update session with new image URL
                photoUrl = (string)Session["EvidenceImageUrl"];

                // Construct UPDATE query with Photo_URL
                update_query = "UPDATE evidence SET Case_ID = @caseID, Description_Of_Evidence = @description, " +
                               "Admin_ID = @admin, Photo_URL = @photo " +
                               "WHERE Evidence_ID = @id";
            }
            else
            {
                // If no new file uploaded, update without changing Photo_URL
                update_query = "UPDATE evidence SET Case_ID = @caseID, Description_Of_Evidence = @description, " +
                               "Admin_ID = @admin " +
                               "WHERE Evidence_ID = @id";
            }

            // 4. Create MySQLCommand and add parameters
            MySqlCommand comm = new MySqlCommand(update_query, conn);
            comm.Parameters.AddWithValue("@id", evidenceId);
            comm.Parameters.AddWithValue("@caseID", caseId);
            comm.Parameters.AddWithValue("@description", txtEvidenceDescription.Text.Trim());
            comm.Parameters.AddWithValue("@admin", adminId);

            if (FileUploadImage.HasFile)
            {
                comm.Parameters.AddWithValue("@photo", photoUrl); // Only add if photo is updated
            }

            // 5. Execute the update command
            int rowsAffected = comm.ExecuteNonQuery();

            // 6. Provide feedback to the user
            if (rowsAffected > 0)
            {
                lblDisplayVictim1.Text = "Evidence updated successfully for Evidence Number: " + evidenceId;
                lblDisplayVictim1.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                lblDisplayVictim1.Text = "No evidence found with ID: " + evidenceId + " or no changes were made.";
                lblDisplayVictim1.ForeColor = System.Drawing.Color.Orange;
            }
        }
        catch (Exception ex)
        {
            lblDisplayVictim1.Text = "An error occurred during evidence update: " + ex.Message;
            lblDisplayVictim1.ForeColor = System.Drawing.Color.Red;
        }
        finally
        {
            // Ensure the connection is closed
            if (conn.State == System.Data.ConnectionState.Open)
            {
                conn.Close();
            }
        }
    }
    protected void Button8_Click(object sender, EventArgs e)
    {
        // Retrieve Admin ID from Session
        if (Session["AdminID"] == null)
        {
            lblSuccess.Text = "Error: Admin ID not found in session. Cannot update document.";
            lblSuccess.ForeColor = System.Drawing.Color.Red;
            return;
        }
        int adminId = Convert.ToInt32(Session["AdminID"]);

        // Database connection string
        string connStr = "Server=localhost;User Id=root;Password=root;Database=mydb;";
        MySqlConnection conn = new MySqlConnection(connStr);
        MySqlCommand comm = null; // Declare comm here

        try
        {
            conn.Open();

            // Get values from form controls
            string documentId = txtDocNum.Text.Trim();
            string documentType = ddlDocumentType.SelectedItem.ToString();
            DateTime selectedDate = Calendar1.SelectedDate;
            string descriptionOfDoc = txtDocDescription.Text.Trim();

            // Validate Document ID
            if (string.IsNullOrEmpty(documentId))
            {
                lblSuccess.Text = "Please enter a Document Number to update.";
                lblSuccess.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // Construct the UPDATE SQL query
            string update_query = "UPDATE documents SET Document_Type = @type, Date_of_Upload = @date, " +
                                  "Description_of_Doc = @description, Admin_ID = @admin " +
                                  "WHERE Document_ID = @id";

            comm = new MySqlCommand(update_query, conn);

            // Add parameters to the command
            comm.Parameters.AddWithValue("@type", documentType);
            comm.Parameters.AddWithValue("@date", selectedDate);
            comm.Parameters.AddWithValue("@description", descriptionOfDoc);
            comm.Parameters.AddWithValue("@admin", adminId);
            comm.Parameters.AddWithValue("@id", documentId); // Used in the WHERE clause

            // Execute the update command
            int rowsAffected = comm.ExecuteNonQuery();

            // Provide feedback to the user
            if (rowsAffected > 0)
            {
                lblSuccess.Text = $"Case document number {documentId} was updated successfully!";
            }
            else
            {
                lblSuccess.Text = $"No document found with ID: {documentId} or no changes were made.";
                lblSuccess.ForeColor = System.Drawing.Color.Orange;
            }
        }
        catch (Exception ex)
        {
            // Display any errors that occur during the update process
            lblSuccess.Text = "An error occurred during document update: " + ex.Message;
            lblSuccess.ForeColor = System.Drawing.Color.Red;
        }
        finally
        {
            // Ensure the database connection is closed
            if (conn.State == System.Data.ConnectionState.Open)
            {
                conn.Close();
            }
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        string connStr = "Server=localhost;User Id=root;Password=root;Database=mydb;";
        using (MySqlConnection conn = new MySqlConnection(connStr))
        {
            try
            {
                conn.Open();

                string update_query;

                // Check if password should be updated
                if (!string.IsNullOrEmpty(txtPassword.Text))
                {
                    update_query = "UPDATE administrator " +
                                   "SET Admin_First_Name = @fName, Admin_Last_Name = @lName, " +
                                   "Phone_Num = @pNum, Email = @Email, Admin_Password = @AdminPass " +
                                   "WHERE Admin_ID = @Id";
                }
                else
                {
                    update_query = "UPDATE administrator " +
                                   "SET Admin_First_Name = @fName, Admin_Last_Name = @lName, " +
                                   "Phone_Num = @pNum, Email = @Email " +
                                   "WHERE Admin_ID = @Id";
                }

                using (MySqlCommand comm = new MySqlCommand(update_query, conn))
                {
                    // Add common parameters
                    comm.Parameters.AddWithValue("@Id", txtAdminID.Text);
                    comm.Parameters.AddWithValue("@fName", txtAdminName.Text);
                    comm.Parameters.AddWithValue("@lName", txtAdminSurname.Text);
                    comm.Parameters.AddWithValue("@pNum", txtPhoneNum.Text);
                    comm.Parameters.AddWithValue("@Email", txtEmail.Text);

                    // Add password parameter only if needed
                    if (!string.IsNullOrEmpty(txtPassword.Text))
                    {
                        comm.Parameters.AddWithValue("@AdminPass", txtPassword.Text);
                    }

                    int rows = comm.ExecuteNonQuery();

                    if (rows > 0)
                    {
                        Label15.Text = "Administrator updated successfully!";
                    }
                    else
                    {
                        Label15.ForeColor = System.Drawing.Color.Red;
                        Label15.Text = "No records were updated. Please check the Admin ID.";
                    }
                }
            }
            catch (MySqlException ex)
            {
                Label15.ForeColor = System.Drawing.Color.Red;
                Label15.Text = "Database Error: " + ex.Message;
            }
            catch (Exception ex)
            {
                Label15.ForeColor = System.Drawing.Color.Red;
                Label15.Text = "Unexpected Error: " + ex.Message;
            }
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        string connStr = "Server=localhost;User Id=root;Password=root;Database=mydb;";
        MySqlConnection conn = new MySqlConnection(connStr);

        conn.Open();

        string getCaseIdQuery = "DELETE FROM  victim WHERE Victim_ID = @victimId";
        MySqlCommand getCaseIdCmd = new MySqlCommand(getCaseIdQuery, conn);
        getCaseIdCmd.Parameters.AddWithValue("@victimId", TextBox1.Text);
        getCaseIdCmd.ExecuteNonQuery();
        Label11.Text = TextBox1.Text + " has been successfully deleted.";
        conn.Close();
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        string connStr = "Server=localhost;User Id=root;Password=root;Database=mydb;";
        MySqlConnection conn = new MySqlConnection(connStr);

        conn.Open();

        string getCaseIdQuery = "DELETE FROM suspect WHERE Suspect_ID = @suspectId";
        MySqlCommand getCaseIdCmd = new MySqlCommand(getCaseIdQuery, conn);
        getCaseIdCmd.Parameters.AddWithValue("@suspectId", TextBox2.Text);
        getCaseIdCmd.ExecuteNonQuery();
        Label12.Text = TextBox2.Text + " has been successfully deleted.";
        conn.Close();
    }

    protected void Button5_Click(object sender, EventArgs e)
    {
        string connStr = "Server=localhost;User Id=root;Password=root;Database=mydb;";
        MySqlConnection conn = new MySqlConnection(connStr);

        conn.Open();

        string getCaseIdQuery = "DELETE FROM documents WHERE Document_ID = @documentId";
        MySqlCommand getCaseIdCmd = new MySqlCommand(getCaseIdQuery, conn);
        getCaseIdCmd.Parameters.AddWithValue("@documentId", TextBox3.Text);
        getCaseIdCmd.ExecuteNonQuery();
        Label13.Text = TextBox3.Text + " Has been successfully deleted";
        conn.Close();
    }

    protected void Button6_Click(object sender, EventArgs e)
    {
        string connStr = "Server=localhost;User Id=root;Password=root;Database=mydb;";
        MySqlConnection conn = new MySqlConnection(connStr);

        conn.Open();

        string getCaseIdQuery = "DELETE FROM `evidence` WHERE Evidence_ID = @evidenceId";
        MySqlCommand getCaseIdCmd = new MySqlCommand(getCaseIdQuery, conn);
        getCaseIdCmd.Parameters.AddWithValue("@evidenceId", TextBox4.Text);
        getCaseIdCmd.ExecuteNonQuery();
        Label14.Text = TextBox4.Text + " has been successfully deleted.";
        conn.Close();
    }

    protected void Button7_Click(object sender, EventArgs e)
    {
        string connStr = "Server=localhost;User Id=root;Password=root;Database=mydb;";
        MySqlConnection conn = new MySqlConnection(connStr);

        conn.Open();

        string getCaseIdQuery = "DELETE FROM `administrator` WHERE Admin_ID = @adminId";
        MySqlCommand getCaseIdCmd = new MySqlCommand(getCaseIdQuery, conn);
        getCaseIdCmd.Parameters.AddWithValue("@adminId", TextBox5.Text);
        getCaseIdCmd.ExecuteNonQuery();
        Label16.Text = TextBox5.Text + " has been successfully deleted.";
        conn.Close();
    }


    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        string keyword = txtSearch.Text.Trim();


        string connStr = "Server=localhost;User Id=root;Password=root;Database=mydb;";
        MySqlConnection conn = new MySqlConnection(connStr);

        conn.Open();

        //Case Table
        string searchQuery = "SELECT * FROM `case` " +
                      "WHERE Case_ID LIKE @keyword OR Admin_ID LIKE @keyword OR Location LIKE @keyword OR Crime_Committed LIKE @keyword";
        comm = new MySqlCommand(searchQuery, conn);
        comm.Parameters.AddWithValue("@keyword", "%" + keyword + "%");

        MySqlDataAdapter adap = new MySqlDataAdapter(comm);
        DataTable dt = new DataTable();
        adap.Fill(dt);

        gvCases.DataSource = dt;
        gvCases.DataBind();

        // Victims Table
        string searchVictims = "SELECT * FROM victim " +
                               "WHERE Victim_ID LIKE @keyword OR Admin_ID LIKE @keyword OR Case_ID LIKE @keyword OR " +
                               "Victim_First_Name LIKE @keyword OR Victim_Last_Name LIKE @keyword OR Address LIKE @keyword";
        MySqlDataAdapter adapVictims = new MySqlDataAdapter(searchVictims, conn);
        adapVictims.SelectCommand.Parameters.AddWithValue("@keyword", "%" + keyword + "%");
        DataTable dtVictims = new DataTable();
        adapVictims.Fill(dtVictims);
        gvVictims.DataSource = dtVictims;
        gvVictims.DataBind();

        // Suspects Table
        string searchSuspects = "SELECT * FROM suspect " +
                                "WHERE Suspect_ID LIKE @keyword OR Admin_ID LIKE @keyword OR Case_ID LIKE @keyword OR " +
                                "Suspect_First_Name LIKE @keyword OR Suspect_Last_Name LIKE @keyword OR Suspect_Address LIKE @keyword";
        MySqlDataAdapter adapSuspects = new MySqlDataAdapter(searchSuspects, conn);
        adapSuspects.SelectCommand.Parameters.AddWithValue("@keyword", "%" + keyword + "%");
        DataTable dtSuspects = new DataTable();
        adapSuspects.Fill(dtSuspects);
        gvSuspects.DataSource = dtSuspects;
        gvSuspects.DataBind();

        // Evidence Table
        string searchEvidence = "SELECT * FROM evidence " +
                                "WHERE Evidence_ID LIKE @keyword OR Admin_ID LIKE @keyword OR Case_ID LIKE @keyword OR Description_Of_Evidence LIKE @keyword";
        MySqlDataAdapter adapEvidence = new MySqlDataAdapter(searchEvidence, conn);
        adapEvidence.SelectCommand.Parameters.AddWithValue("@keyword", "%" + keyword + "%");
        DataTable dtEvidence = new DataTable();
        adapEvidence.Fill(dtEvidence);
        gvEvidence.DataSource = dtEvidence;
        gvEvidence.DataBind();

        // Documents Table
        string searchDocs = "SELECT * FROM documents " +
                            "WHERE Document_ID LIKE @keyword OR Admin_ID LIKE @keyword OR Description_Of_Doc LIKE @keyword OR Document_Type LIKE @keyword";
        MySqlDataAdapter adapDocs = new MySqlDataAdapter(searchDocs, conn);
        adapDocs.SelectCommand.Parameters.AddWithValue("@keyword", "%" + keyword + "%");
        DataTable dtDocs = new DataTable();
        adapDocs.Fill(dtDocs);
        gvWitnesses.DataSource = dtDocs;
        gvWitnesses.DataBind();

        // Admin Table
        string searchAdmin = "SELECT * FROM administrator " +
                             "WHERE Admin_ID LIKE @keyword OR Admin_First_Name LIKE @keyword OR Admin_Last_Name LIKE @keyword OR Email LIKE @keyword";
        MySqlDataAdapter adapAdmin = new MySqlDataAdapter(searchAdmin, conn);
        adapAdmin.SelectCommand.Parameters.AddWithValue("@keyword", "%" + keyword + "%");
        DataTable dtAdmin = new DataTable();
        adapAdmin.Fill(dtAdmin);
        gvAdmin.DataSource = dtAdmin;
        gvAdmin.DataBind();

        conn.Close();
    }

   /* protected void btnDownload_Click(object sender, EventArgs e)
    {
        // Add a null check for the 'view' control to prevent a NullReferenceException.
        if (view == null)
        {
            // You might want to log this error or display a message to the user.
            // For now, we will simply return.
            return;
        }

        ReplaceControlsWithLiterals(view);

        Response.ContentType = "application/pdf";
        Response.AddHeader("content-disposition", "attachment;filename=YourFileName.pdf");
        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        using (StringWriter sw = new StringWriter())
        using (HtmlTextWriter hw = new HtmlTextWriter(sw))
        {
            view.RenderControl(hw);

            using (Document doc = new Document(PageSize.A4))
            {
                PdfWriter.GetInstance(doc, Response.OutputStream);
                doc.Open();

                using (StringReader sr = new StringReader(sw.ToString()))
                {
                    HTMLWorker htmlparser = new HTMLWorker(doc);
                    htmlparser.Parse(sr);
                }

                doc.Close();
            }
        }

        Response.End();
    }

    private void ReplaceControlsWithLiterals(Control parent)
    {
        try
        {
            // Iterate backward to avoid issues with modifying the collection during iteration.
            for (int i = parent.Controls.Count - 1; i >= 0; i--)
            {
                Control c = parent.Controls[i];

                if (c == null) continue; // Skip if the control is null

                if (c is TextBox txt)
                {
                    parent.Controls.Remove(c);
                    parent.Controls.AddAt(i, new Literal { Text = txt.Text });
                }
                else if (c is DropDownList ddl)
                {
                    parent.Controls.Remove(c);
                    // Add a null check for SelectedItem
                    parent.Controls.AddAt(i, new Literal { Text = ddl.SelectedItem != null ? ddl.SelectedItem.Text : "" });
                }
                else if (c is Button btn)
                {
                    parent.Controls.Remove(c);
                    // Add a null check for btn.Text
                    parent.Controls.AddAt(i, new Literal { Text = btn.Text ?? "" });
                }
                // Handle LinkButton controls
                else if (c is LinkButton lbtn)
                {
                    parent.Controls.Remove(c);
                    parent.Controls.AddAt(i, new Literal { Text = lbtn.Text ?? "" });
                }
                else if (c.HasControls())
                {
                    ReplaceControlsWithLiterals(c);
                }
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine($"Error replacing controls: {ex.Message}");
        }
    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }*/

}



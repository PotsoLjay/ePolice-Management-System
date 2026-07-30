<%@ Page Language="C#" AutoEventWireup="true" Inherits="Homepage" Codebehind="Homepage.aspx.cs" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ePolice Management System</title>
    <link rel="stylesheet" type="text/css" href="styles/hompage.css" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&display=swap" />

    <style>

        @font-face {
            font-family: 'OV Soge';
            src: url('Fonts/OVSoge-Thin.woff') format('woff');
            font-weight: 100; /* Thin */
            font-style: normal;
        }

        @font-face {
            font-family: 'OV Soge';
            src: url('Fonts/OVSoge-ExtraLight.woff') format('woff');
            font-weight: 200; /* Extra Light */
            font-style: normal;
        }

        @font-face {
            font-family: 'OV Soge';
            src: url('Fonts/OVSoge-Light.woff') format('woff');
            font-weight: 300; /* Light */
            font-style: normal;
        }

        @font-face {
            font-family: 'OV Soge';
            src: url('Fonts/OVSoge-Regular.woff') format('woff');
            font-weight: 400; /* Regular / Normal */
            font-style: normal;
        }

        @font-face {
            font-family: 'OV Soge';
            src: url('Fonts/OVSoge-Medium.woff') format('woff');
            font-weight: 500; /* Medium */
            font-style: normal;
        }

        @font-face {
            font-family: 'OV Soge';
            src: url('Fonts/OVSoge-SemiBold.woff') format('woff');
            font-weight: 600; /* Semi Bold */
            font-style: normal;
        }

        @font-face {
            font-family: 'OV Soge';
            src: url('Fonts/OVSoge-Bold.woff') format('woff');
            font-weight: 700; /* Bold */
            font-style: normal;
        }

        @font-face {
            font-family: 'OV Soge';
            src: url('Fonts/OVSoge-ExtraBold.woff') format('woff');
            font-weight: 800; /* Extra Bold */
            font-style: normal;
        }

        @font-face {
            font-family: 'OV Soge';
            src: url('Fonts/OVSoge-Black.woff') format('woff');
            font-weight: 900; /* Black */
            font-style: normal;
        }

        *{
            
            color: black;
        }
        body {
            font-family:  'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 0;   
            margin: 0;
            background: #006080;
            background: linear-gradient(90deg,rgba(0, 96, 128, 1) 0%, rgba(13, 0, 99, 0.84) 45%, rgba(255, 25, 0, 0.81) 100%);
            padding:0;
        }

     
        .navbar {
            background-color: black;
            color: white;
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            align-items: center;
            position: fixed;
            z-index: 100;
            padding: 0px 50px;
            left: 300px;
            right: 0;
            top:0;
            height: 100px;
            
        }
        .navbar h1 {
            margin: 0;
            font-size: 24px;
            
        }
        .logout {
            text-decoration: none;
            color: white;
            font-weight: bold;
        }

        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 300px;
            height: 100vh;
            background-color: #1e1e2f; 
            display: flex;
            flex-direction: column;
            align-items: center;
            box-sizing: border-box;
            gap: 20px; 
            padding-top: 30px; 
            border-right: 2px solid #444; 
        }


        .sidebar a {
            display: block;
            width: 80%;                        
            padding: 15px 20px; 
            text-decoration: none;
            color: #f0f0f0; 
            font-weight: 600;
            text-align: center;
            background: #2c2c44; 
            border-radius: 10px;   
            transition: all 0.3s ease; 
        }

        .sidebar a:hover {
            background: #ff6f61; 
            color: white;
            transform: translateX(5px); 
        }


        .logo {
            display: flex;
            flex-direction: row;
            gap: 10px;
            font-size: 28px;
            align-items: center;
            justify-content: center;
            font-weight: bolder;
            width: 100%;
            height: 80px; 
            color: #f0f0f0;
            font-family: 'OV Soge';
            padding: 10px 0;
            box-sizing: border-box;
        }

        .sidebar-logo {
            width: 50px;      
            height: 50px;      
            object-fit: contain; 
        }


        .content {
            margin-top: 50px;
            margin-left: 460px; 
            padding: 30px;
            display: flex;
            flex-direction: column;
            align-items: center; 
            width: calc(100% - 320px);
            box-sizing: border-box;
            color: white;
        }

        .content > .form-section {
            width: 100%;
            max-width: 800px;  
        }

        .content h3, conetent h2,
        .content label {
            text-align: left;
            width: 100%;
            max-width: 800px;
            margin-bottom: 10px;
            color: white;
        }

        .content .gvContainer {
            width: 100%;
            max-width: 800px; 
            overflow-x: auto; 
            margin-bottom: 30px;
        }

        .content .gvContainer table {
            width: 100%; 
            table-layout: fixed;
            border-collapse: collapse;
        }



        .bgImage {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            overflow: hidden; 
            z-index: -1;
            margin-left: 300px;
        }

        .bgImage img {
            width: 100%;
            height: 100%;
            object-fit: contain; 
            filter: blur(0.1px);
            opacity: 0.9;
            transform: scale(1.05); 
        }

        .form-section {
            margin-bottom: 40px;
            margin-right: auto;
            width: 100%;
            max-width: 800px;
        }
        .form-section h2 {
            color: #003087;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input,
        .form-group select,
        .form-group textarea {
            padding: 8px;
            border: none;
            border-radius: 4px;
            box-sizing: border-box;
            width: 100%;
            max-width: 600px;
            max-height: 40px;
            color: black
        }
        .form-group select {
            height: 40px;
        }
        .form-group textarea {
            height: 100px;
        }

       
        asp\:Button,
        asp\:TextBox,
        input[type="submit"],
        button,
        .btn {
            background: #200122;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;        
            height: 50px;      
            font-size: 15px;
            text-align: center;  
            max-width: 600px;
            max-height: 40px;
       
        }

        asp\:Button:hover,
        input[type="submit"]:hover,
        button:hover,
        .btn:hover {
             background: white;
             color: #200122;
        }

        .form-group-buttons asp\:Button,
        .form-group-buttons input[type="submit"],
        .form-group-buttons button,
        .form-group-buttons .btn
        .form-group,
        asp\:Textbox{
            width: 100%;       
            max-width: 600px;
            box-sizing: border-box;
            display: block;    
        }

        #txtSuspectAddress,
        #txtVictimAddress{
            max-height: 300px;
            margin-bottom: 10px;
        }

        #txtEvidenceDescription,
        #txtDocDescription {
            height: 100px;
            width: 600px;
        }


       .form-group-buttons {
            display: flex;
            justify-content: flex-start; 
            align-items: center;         
            flex-wrap: wrap;             
            gap: 15px;                  
       }   

        .auto-style1 {
            font-size: medium;
        }

        #Calendar1 {
            width: 100%;
            max-width: 600px;
            border-collapse: collapse;
            font-family: 'OV Soge', sans-serif;
            color: black;
            background-color: whitesmoke;
            height: 50px;
        }

        #Calendar1 .calendarTitle,
        #Calendar1 th {
            background: linear-gradient(to right, #001f4d, #003087);
            color: white;
            padding: 8px;
            text-align: center;
        }

        #Calendar1 th {
            font-weight: bold;
        }

        #Calendar1 td {
            border: 1px solid #003087;
            padding: 8px;
            text-align: center;
            cursor: pointer;
        }

        #Calendar1 td:hover {
            background-color: #cce0ff;
        }

        #Calendar1 .selectedDay {
            background-color: #003087;
            color: white;
            font-weight: bold;
        }

        #Calendar1 .todaysDay {
            border: 2px solid #001f4d;
        }
        
         #delete {
            color: white;
            display: flex;
            flex-direction: column;
            align-content: center;
            gap: 20px;
            height: 100vh;
        }



        h2, h1, h2 {
            color: white;
        }
        asp\:Label {color:black;}

        #Lable10 {
            color: white;
        }

        .content * {
              
        }

        .content select {
            color: black; 
        }

        .content .gvContainer table,
        .content .gvContainer table td,
        .content .gvContainer table th,
        .content .gvContainer table tr,
        .content .gvContainer {
            color: black !important;
        }
    </style>

    <script>
        // Sound function
        function playClickSound() {
            var clickSound = document.getElementById('clickSound');
            if (clickSound) {
                clickSound.currentTime = 0; // Reset to start
                clickSound.play().catch(function (error) {
                    console.log("Audio play failed:", error);
                });
            }
        }
        window.onload = function () {
            // Check if this is the first load in this session
            if (!sessionStorage.getItem("firstLoadDone")) {
                // First load actions
                document.getElementById("register").style.display = "none";
                document.getElementById("delete").style.display = "none";
                document.getElementById("view").style.display = "none";
                document.getElementById("update").style.display = "none";

                // Mark that the first load has been done
                sessionStorage.setItem("firstLoadDone", "true");
            }

            // Add click sound to all buttons
            var buttons = document.querySelectorAll('input[type="submit"], button, .btn, input[type="button"]');
            buttons.forEach(function (button) {
                button.addEventListener('click', playClickSound);
            });

            // Sidebar link handling
            var registerDiv = document.getElementById("register");
            var deleteDiv = document.getElementById("delete");
            var viewDiv = document.getElementById("view");
            var updateDiv = document.getElementById("update");

            document.querySelectorAll(".sidebar a").forEach(link => {
                link.addEventListener("click", function (e) {
                    e.preventDefault();
                    var section = this.getAttribute("href").substring(1);
                    registerDiv.style.display = (section === "register") ? "block" : "none";
                    deleteDiv.style.display = (section === "delete") ? "block" : "none";
                    viewDiv.style.display = (section === "view") ? "block" : "none";
                    updateDiv.style.display = (section === "update") ? "block" : "none";
                });
            });
        };
    </script>


</head>
<body>
    <form id="form1" runat="server">
        <div class="navbar">
            <h1>ePolice System</h1>
            <a href="Login.aspx" class="logout">Logout</a>
            <audio id="clickSound" src="Music/click.mp3" preload="auto"></audio>
        </div>

        <div class="sidebar">
            <div class="logo">
                <asp:Image ID="Image2" runat="server" ImageUrl="~/Images/logo.png" CssClass="sidebar-logo" AlternateText="Logo" />
                <asp:Label ID="Label10" runat="server" Text="ePolice" ForeColor="White"></asp:Label>
            </div>
            <a href="#register" id="regLink" runat="server" onclick="linkReg_Click">Register/ Update Case</a>
            <a href="#delete" id="delLink" class="delBox" runat="server" onclick="linkDel_Click">Delete Operation</a>
            <a href="#view" id="viewLink" runat="server" onclick="linkView_Click">View/Search</a>
            <a href="#update" id="updatelink" runat="server" onclick="linkUpdate_Click">Update Admins</a>
        </div>

        <asp:HyperLink ID="HyperLink1" runat="server">HyperLink</asp:HyperLink>
        <asp:HyperLink ID="HyperLink2" runat="server">HyperLink</asp:HyperLink>

        <div class="content" id="content" runat="server">
            <div class="bgImage">
                <img src="Images/background.png" /><asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtDate" ErrorMessage="Date is a required field!!" ForeColor="Red"></asp:RegularExpressionValidator>
&nbsp;</div>
            <!-- Register Case Section -->
            <div class="form-section" id="register" runat="server">
                <h2 style="color: white">Case Registration Form</h2>
                <h3>Case Details</h3>

                <div class="form-group">
                    <label>Case Number</label>
                    <asp:TextBox ID="txtCaseNum" runat="server"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Date</label>
                    <asp:TextBox ID="txtDate" runat="server"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Time</label>
                    <asp:TextBox ID="txtTime" runat="server"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Location</label>
                    <asp:TextBox ID="txtLocation" runat="server"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Crime Committed</label>
                    <asp:DropDownList ID="ddlCrimes" runat="server">
                        <asp:ListItem>Theft</asp:ListItem>
                        <asp:ListItem>Gender Based Violence</asp:ListItem>
                        <asp:ListItem>Domestic Violence</asp:ListItem>
                        <asp:ListItem>Rape</asp:ListItem>
                        <asp:ListItem>Fraud</asp:ListItem>
                        <asp:ListItem>Assault</asp:ListItem>
                        <asp:ListItem>Kidnapping</asp:ListItem>
                    </asp:DropDownList>
                    <br />
                    <br />
                    <asp:Button ID="btnRegisterCase" runat="server" Text="Register Case"
                      Onclick="btnRegisterCase_Click"           />
                    <asp:Button ID="btnUpdateCase" runat="server"  Text="Update Case" OnClick="btnUpdateCase_Click" />
                    <br />
                <asp:Label ID="lblMessage" runat="server" ForeColor="#FFFF66" BorderColor="White"></asp:Label>
                </div>

                <h3>Victim Details</h3>
                <p>Victim Number</p>
                <p>
                    <asp:TextBox ID="txtVictimNum" runat="server" ></asp:TextBox>
                </p>
                <div class="form-group">
                    <label>First Name</label>
                    <asp:TextBox ID="txtVictimFirst" runat="server"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label>Last Name</label>
                    <asp:TextBox ID="txtVictimLast" runat="server"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label>Phone Number</label>
                    <asp:TextBox ID="txtVictimPhone" runat="server"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label>Address</label>
                    <asp:TextBox ID="txtVictimAddress" runat="server" TextMode="MultiLine"></asp:TextBox>
                    <br />
                    <br />
                    <asp:Button ID="btnRegComplainant" runat="server"  Text="Register Victim"  OnClick="btnRegComplainant_Click" />
                   
                    <asp:Button ID="btnUpdateComplainant" runat="server" Text="Update Victim Details" OnClick="btnUpdateComplainant_Click" />
                    <br />
                <asp:Label ID="lblDisplayVictim" runat="server" ForeColor="#FFFF99" BorderColor="White"></asp:Label>
                </div>

                <h3>Suspect Details</h3>
                <p>
                    <asp:Label ID="Label1" runat="server" Text="Suspect Number"></asp:Label>
                </p>
                <p>
                    <asp:TextBox ID="txtSuspectNum" runat="server"></asp:TextBox>
                </p>
                <div class="form-group">
                    <label>First Name</label>
                    <asp:TextBox ID="txtSuspectFirst" runat="server"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label>Last Name</label>
                    <asp:TextBox ID="txtSuspectLast" runat="server"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label>Address</label>
                    <asp:TextBox ID="txtSuspectAddress" runat="server" TextMode="MultiLine"></asp:TextBox>
                </div>

                
                <div class="form-group">
                    <asp:Button ID="Button3" runat="server"  Text="Register Suspect" OnClick="Button3_Click" />

                    <asp:Button ID="btnUpdateSuspect" runat="server" Text="Update Suspect Details" OnClick="btnUpdateSuspect_Click" />

                    <br />
                <asp:Label ID="lblDisplayVictim0" runat="server" ForeColor="#FFFF99"></asp:Label>
                </div>

                <strong><span class="auto-style1">Evidence Details</span></strong><br />
                <br />
                <asp:Label ID="Label2" runat="server" Text="Evidence Number"></asp:Label>
                <br />
                <asp:TextBox ID="txtEvidenceNum" runat="server"></asp:TextBox>
                <br />
                <br />
                <asp:Label ID="Label3" runat="server" Text="Description of Evidence"></asp:Label>
                <br />
                <asp:TextBox ID="txtEvidenceDescription" runat="server" TextMode="MultiLine" ></asp:TextBox>
                <br />
                <br />
                <asp:Label ID="Label4" runat="server" Text="Photo of Evidence"></asp:Label>
                <br />
                <asp:FileUpload ID="FileUploadImage" runat="server" Height="33px" Width="433px" />
                <br />
                <asp:Button ID="btnUpload" runat="server"  Text="Upload Image"  OnClick="btnUpload_Click" />
                <asp:Image ID="ImagePreview" runat="server" Visible="false" Height="180px" Width="250px" />
                <asp:Label ID="Label9" runat="server" Text="" ForeColor="Red"></asp:Label>
                <br />
                <br />
                <asp:Button ID="btnRegisterEvidence" runat="server" Text="Register" OnClick="btnRegisterEvidence_Click1"/>
                <br />
                <br />
                <asp:Button ID="btnUpdateEvidence" runat="server" Text="Update" OnClick="btnUpdateEvidence_Click"/>
                <asp:Label ID="lblDisplayVictim1" runat="server" ForeColor="#FFFF99"></asp:Label>
                <br />
                <br />
                <br />
                <br />
                <strong><span class="auto-style1">Case Document Details<br />
                <br />
                <asp:Label ID="Label5" runat="server" style="font-size: medium" Text="Document Number"></asp:Label>
                <br />
                <asp:TextBox ID="txtDocNum" runat="server" ></asp:TextBox>
                <br />
                <br />
                <asp:Label ID="Label6" runat="server" style="font-size: medium" Text="Document Type"></asp:Label>
                <br />
                <div class="form-group">
                     <asp:DropDownList ID="ddlDocumentType" runat="server" Width="600px" Height="40px">
                         <asp:ListItem></asp:ListItem>
                         <asp:ListItem>PDF</asp:ListItem>
                         <asp:ListItem>EXCEL</asp:ListItem>
                         <asp:ListItem>WORD</asp:ListItem>
                         <asp:ListItem>PowerPoint</asp:ListItem>
                     </asp:DropDownList>
                </div>
               
                <br />
                <br />
                <asp:Label ID="Label7" runat="server" style="font-size: medium" Text="Date of Upload"></asp:Label>
                <br />
                <asp:Calendar ID="Calendar1" runat="server" Height="50px" style="font-size: medium" Width="600px"></asp:Calendar>
                <br />
                <asp:Label ID="Label8" runat="server" style="font-size: medium" Text="Description of Document"></asp:Label>
                <br />
                <asp:TextBox ID="txtDocDescription" runat="server" TextMode="MultiLine"></asp:TextBox>
                <br />
                <br />
                <asp:Button ID="btnCaseDocument" runat="server"  OnClick="btnCaseDocument_Click" Text="Insert Case Document"  />
                <br />
                <br />
                <asp:Label ID="lblSuccess" runat="server" ForeColor="#FFFF99"></asp:Label>
                </span></strong>
                <asp:Button ID="Button8" runat="server"   Text="Update Case Document" OnClick="Button8_Click"  />
                <br />
                <br />
                <audio controls="controls">
                    <source src="Music/siren.mp3" type="audio/mp3" />
                </audio>
            </div>

            <!-- Delete Case Section -->
            <div class="form-section" id="delete" runat="server">
                <h2 style="color: white">Case Deletion Form</h2>
                <div class="form-group">
                    <label>Case Number<br />  <br />
                <strong><span class="auto-style1">
                <asp:TextBox ID="txtCaseDelete" runat="server"></asp:TextBox>
                <br />
                </span></strong></label></div>
                <div class="form-group">
                    <asp:Button ID="btnDeleteCase" runat="server" OnClick="btnDeleteCase_Click" Text="Delete Case" />
                    <br />
                <strong><span class="auto-style1">
                <asp:Label ID="lblDelete" runat="server" ForeColor="#FFFF99"></asp:Label>
                </span></strong>
                </div>
                 <div class="form-group">
                 <label>Victim Number<br />  <br />
                 <strong><span class="auto-style1">
                 <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                 <br />
                 </span></strong></label></div>
                 <div class="form-group">
                     <asp:Button ID="Button1" runat="server"  Text="Delete Victim" OnClick="Button1_Click" />
                     <br />
                 <strong><span class="auto-style1">
                 <asp:Label ID="Label11" runat="server" ForeColor="#FFFF99"></asp:Label>
                 </span></strong>
                 </div>
                 <div class="form-group">
                 <label>Suspect Number<br />  <br />
                 <strong><span class="auto-style1">
                 <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                 <br />
                 </span></strong></label></div>
                 <div class="form-group">
                     <asp:Button ID="Button2" runat="server" Text="Delete Suspect" OnClick="Button2_Click" />
                     <br />
                 <strong><span class="auto-style1">
                 <asp:Label ID="Label12" runat="server" ForeColor="#FFFF99"></asp:Label>
                 </span></strong>
                 </div>
                 <div class="form-group">
                  <label>Document Number<br />  <br />
                 <strong><span class="auto-style1">
                 <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                 <br />
                 </span></strong></label></div>
                 <div class="form-group">
                     <asp:Button ID="Button5" runat="server"  Text="Delete Document" OnClick="Button5_Click" />
                     <br />
                 <strong><span class="auto-style1">
                 <asp:Label ID="Label13" runat="server" ForeColor="#FFFF99"></asp:Label>
                 </span></strong>
                 </div>
                 <div class="form-group">
                  <label>Evidence Number<br />  <br />
                 <strong><span class="auto-style1">
                 <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
                 <br />
                 </span></strong></label></div>
                 <div class="form-group">
                     <asp:Button ID="Button6" runat="server"  Text="Delete Evidence" OnClick="Button6_Click" />
                     <br />
                 <strong><span class="auto-style1">
                 <asp:Label ID="Label14" runat="server" ForeColor="#FFFF99"></asp:Label>
                 </span></strong>
                 </div>
                <div class="form-group">
                <label>Admin ID<br />  <br />
                <strong><span class="auto-style1">
                <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
                <br />
                </span></strong></label></div>
                <div class="form-group">
                    <asp:Button ID="Button7" runat="server" Text="Delete Admin" OnClick="Button7_Click" />
                    <br />
                <strong><span class="auto-style1">
                <asp:Label ID="Label16" runat="server" ForeColor="#FFFF99"></asp:Label>
                </span></strong>
                </div>
            </div>

            <!-- View Cases Section -->
            <!-- Everything that has to do with view goes under this div-->
            <div class="form-section" id="view" runat="server">
                <h2 style="color:white">View & Search Records</h2>

                <!-- Search Bar -->
                <div class="form-group" style="text-align: center;">
                    <label for="txtSearch">Search Records</label><br />
                    <asp:TextBox ID="txtSearch" runat="server" placeholder="Search by keyword..." CssClass="search-box" AutoPostBack="True" OnTextChanged="txtSearch_TextChanged"></asp:TextBox>
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" />
                </div>

                <div style="text-align: center;">
                    <!-- Cases Table -->
                    <h3>List of Cases</h3>
                    <asp:GridView ID="gvCases" runat="server" AutoGenerateColumns="true" 
                        GridLines="Both" CellPadding="4" ForeColor="#333333" 
                        BackColor="#0099FF" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                        HorizontalAlign="Center">
                        <HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
                        <RowStyle BackColor="#EFF3FB" />
                        <Columns>
                        <asp:BoundField DataField="Date" HeaderText="Date"
                        DataFormatString="{0:yyyy-MM-dd}" HtmlEncode="false" />
                        </Columns>
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>
                
                    <!-- Victims Table -->
                    <h3>List of Victims</h3>
                    <asp:GridView ID="gvVictims" runat="server" AutoGenerateColumns="true"
                        GridLines="Both" CellPadding="4" ForeColor="#333333"
                        BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                        HorizontalAlign="Center">
                        <HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
                        <RowStyle BackColor="#EFF3FB" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>

                    <!-- Suspects Table -->
                    <h3>List of Suspects</h3>
                    <asp:GridView ID="gvSuspects" runat="server" AutoGenerateColumns="true"
                        GridLines="Both" CellPadding="4" ForeColor="#333333"
                        BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                        HorizontalAlign="Center">
                        <HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
                        <RowStyle BackColor="#EFF3FB" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>

                    <!-- Evidence Table -->
                    <h3>List of Evidence</h3>
                    <asp:GridView ID="gvEvidence" runat="server" AutoGenerateColumns="true"
                        GridLines="Both" CellPadding="4" ForeColor="#333333"
                        BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                        HorizontalAlign="Center">
                        <HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
                        <RowStyle BackColor="#EFF3FB" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>

                    <!-- Document Table -->
                    <h3>List of Documents</h3>
                    <asp:GridView ID="gvWitnesses" runat="server" AutoGenerateColumns="true"
                        GridLines="Both" CellPadding="4" ForeColor="#333333"
                        BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                        HorizontalAlign="Center">
                        <HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
                        <RowStyle BackColor="#EFF3FB" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>

                    <!-- Admin Table -->
                    <h3>List of Administrators</h3>
                    <asp:GridView ID="gvAdmin" runat="server" AutoGenerateColumns="true"
                        GridLines="Both" CellPadding="4" ForeColor="#333333"
                        BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                        HorizontalAlign="Center">
                        <HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
                        <RowStyle BackColor="#EFF3FB" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>
                </div>
                <br />
                <br />
                <br />
            </div>

            <!-- Update Admin Section -->
            <div class="form-section" id="update" style="padding-top: 50px" runat="server">
                <div class="form-group">
                <asp:Label ID="lblAdminID" runat="server" Text="Admin ID"></asp:Label>
             
                <asp:TextBox ID="txtAdminID" runat="server"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblName" runat="server" Text="First Name"></asp:Label>
                <asp:TextBox ID="txtAdminName" runat="server"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblSurname" runat="server" Text="Last Name"></asp:Label>
                <asp:TextBox ID="txtAdminSurname" runat="server"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblPhone" runat="server" Text="Phone Number"></asp:Label>
                <asp:TextBox ID="txtPhoneNum" runat="server"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblEmail" runat="server" Text="Email"></asp:Label>
                <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmail" ErrorMessage="Enter a valid email address!!!" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
            </div>

            <div class="form-group">
                <asp:Label ID="Label17" runat="server" Text="Password:" style="margin-top: -10px"></asp:Label>
                <asp:TextBox ID="txtPassword" runat="server"></asp:TextBox>
            </div>

             <br />

            <div class="form-group">
                <asp:Button ID="btnUpdate" runat="server" 
                  Text="Update" CssClass="aspButton" OnClick="btnUpdate_Click" />
            </div>

            <div class="form-group">
                <asp:Label ID="Label15" runat="server" ForeColor="#FFFF99"></asp:Label>
            </div>
            </div>
        </div>
    </form>
</body>
</html>


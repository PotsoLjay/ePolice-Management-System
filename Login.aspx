<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="EPOLICE.Login" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>ePolice - Login</title>

    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background: #006080;
            background: linear-gradient(90deg,rgba(0, 96, 128, 1) 0%, rgba(13, 0, 99, 0.84) 45%, rgba(255, 25, 0, 0.81) 100%);
        }

        #form1 {
            display: flex;
            justify-content: center;
            align-items: center;
            height: calc(100vh - 100px);
        }

        .bgImage {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            overflow: hidden; 
            z-index: -1;
        }

        .bgImage img {
            width: 100%;
            object-fit: contain; 
            filter: blur(2px);
            opacity: 0.05;
            transform: scale(1.05); 
        }

        .header {
            background-color: black;
            color: white;
            height: 100px;
            display: flex;
            align-items: center;   
            padding: 0 20px;                  
        }

        .sidebar-logo {
            width: 80px;           
            height: auto;
            object-fit: contain;
        }

        .header asp\:Label {
            font-size: 30px;
            font-weight: bold;
            line-height: 1;
            display: flex;
            align-items: center;   
        }

        .sidebar-logo {
            width: 50px;           
            object-fit: contain;
        }

        .login-container {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
        }
        .form-group {
            margin-bottom: 10px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #003087;
            font-weight: bold;
        }
        .form-group select, .form-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid green;
            border-radius: 4px;
            box-sizing: border-box;
            
        }
        .form-group #btnLogin1{
            background-color: black;
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }
        .form-group #btnLogin1 {
            background-color: #0051a3;
        }
        .form-group a {
            color: #003087;
            text-decoration: none;
            font-weight: bold;
        }
        .form-group a:hover {
            text-decoration: underline;
        }

        .form-group span {
            margin-top: -15px;
        }
    </style>
</head>
<body>
     <div class="header">
        <asp:Image ID="Image2" runat="server" ImageUrl="~/Images/logo.png" CssClass="sidebar-logo" AlternateText="Logo" />
        <asp:Label ID="Label10" runat="server" Text="ePolice" ForeColor="White" Font-Size="30px"></asp:Label>
     </div>
    <form id="form1" runat="server">
        <div class="bgImage">
            <img src="Images/3832.jpg"/>
        </div>
        <div class="login-container">
            <div class="form-group">
                <label for="ddlRole">Select Role:</label>
                <asp:DropDownList ID="ddlRole" runat="server" AutoPostBack="True">
                    <asp:ListItem>Admin</asp:ListItem>
                    <asp:ListItem>Officer</asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="form-group">
                <asp:Label ID="lblID" runat="server" Text="Admin ID:"></asp:Label>
                <asp:TextBox ID="txtLoginAdmin" runat="server"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblPassword" runat="server" Text="Password:"></asp:Label>
                <asp:TextBox ID="txtLoginPass" runat="server" TextMode="Password"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Button ID="btnLogin1" runat="server" Text="Login" OnClick="btnLogin_Click" BackColor="Black" />
                <br />
                <asp:Label ID="lblMessage" runat="server"></asp:Label>
            </div>

            <div class="form-group">
                <span>or</span><br />
                <br />
                <asp:HyperLink ID="hplRegister" runat="server" NavigateUrl="~/Registration.aspx">Register</asp:HyperLink>
            </div>
        </div>
    </form>
</body>
</html>

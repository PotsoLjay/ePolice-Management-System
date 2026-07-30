<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="EPOLICE.Registration" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>ePolice - Register</title>
    <style>
        body {
            font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            padding: 0;
            background: #006080;
            background: linear-gradient(90deg,rgba(0, 96, 128, 1) 0%, rgba(13, 0, 99, 0.84) 45%, rgba(255, 25, 0, 0.81) 100%);
            margin: 0;
        }

        .box {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            font-size: 15px;
        }
        .header {
            background-color: black;
            color: white;
            text-align: center;
            padding: 20px 0;
            margin: 0;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            
        }
        .header h1 {
            margin: 0;
            font-size: 24px;
        }
        .register-container {
            background-color: white;
            padding: 20px 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
            margin-top: 80px
        }
        .form-group {
            margin-bottom: 10px;
            text-align: left;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #003087;
            font-weight: bold;
        }
        .form-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .form-group .aspButton {
            background-color: #003087;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }
        .form-group .aspButton:hover {
            background-color: #0051a3;
        }

        
    </style>
</head>
<body>
    <div class="header">
        <h1>ePolice</h1>
    </div>
    <div class="box">
        <div class="register-container">
    <form id="form1" CssClass="form" runat="server">
        <div class="form-group">
            <asp:Label ID="lblAdminID" runat="server" Text="Admin ID"></asp:Label>
            <br />
            <br />
            <asp:TextBox ID="txtAdminID" runat="server" ReadOnly="True"></asp:TextBox>
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
            <asp:Button ID="btnRegisterAdmin" runat="server" 
                        Text="Register" CssClass="aspButton"
                        OnClick="btnRegisterAdmin_Click" />
        </div>

        <asp:Button ID="btnGoToLogin" runat="server" Text="Go to Login" 
        Visible="False" OnClick="btnGoToLogin_Click" BackColor="White" ForeColor="Green" Height="42px" Width="296px" />


        <div class="form-group">
            <asp:Label ID="lblMessage" runat="server" Text="" ForeColor="Green"></asp:Label>
        </div>
    </form>
</div>
    </div>
    
</body>
</html>

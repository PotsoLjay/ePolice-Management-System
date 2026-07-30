<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ePolice.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<style>
    body {
        background-color: #000435;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        font-size: 25px;
        color: white;
        height: 463px;
    }

    button {
        background-color: #2c64e3;
        color: white;
    }

    .auto-style1 {
        text-align: center;
        margin: 20px;
    }
</style>
<body>
    <form id="form1" runat="server">
        <div class="auto-style1">
    <asp:Image ID="Image1" runat="server" Height="239px" ImageUrl="~/WhatsApp Image 2025-07-31 at 15.27.14_9c439e1b.png" Width="296px" />
        </div>
    <h1 class="auto-style1">ePolice</h1>
        <div class="auto-style1">
            <asp:TextBox ID="txbName" runat="server" Height="30px" Width="394px">Username</asp:TextBox>
            <br />
            <br />
            <asp:TextBox ID="txbPassword" runat="server" Height="30px" OnTextChanged="txbPassword_TextChanged" Width="394px">Password</asp:TextBox>
            <br />
            <br />
            <asp:DropDownList ID="roleDDlist" runat="server" Height="40px" Width="394px">
                <asp:ListItem>Role</asp:ListItem>
                <asp:ListItem>Administrator</asp:ListItem>
                <asp:ListItem>Detective</asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
            <asp:Button ID="btnLogin" runat="server" Text="LOGIN" Width="394px" BackColor="Blue" BorderColor="Transparent" ForeColor="White" Height="30px" OnClick="btnLogin_Click" />
  
            <br />
            <br />
            <asp:Button ID="btnLogin0" runat="server" Text="REGISTER" Width="394px" BackColor="#0033CC" BorderColor="Transparent" ForeColor="White" Height="30px" OnClick="btnLogin_Click" />
  
        </div>
    </form>
    <p style="text-align: left">
        &nbsp;</p>
</body>
</html>

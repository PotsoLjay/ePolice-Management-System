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
    .auto-style2 {
        width: 302px;
    }
    .auto-style3 {
        width: 271px;
    }
</style>
<body>
    <form id="form1" runat="server">
        <div class="auto-style1">
    <asp:Image ID="Image1" runat="server" Height="239px" ImageUrl="~/WhatsApp Image 2025-07-31 at 15.27.14_9c439e1b.png" Width="296px" />
        </div>
    <h1 class="auto-style1">ePolice</h1>
        <div class="auto-style1">
  
        </div>
    <p style="text-align: left">
        <table style="width: 100%; height: 306px;">
            <tr>
                <td class="auto-style2">
            <br />
            <br />
            <br />
            <br />
                    <br />
                    <br />
            <br />
            <br />
                </td>
                <td class="auto-style3">
                    <asp:Label ID="Label1" runat="server" Font-Size="Large" Text="First Name:"></asp:Label>
                    <br />
                    <br />
                    <asp:Label ID="Label2" runat="server" Font-Size="Large" Text="Last Name:"></asp:Label>
                    <br />
                    <br />
                    <asp:Label ID="Label3" runat="server" Font-Size="Large" Text="Phone Number:"></asp:Label>
                    <br />
                    <br />
                    <asp:Label ID="Label4" runat="server" Font-Size="Large" Text="Email:"></asp:Label>
                </td>
                <td>
                    <br />
            <asp:TextBox ID="txbFName" runat="server" Height="30px" Width="394px"></asp:TextBox>
                    <br />
                    <br />
            <asp:TextBox ID="txbFLast" runat="server" Height="30px" OnTextChanged="txbPassword_TextChanged" Width="394px"></asp:TextBox>
                    <br />
                    <br />
            <asp:TextBox ID="txbFNo" runat="server" Height="30px" OnTextChanged="txbPassword_TextChanged" Width="394px"></asp:TextBox>
                    <br />
                    <br />
            <asp:TextBox ID="txbFEmail" runat="server" Height="30px" OnTextChanged="txbPassword_TextChanged" Width="394px"></asp:TextBox>
                    <br />
                    <br />
                </td>
                <td>&nbsp;</td>
            </tr>
            
        </table>
    </p>
        <p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnRegister" runat="server" Text="Register" Width="366px" BackColor="#0033CC" BorderColor="Blue" ForeColor="White" Height="45px" OnClick="btnLogin_Click" Font-Size="Large" />
  
        </p>
        <p>
            &nbsp;</p>
    </form>
    </body>
</html>

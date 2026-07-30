<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WelcomeForm.aspx.cs" Inherits="ePolice.WelcomeForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
   
<body style="text-align: center; background-color: lightskyblue;">
    <form id="form1" runat="server">
        <div>
    <asp:Image ID="Image1" runat="server" Height="239px" ImageUrl="~/WhatsApp Image 2025-07-31 at 15.27.14_9c439e1b.png" Width="296px" />
            <br />
            <asp:Label ID="Label1" runat="server" Font-Bold="False" Font-Size="XX-Large" Text="Welocome what what"></asp:Label>
            <br />
        </div>
        <asp:Label ID="Label2" runat="server" Font-Size="Large" Text="Choose the operation you want to perform:"></asp:Label>
        <br />
        <br />
        <asp:DropDownList ID="operationDDlist" runat="server" Height="40px" Width="394px">
        </asp:DropDownList>
        <br />
        <br />
            <asp:Button ID="btnLogin0" runat="server" Text="Proceed" Width="297px" BackColor="#0033CC" BorderColor="Transparent" ForeColor="White" Height="55px" OnClick="btnLogin_Click" Font-Size="Large" />
  
        <br />
        <br />
    </form>
</body>
</html>

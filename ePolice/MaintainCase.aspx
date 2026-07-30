<%@ Page Title="Case Registration" Language="C#" AutoEventWireup="true" CodeBehind="CaseRegistration.aspx.cs" Inherits="ePolice.CaseRegistration" %>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Case Registration Form</h2>
    <div>
        <h3>Case Details</h3>
        Case Number: <asp:TextBox ID="txtCaseNumber" runat="server" /><br />
        Date: <asp:TextBox ID="txtDate" runat="server" TextMode="Date" /><br />
        Time: <asp:TextBox ID="txtTime" runat="server" TextMode="Time" /><br />
        Location:
        <asp:DropDownList ID="ddlLocation" runat="server">
            <asp:ListItem Text="Theft" />
            <asp:ListItem Text="Assault" />
            <asp:ListItem Text="Burglary" />
        </asp:DropDownList><br />
    </div>
    <div>
        <h3>Complainant Details</h3>
        Name: <asp:TextBox ID="txtName" runat="server" /><br />
        Contact Number: <asp:TextBox ID="txtContact" runat="server" /><br />
        Address: <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" /><br />
    </div>
    <asp:Button ID="btnSubmit" runat="server" Text="Submit" />
</asp:Content>
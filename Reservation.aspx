<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Reservation.aspx.cs" Inherits="nightclubreservation.Reservation" %>
<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Book a Table - Nightclub</title>
    <link rel="stylesheet" type="text/css" href="Styles/Reservation.css" />
</head>
<body>
    <uc:Navbar runat="server" ID="Navbar" />
    <section id="book-a-table" class="book-a-table">
        <div class="container">
            <div class="section-title">
                <h3>Reservation</h3>
                <p>Book a Table</p>
            </div>

            <form id="form1" runat="server" class="php-email-form">
                <asp:Label ID="lblMessage" runat="server" CssClass="message-label"></asp:Label>
                <asp:Panel ID="pnlReservationCard" runat="server" Visible="false" CssClass="reservation-card">
                <asp:Button ID="btnCancelReservation" runat="server" Text="Cancel Reservation" CssClass="cancel-button" OnClick="btnCancelReservation_Click" />

    <h4>Your Reservation Details</h4>
    <p><strong>Date:</strong> <asp:Label ID="lblResDate" runat="server" /></p>
    <p><strong>Time:</strong> <asp:Label ID="lblResTime" runat="server" /></p>
    <p><strong>Name:</strong> <asp:Label ID="lblResName" runat="server" /></p>
    <p><strong>Phone:</strong> <asp:Label ID="lblResPhone" runat="server" /></p>
    <p><strong>Table Size:</strong> <asp:Label ID="lblResTable" runat="server" /></p>
    <p><strong>Event Type:</strong> <asp:Label ID="lblResEvent" runat="server" /></p>
    <p><strong>Special Requests:</strong> <asp:Label ID="lblResRequest" runat="server" /></p>

                    <asp:Panel ID="Panel1" runat="server" Visible="false" CssClass="reservation-card">
    <h4>Your Reservation Details</h4>
    <p><strong>Name:</strong> <asp:Label ID="Label1" runat="server" /></p>
    <p><strong>Phone:</strong> <asp:Label ID="Label2" runat="server" /></p>
    <p><strong>Date:</strong> <asp:Label ID="Label3" runat="server" /></p>
    <p><strong>Time:</strong> <asp:Label ID="Label4" runat="server" /></p>
    <p><strong>Table Size:</strong> <asp:Label ID="lblResSize" runat="server" /></p>
    <p><strong>Event Type:</strong> <asp:Label ID="Label5" runat="server" /></p>
    <p><strong>Special Requests:</strong> <asp:Label ID="Label6" runat="server" /></p>

    <asp:Button ID="Button1" runat="server" Text="Cancel Reservation"
                CssClass="cancel-button" OnClick="btnCancelReservation_Click" />
</asp:Panel>

</asp:Panel>


                <div class="row">
                    <!-- Date -->
                    <div class="col-lg-4 col-md-6 form-group">
                        <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" TextMode="Date" placeholder="Date"></asp:TextBox>
                    </div>
                    <!-- Time -->
                    <div class="col-lg-4 col-md-6 form-group">
                        <asp:TextBox ID="txtTime" runat="server" CssClass="form-control" TextMode="Time" placeholder="Time"></asp:TextBox>
                    </div>
                    <!-- Name -->
                    <div class="col-lg-4 col-md-6 form-group">
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Your Name"></asp:TextBox>
                    </div>
                    <!-- Phone -->
                    <div class="col-lg-4 col-md-6 form-group mt-3">
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Phone Number"></asp:TextBox>
                    </div>

                    <!-- Table Size (Radio Style) -->
                    <div class="col-lg-8 col-md-6 form-group mt-3">
                        <label>Table Size</label>
                        <asp:RadioButtonList ID="rblTableSize" runat="server" RepeatDirection="Horizontal" CssClass="radio-button-list">
                            <asp:ListItem Value="1">1</asp:ListItem>
                            <asp:ListItem Value="2">2</asp:ListItem>
                            <asp:ListItem Value="3">3</asp:ListItem>
                            <asp:ListItem Value="4">4</asp:ListItem>
                            <asp:ListItem Value="5">5</asp:ListItem>
                            <asp:ListItem Value="6">6</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>

                    <!-- Event Type (Radio Style) -->
                    <div class="col-lg-12 form-group mt-3">
                        <label>Event Type</label>
                        <asp:RadioButtonList ID="rblEventType" runat="server" RepeatDirection="Horizontal" CssClass="radio-button-list">
                            <asp:ListItem>Monday Jazz Night</asp:ListItem>
                            <asp:ListItem>Tuesday Disco Night</asp:ListItem>
                            <asp:ListItem>Wednesday Opera Night</asp:ListItem>
                            <asp:ListItem>Thursday Pop Night</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>

                    <!-- Special Requests -->
                    <div class="col-12 form-group mt-3">
                        <asp:TextBox ID="txtRequest" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Special Requests (optional)"></asp:TextBox>
                    </div>
                </div>

                <div class="text-center mt-4">
                    <asp:Button ID="btnReserve" runat="server" Text="Book a Table" CssClass="submit-button" OnClick="btnReserve_Click" />
                </div>
            </form>
        </div>
    </section>
</body>
</html>

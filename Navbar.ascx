<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Navbar.ascx.cs" Inherits="nightclubreservation.Navbar" %>

<head>
    <style>
        /* Global reset for margin and padding */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Navbar container */
        nav {
            background: rgba(0, 0, 0, 0.7); /* Glassmorphism effect */
            backdrop-filter: blur(10px); /* Blurring the background */
            padding: 15px 30px;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
        }

        /* Navbar list style */
        nav ul {
            display: flex;
            justify-content: left;
            list-style: none;
        }

        /* Navbar links */
        nav ul li {
            margin: 0 15px;
        }

        /* Navbar links style */
        nav ul li a {
            color: white;
            text-decoration: none;
            font-size: 18px;
            text-transform: uppercase;
            font-weight: bold;
            position: relative;
            padding: 5px 10px;
            transition: all 0.3s ease;
        }

        /* Active Link */
        nav ul li a.active {
            border-bottom: 2px solid #fff; /* Underline for active link */
        }

        /* Hover effect */
        nav ul li a:hover {
            color: #ff006e; /* Change color on hover */
        }

        /* Auth Links */
        nav ul li a.auth-link {
            color: #ff006e;
        }

        /* Media query for mobile responsiveness */
        @media (max-width: 768px) {
            nav ul {
                flex-direction: column;
                align-items: left;
            }

            nav ul li {
                margin: 10px 0;
            }
        }
    </style>
</head>

<nav>
    <ul>
        <li><a href="Home.aspx" class="<%= Request.Url.AbsolutePath.EndsWith("Home.aspx") ? "active" : "" %>">Home</a></li>
        <li><a href="Drinks.aspx" class="<%= Request.Url.AbsolutePath.EndsWith("Drinks.aspx") ? "active" : "" %>">Drinks</a></li>

        <asp:PlaceHolder ID="phAuthLinks" runat="server"></asp:PlaceHolder>
    </ul>
</nav>

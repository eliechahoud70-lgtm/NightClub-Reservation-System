<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Signup.aspx.cs" Inherits="nightclubReservation.Signup" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Signup - Swan Of Beirut</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', sans-serif;
        }

       body {
    background-image: url('https://media.istockphoto.com/id/1324561072/photo/party-people-enjoy-concert-at-festival-summer-music-festival.jpg?s=612x612&w=0&k=20&c=rT--yThoBJSdYFUb9nm-7oDvBZuhNE9LmB5uYmlxvSs=');
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    color: black;
}


        nav {
            background-color: black;
            padding: 15px;
            text-align: center;
        }

        nav ul {
            list-style: none;
            display: flex;
            justify-content: center;
        }

        nav ul li {
            margin: 0 20px;
        }

        nav ul li a {
            color: white;
            text-decoration: none;
            font-size: 18px;
            font-weight: bold;
        }

        nav ul li a:hover {
            color: fuchsia;
        }

        .form-container {
    margin: 100px auto;
    width: 600px;
    background: rgba(255, 255, 255, 0.85); /* semi-transparent white */
    border-radius: 20px;
    padding: 50px 40px;
    box-shadow: 0 0 25px rgba(0, 0, 0, 0.15);
    text-align: center;
}


        .form-container h2 {
            margin-bottom: 30px;
            font-size: 32px;
            color: black;
        }

        .input-box {
            width: 100%;
            padding: 15px;
            font-size: 16px;
            margin-bottom: 20px;
            border: 2px solid black;
            border-radius: 10px;
            color: black;
            background-color: #fff0fa;
        }

        .input-box::placeholder {
            color: #555;
        }

        .btn {
            width: 100%;
            padding: 14px;
            background-color: #ff006e;
            color: white;
            font-weight: bold;
            font-size: 18px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .btn:hover {
            background-color: black;
        }

        a {
            color: #ff006e;
            text-decoration: none;
            font-size: 14px;
        }

        a:hover {
            text-decoration: underline;
        }

        @media (max-width: 600px) {
            .form-container {
                width: 90%;
                padding: 40px 20px;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav>
        <ul>
            <li><a href="Home.aspx">Home</a></li>
            <li><a href="Login.aspx">Login</a></li>
            <li><a href="Signup.aspx">Signup</a></li>
        </ul>
    </nav>

    <form id="form1" runat="server">
        <div class="form-container">
            <h2>Create Your Account</h2>
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label><br /><br />

            <asp:TextBox ID="txtFullName" runat="server" Placeholder="Full Name" CssClass="input-box"></asp:TextBox><br />
            <asp:TextBox ID="txtEmail" runat="server" Placeholder="Email" CssClass="input-box"></asp:TextBox><br />
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Placeholder="Password" CssClass="input-box"></asp:TextBox><br />
            <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" Placeholder="Confirm Password" CssClass="input-box"></asp:TextBox><br />
            <asp:TextBox ID="txtPhone" runat="server" Placeholder="Phone Number (Optional)" CssClass="input-box"></asp:TextBox><br />

            <asp:Button ID="btnSignup" runat="server" Text="Sign Up" CssClass="btn" OnClick="btnSignup_Click" /><br /><br />
            <a href="Login.aspx">Already have an account? Login</a>
        </div>
    </form>
</body>
</html>

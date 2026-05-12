using System;
using System.Web;
using MySql.Data.MySqlClient;

namespace nightclubReservation
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // If user already logged in, redirect to Reservation or Dashboard
            if (Session["UserEmail"] != null)
            {
                Response.Redirect("Reservation.aspx");
                
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "Please enter both email and password.";
                return;
            }

            string connStr = "server=localhost;user id=root;password=Elie$$@Chahoud1;database=nightclubdb;";
             // Replace with actual MySQL connection string

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT * FROM users WHERE email = @Email AND password = @Password";
                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", password); // In production, use password hashing!

                    MySqlDataReader reader = cmd.ExecuteReader();

                    if (reader.HasRows)
                    {
                        Session["UserEmail"] = email;
                        Response.Redirect("Reservation.aspx");
                
                    }
                    else
                    {
                        lblMessage.Text = "Invalid email or password.";
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error connecting to database.";
                }
            }
        }
    }
}

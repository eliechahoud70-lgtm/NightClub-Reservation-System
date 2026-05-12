using System;
using MySql.Data.MySqlClient;

namespace nightclubReservation
{
    public partial class Signup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Nothing here for now
        }

        protected void btnSignup_Click(object sender, EventArgs e)
        {
            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();
            string phone = txtPhone.Text.Trim();

            if (password != confirmPassword)
            {
                lblMessage.Text = "Passwords do not match.";
                return;
            }

            if (string.IsNullOrEmpty(fullName) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "Please fill in all required fields.";
                return;
            }
            string connStr = "server=localhost;user id=root;password=Elie$$@Chahoud1;database=nightclubdb;";
            using (MySqlConnection conn = new MySqlConnection(connStr))

            {
                try
                {
                    conn.Open();

                    // Check if email already exists
                    string checkQuery = "SELECT COUNT(*) FROM users WHERE email = @Email";
                    MySqlCommand checkCmd = new MySqlCommand(checkQuery, conn);
                    checkCmd.Parameters.AddWithValue("@Email", email);
                    int count = Convert.ToInt32(checkCmd.ExecuteScalar());

                    if (count > 0)
                    {
                        lblMessage.Text = "Email already registered. Try logging in.";
                        return;
                    }

                    // Insert user
                    string insertQuery = "INSERT INTO users (fullname, email, password, phone) VALUES (@FullName, @Email, @Password, @Phone)";
                    MySqlCommand insertCmd = new MySqlCommand(insertQuery, conn);
                    insertCmd.Parameters.AddWithValue("@FullName", fullName);
                    insertCmd.Parameters.AddWithValue("@Email", email);
                    insertCmd.Parameters.AddWithValue("@Password", password); // Note: Use hashing in production!
                    insertCmd.Parameters.AddWithValue("@Phone", phone);

                    int result = insertCmd.ExecuteNonQuery();

                    if (result > 0)
                    {
                        Response.Redirect("Login.aspx");
                    }
                    else
                    {
                        lblMessage.Text = "Error occurred during signup. Please try again.";
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Database error. Try again later.";
                }
            }
        }
    }
}

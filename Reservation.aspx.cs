using System;
using System.Configuration;
using MySql.Data.MySqlClient;

namespace nightclubreservation
{
    public partial class Reservation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Ensure the user is logged in before accessing the reservation page
            if (Session["UserEmail"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            if (!IsPostBack)
            {
                LoadExistingReservation();
            }
        }

        protected void btnReserve_Click(object sender, EventArgs e)
        {
            try
            {
                string userEmail = Session["UserEmail"].ToString();
                string reservationDate = txtDate.Text;
                string reservationTime = txtTime.Text;
                string name = txtName.Text;
                string phone = txtPhone.Text;
                int tableSize = Convert.ToInt32(rblTableSize.SelectedValue);
                string eventType = rblEventType.SelectedValue;
                string specialRequests = txtRequest.Text;

                string connStr = "server=localhost;user id=root;password=Elie$$@Chahoud1;database=nightclubdb;";
                using (MySqlConnection conn = new MySqlConnection(connStr))
                {
                    conn.Open();

                    // 1. Check for existing reservation by same user at same date/time/table
                    string checkQuery = "SELECT COUNT(*) FROM Reservations WHERE UserEmail = @UserEmail AND ReservationDate = @Date AND ReservationTime = @Time AND TableSize = @TableSize";
                    using (MySqlCommand checkCmd = new MySqlCommand(checkQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@UserEmail", userEmail);
                        checkCmd.Parameters.AddWithValue("@Date", reservationDate);
                        checkCmd.Parameters.AddWithValue("@Time", reservationTime);
                        checkCmd.Parameters.AddWithValue("@TableSize", tableSize);

                        int existingCount = Convert.ToInt32(checkCmd.ExecuteScalar());
                        if (existingCount > 0)
                        {
                            lblMessage.ForeColor = System.Drawing.Color.Red;
                            lblMessage.Text = "You already have a reservation at this time and table size. Please choose a different time or table.";
                            return;
                        }
                    }

                    // 2. Insert new reservation
                    string insertQuery = "INSERT INTO Reservations (UserEmail, ReservationDate, ReservationTime, Name, Phone, TableSize, EventType, SpecialRequests) " +
                                         "VALUES (@UserEmail, @ReservationDate, @ReservationTime, @Name, @Phone, @TableSize, @EventType, @SpecialRequests)";
                    using (MySqlCommand cmd = new MySqlCommand(insertQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserEmail", userEmail);
                        cmd.Parameters.AddWithValue("@ReservationDate", reservationDate);
                        cmd.Parameters.AddWithValue("@ReservationTime", reservationTime);
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@Phone", phone);
                        cmd.Parameters.AddWithValue("@TableSize", tableSize);
                        cmd.Parameters.AddWithValue("@EventType", eventType);
                        cmd.Parameters.AddWithValue("@SpecialRequests", specialRequests);

                        cmd.ExecuteNonQuery();
                        // Populate reservation card details
                        lblResDate.Text = reservationDate;
                        lblResTime.Text = reservationTime;
                        lblResName.Text = name;
                        lblResPhone.Text = phone;
                        lblResTable.Text = tableSize.ToString();
                        lblResEvent.Text = eventType;
                        lblResRequest.Text = string.IsNullOrEmpty(specialRequests) ? "None" : specialRequests;
                        pnlReservationCard.Visible = true;

                    }
                }

                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Reservation submitted! You will receive confirmation shortly.";
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "An error occurred while processing your reservation. Please try again.";
            }
        }
        protected void btnCancelReservation_Click(object sender, EventArgs e)
        {
            try
            {
                string userEmail = Session["UserEmail"].ToString();
                string reservationDate = lblResDate.Text;
                string reservationTime = lblResTime.Text;

                string connStr = "server=localhost;user id=root;password=Elie$$@Chahoud1;database=nightclubdb;";
                using (MySqlConnection conn = new MySqlConnection(connStr))
                {
                    string query = "DELETE FROM Reservations WHERE UserEmail = @UserEmail AND ReservationDate = @ReservationDate AND ReservationTime = @ReservationTime";

                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserEmail", userEmail);
                        cmd.Parameters.AddWithValue("@ReservationDate", reservationDate);
                        cmd.Parameters.AddWithValue("@ReservationTime", reservationTime);

                        conn.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            lblMessage.ForeColor = System.Drawing.Color.OrangeRed;
                            lblMessage.Text = "Your reservation has been canceled.";
                            pnlReservationCard.Visible = false;
                        }
                        else
                        {
                            lblMessage.ForeColor = System.Drawing.Color.Red;
                            lblMessage.Text = "No reservation found to cancel.";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Error canceling reservation. Please try again.";
            }
        }
        private void LoadExistingReservation()
        {
            try
            {
                string userEmail = Session["UserEmail"].ToString();
                string connStr = "server=localhost;user id=root;password=Elie$$@Chahoud1;database=nightclubdb;";

                using (MySqlConnection conn = new MySqlConnection(connStr))
                {
                    string query = "SELECT * FROM Reservations WHERE UserEmail = @UserEmail LIMIT 1";
                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserEmail", userEmail);
                        conn.Open();
                        using (MySqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                // Populate labels with reservation data
                                lblResName.Text = reader["Name"].ToString();
                                lblResPhone.Text = reader["Phone"].ToString();
                                lblResDate.Text = Convert.ToDateTime(reader["ReservationDate"]).ToString("yyyy-MM-dd");
                                lblResTime.Text = reader["ReservationTime"].ToString();
                                lblResSize.Text = reader["TableSize"].ToString();
                                lblResEvent.Text = reader["EventType"].ToString();
                                lblResRequest.Text = reader["SpecialRequests"].ToString();

                                pnlReservationCard.Visible = true;
                            }
                            else
                            {
                                pnlReservationCard.Visible = false;
                            }
                        }
                    }
                }
            }
            catch (Exception)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Error loading your reservation.";
            }
        }


    }
}

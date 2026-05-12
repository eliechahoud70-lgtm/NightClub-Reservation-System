using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace nightclubreservation
{
    public partial class Navbar : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserEmail"] != null)
                {
                    // User is logged in – show Reservation + Logout
                    phAuthLinks.Controls.Add(new LiteralControl("<li><a href='Reservation.aspx'>Reservation</a></li>"));
           
                }
                else
                {
                    // Not logged in – show Login/Signup
                    phAuthLinks.Controls.Add(new LiteralControl("<li><a href='Login.aspx'>Login</a></li>"));
                    phAuthLinks.Controls.Add(new LiteralControl("<li><a href='Signup.aspx'>Signup</a></li>"));
                }
            }
        }
    }
}

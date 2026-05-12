using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

public partial class Drinks : System.Web.UI.Page
{
    // Drink model
    public class Drink
    {
        public string DrinkName { get; set; }
        public decimal GlassPrice { get; set; }
        public decimal BottlePrice { get; set; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindRepeaters();
        }
    }

    private void BindRepeaters()
    {
        // Normally you'd load from DB, but here are example drinks:
        List<Drink> whiskeyList = new List<Drink>
        {
            new Drink { DrinkName = "Jameson", GlassPrice = 8, BottlePrice = 60 },
            new Drink { DrinkName = "Jack Daniels", GlassPrice = 9, BottlePrice = 65 }
        };
        List<Drink> wineList = new List<Drink>
        {
            new Drink { DrinkName = "Merlot", GlassPrice = 7, BottlePrice = 40 },
            new Drink { DrinkName = "Chardonnay", GlassPrice = 7.5M, BottlePrice = 42 }
        };
        List<Drink> vodkaList = new List<Drink>
        {
            new Drink { DrinkName = "Absolut", GlassPrice = 8, BottlePrice = 50 },
            new Drink { DrinkName = "Grey Goose", GlassPrice = 10, BottlePrice = 70 }
        };
        List<Drink> cocktailList = new List<Drink>
        {
            new Drink { DrinkName = "Mojito", GlassPrice = 9 },
            new Drink { DrinkName = "Cosmopolitan", GlassPrice = 10 }
        };

        rptWhiskey.DataSource = whiskeyList;
        rptWhiskey.DataBind();

        rptWine.DataSource = wineList;
        rptWine.DataBind();

        rptVodka.DataSource = vodkaList;
        rptVodka.DataBind();

        rptCocktails.DataSource = cocktailList;
        rptCocktails.DataBind();
    }

    protected void btnOrder_Click(object sender, EventArgs e)
    {
        string userEmail = Session["user_email"]?.ToString(); // make sure user is logged in
        if (string.IsNullOrEmpty(userEmail))
        {
            Response.Write("<script>alert('Please log in to place an order.');</script>");
            return;
        }

        List<OrderItem> orders = new List<OrderItem>();
        orders.AddRange(GetSelectedOrders(rptWhiskey));
        orders.AddRange(GetSelectedOrders(rptWine));
        orders.AddRange(GetSelectedOrders(rptVodka));
        orders.AddRange(GetSelectedOrders(rptCocktails, isCocktail: true));

        if (orders.Count == 0)
        {
            Response.Write("<script>alert('Please select at least one drink.');</script>");
            return;
        }

        // Save to database
        string connStr = "server=localhost;user id=root;password=Elie$$@Chahoud1;database=nightclubdb;";
        using (MySqlConnection conn = new MySqlConnection(connStr))
        {
            conn.Open();

            foreach (var order in orders)
            {
                string query = @"INSERT INTO drink_orders 
                                (user_email, drink_name, drink_type, quantity, price_per_unit, total_price, order_date)
                                VALUES (@email, @name, @type, @qty, @unit, @total, NOW())";
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@email", userEmail);
                    cmd.Parameters.AddWithValue("@name", order.DrinkName);
                    cmd.Parameters.AddWithValue("@type", order.Type);
                    cmd.Parameters.AddWithValue("@qty", order.Quantity);
                    cmd.Parameters.AddWithValue("@unit", order.UnitPrice);
                    cmd.Parameters.AddWithValue("@total", order.TotalPrice);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        Response.Write("<script>alert('Order placed successfully!');</script>");
    }

    private List<OrderItem> GetSelectedOrders(Repeater repeater, bool isCocktail = false)
    {
        List<OrderItem> selectedOrders = new List<OrderItem>();

        foreach (RepeaterItem item in repeater.Items)
        {
            Label lblName = (Label)item.FindControl("DrinkName") ?? null;
            string drinkName = lblName?.Text ?? "";

            RadioButton rdoGlass = (RadioButton)item.FindControl("rdoGlass");
            RadioButton rdoBottle = (RadioButton)item.FindControl("rdoBottle");

            string qtyName = "qty_" + drinkName;
            string qtyValue = Request.Form[qtyName];

            if (int.TryParse(qtyValue, out int quantity) && quantity > 0)
            {
                string type = rdoBottle != null && rdoBottle.Checked ? "Bottle" : "Glass";
                decimal price = 0;

                if (type == "Glass")
                    price = ExtractPriceFromText(rdoGlass.Text);
                else if (rdoBottle != null)
                    price = ExtractPriceFromText(rdoBottle.Text);

                selectedOrders.Add(new OrderItem
                {
                    DrinkName = drinkName,
                    Type = type,
                    Quantity = quantity,
                    UnitPrice = price,
                    TotalPrice = quantity * price
                });
            }
        }

        return selectedOrders;
    }

    private decimal ExtractPriceFromText(string text)
    {
        // Ex: "Glass ($9)" → 9
        int start = text.IndexOf("($") + 2;
        int end = text.IndexOf(")", start);
        string priceStr = text.Substring(start, end - start);
        decimal.TryParse(priceStr, out decimal price);
        return price;
    }

    // Order DTO
    public class OrderItem
    {
        public string DrinkName { get; set; }
        public string Type { get; set; } // Glass or Bottle
        public int Quantity { get; set; }
        public decimal UnitPrice { get; set; }
        public decimal TotalPrice { get; set; }
    }
}

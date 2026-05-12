<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Drinks.aspx.cs" Inherits="Drinks" %>
<%@ Register Src="~/Navbar.ascx" TagPrefix="uc" TagName="Navbar" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Drinks Menu</title>
    <style>
        body {
            background-color: #121212;
            color: #f0f0f0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 20px;
        }

        h2 {
            color: #ff4081;
            border-bottom: 1px solid #333;
            padding-bottom: 10px;
            
         
        }
        .drink-row h2 {
            width: 500px;
            font-weight: bold;
            
        }

        .drink-category {
            margin-bottom: 40px;
            background-color: #1e1e1e;           
            padding: 20px;
            box-shadow: 0 0 10px #00000080;
        }

        .drink-row {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .drink-row label {
            width: 335px;
            font-weight: bold;
        }

        input[type="number"] {
            width: 60px;
            padding: 5px;
            margin-left: 10px;
            border: none;
            border-radius: 5px;
            background-color: #2c2c2c;
            color: white;
        }

        .price-input:focus {
            outline: 2px solid #ff4081;
        }

        .drink-row input[type="radio"] {
            margin: 0 5px;
        }

        .total-box {
            font-size: 18px;
            font-weight: bold;
            margin-top: 30px;
            padding: 10px;
            background-color: #1e1e1e;
            border-radius: 10px;
            text-align: right;
            color: #00e676;
        }

        .aspNetDisabled {
            color: #aaa;
        }

        #btnOrder {
            margin-top: 20px;
            background-color: #ff4081;
            color: white;
            border: none;
            padding: 10px 25px;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
        }

        #btnOrder:hover {
            background-color: #e73370;
        }
    </style>
    <script>
        function calculateTotal() {
            let total = 0;
            document.querySelectorAll(".price-input").forEach(row => {
                const price = parseFloat(row.dataset.price);
                const qty = parseInt(row.value) || 0;
                total += price * qty;
            });
            document.getElementById("totalPrice").innerText = "$" + total.toFixed(2);
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">

        <!-- Whiskey Section -->
    
        <div class="drink-row"> 
          <h2>Whiskey</h2>
          <h2>🥃</h2>
          <h2>Bottle</h2>
          <h2>Quantity</h2>
         </div>
        <div class="drink-category">
            <asp:Repeater ID="rptWhiskey" runat="server">
               
  
        <ItemTemplate>
            <div class="drink-row">
                <label><%# Eval("DrinkName") %></label>
                <asp:RadioButton ID="rdoGlass" runat="server" GroupName='<%# Eval("DrinkName") %>' Text='<%# "Glass ($" + Eval("GlassPrice") + ")" %>' />
                <asp:RadioButton ID="rdoBottle" runat="server" GroupName='<%# Eval("DrinkName") %>' Text='<%# "Bottle ($" + Eval("BottlePrice") + ")" %>' />
                Qty:
               <input type="number" name="qty_<%# Eval("DrinkName") %>" min="0"
                  class="price-input"
                  data-price='<%# Eval("GlassPrice") %>'
                  onchange="calculateTotal()" />

            </div>
        </ItemTemplate>
    </asp:Repeater>
</div>
         

        <!-- Wine Section -->
        
           <div class="drink-row"> 
                 <h2>Wine</h2>
                 <h2>🍷</h2>
                 <h2>Bottle</h2>
                 <h2>Quantity</h2>
           </div>
       
        <div class="drink-category">
            <asp:Repeater ID="rptWine" runat="server">
                <ItemTemplate>
                    <div class="drink-row">
                        <label><%# Eval("DrinkName") %></label>
                        <asp:RadioButton ID="rdoGlass" runat="server" GroupName='<%# Eval("DrinkName") %>' Text='<%# "Glass ($" + Eval("GlassPrice") + ")" %>' />
                        <asp:RadioButton ID="rdoBottle" runat="server" GroupName='<%# Eval("DrinkName") %>' Text='<%# "Bottle ($" + Eval("BottlePrice") + ")" %>' />
                        Qty:
                       <input type="number" name="qty_<%# Eval("DrinkName") %>" min="0"
                          class="price-input"
                          data-price='<%# Eval("GlassPrice") %>'
                          onchange="calculateTotal()" />

                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <!-- Vodka Section -->
       
    <div class="drink-row"> 
          <h2>Vodka</h2>
          <h2>🍸</h2>
          <h2>Bottle</h2>
          <h2>Quantity</h2>
    </div>

        <div class="drink-category">
            <asp:Repeater ID="rptVodka" runat="server">
                        <ItemTemplate>
            <div class="drink-row">
                <label><%# Eval("DrinkName") %></label>
                <asp:RadioButton ID="rdoGlass" runat="server" GroupName='<%# Eval("DrinkName") %>' Text='<%# "Glass ($" + Eval("GlassPrice") + ")" %>' />
                <asp:RadioButton ID="rdoBottle" runat="server" GroupName='<%# Eval("DrinkName") %>' Text='<%# "Bottle ($" + Eval("BottlePrice") + ")" %>' />
                Qty:
               <input type="number" name="qty_<%# Eval("DrinkName") %>" min="0"
                  class="price-input"
                  data-price='<%# Eval("GlassPrice") %>'
                  onchange="calculateTotal()" />

            </div>
        </ItemTemplate>
    </asp:Repeater>
</div>

        <!-- Cocktails Section -->
        
               
                    <div class="drink-row"> 
                       <h2>Cocktails</h2>
                       <h2>🍹</h2>
                    </div>
              
        <div class="drink-category">
            <asp:Repeater ID="rptCocktails" runat="server">
                <ItemTemplate>
                  <div class="drink-row">
    <label><%# Eval("DrinkName") %></label>
    <asp:RadioButton ID="rdoGlass" runat="server" GroupName='<%# Eval("DrinkName") %>' Text='<%# "Glass ($" + Eval("GlassPrice") + ")" %>' />
    
    Qty:
   <input type="number" name="qty_<%# Eval("DrinkName") %>" min="0"
      class="price-input"
      data-price='<%# Eval("GlassPrice") %>'
      onchange="calculateTotal()" />

</div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <!-- Total & Submit -->
        <div class="total-box">Total: <span id="totalPrice">$0.00</span></div>
        <asp:Button ID="btnOrder" runat="server" Text="Place Order" OnClick="btnOrder_Click" />
    </form>
</body>
</html>

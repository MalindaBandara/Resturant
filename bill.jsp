<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<title>Order Summary</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="w3.css">
<link rel="stylesheet" href="JosefinSans-Regular.ttf">
<link rel="stylesheet" href="AmaticSC-Regular.ttf">
<style>
body, html {height: 100%}
@font-face {
font-family: "JosefinSans";
src: url("JosefinSans-Regular.ttf");
}
body,h1,h2,h3,h4,h5,h6 {font-family: 'AmaticSC', sans-serif}
.menu {display: none}
@font-face {
font-family: "AmaticSC";
src: url("AmaticSC-Regular.ttf");
}
.bgimg {
    background-repeat: no-repeat;
    background-size: cover;
    background-image: url("pizza.jpg");
    min-height: 90%;
}
</style>
<body>
<!-- Navbar (sit on top) -->
<div class="w3-top w3-hide-small">
  <div class="w3-bar w3-xlarge w3-black w3-opacity w3-hover-opacity-off" id="myNavbar">
    <a href="index.html" class="w3-bar-item w3-button">HOME</a>
    <a href="menu.jsp" class="w3-bar-item w3-button">MENU</a>
    <a href="about.html" class="w3-bar-item w3-button">ABOUT</a>
    <a href="feedback.html" class="w3-bar-item w3-button">CONTACT</a>
    <a href="gallery.jsp" class="w3-bar-item w3-button">GALLERY</a>
  </div>
</div>
  
<div class="w3-container w3-padding-64 w3-dark-grey w3-grayscale-min w3-xlarge">
  <div class="w3-content">
      <h1 class="w3-center w3-jumbo" style="margin-bottom:64px">Your order has been placed</h1>
      <p style='text-align:center;' class="w3-xxlarge">Below are the order details..</p> 
     
<h3 class="w3-xxlarge" style="font-family:JosefinSans">Order Placed By</h3>
        <%
            String ID="";
            if (session.getAttribute("o_id") != null) {
               ID = session.getAttribute("o_id").toString();
            }
            else{
                //response.sendRedirect("");
            }
            
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "");

            try {

                ResultSet r = con.createStatement().executeQuery("select * from `order` where o_id="+ID+"");

                while (r.next()) {
                    //   String name = r.getString("cst_name");
                    // String phone = r.getString("cst_no");
                    //String email = r.getString("cst_email");
                    //String date = r.getString("date");
%>
        <table style="font-family:JosefinSans" border="0" cellspacing="20" cellpadding="10">
            <tr><td> Name:</td><td><%=r.getString("cst_name")%></td></tr>
            <tr><td> Phone:</td><td><%=r.getString("cst_no")%></td></tr>
            <tr><td> Email:</td><td><%=r.getString("cst_email")%></td></tr>
            <tr><td> Date:</td><td><%=r.getString("date")%></td></tr>
        </table>
        <%
                }

            } catch (Exception e) {
                out.println(e.getMessage());
            }
        %>
<br/>
        <table  style="font-family:JosefinSans" border="0" cellspacing="20" cellpadding="10"><h3 class="w3-xxlarge" style="font-family:JosefinSans">Bill Summary</h3>
            <tr><b><td><b>Food</b></td><td><b>Food Type</b></td><td><b>Unit Price</b></td><td><b>Quantity</b></td><td><b>Price</b></td></b></tr>

            <%
                double sum = 0;
                try {
                //  ResultSet r1 = con.createStatement().executeQuery("SELECT i.*,ohi.* FROM item i,order_has_item ohi WHERE i.i_id=ohi.i_id AND ohi.o_id=" + 1 + "");
                 
                      ResultSet r1 = con.createStatement().executeQuery("select * from item,`order_has_item` where item.i_id=`order_has_item`.i_id and `order_has_item`.o_id=" + ID + ""  );
                 
                    ;
                    while (r1.next()) {
                        double uprice = Double.parseDouble(r1.getString("price"));
                        int quanty = Integer.parseInt(r1.getString("qty"));
                        double total = 0;
                        total += (uprice * quanty);
                        sum += (uprice * quanty);
            %>
            <tr><td><%=r1.getString("name")%></td><td><%=r1.getString("type")%></td><td><%=r1.getString("price")%></td><td><%=r1.getString("qty")%></td>
                <td><%=total%></td> </tr>
            



            <%}%>

            <tr> <td><h3 style="font-family:JosefinSans" class="w3-xxlarge"><b>Total :</b><h3></td><td style="font-family:JosefinSans" class="w3-xxlarge" colspan="4" style="text-align:right; font:red;font-size: 20px;"><b><%=sum%></b></td></tr></table>
            <div style="float:right"><h1><a href="index.html">Go Back Home</a></h1></div>
        <%
                session.invalidate();
            } catch (Exception e) {
                out.println(e.getMessage());
               }%>
</div>
</div>
    </body>
</html>

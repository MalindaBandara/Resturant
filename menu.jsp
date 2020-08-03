<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<title>Our Menu</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="w3.css">
<style>
body, html {height: 100%}
@font-face {
font-family: "AmaticSC";
src: url("AmaticSC-Regular.ttf");
}
@font-face {
font-family: "JosefinSans";
src: url("JosefinSans-Regular.ttf");
}
body,h1,h2,h3,h4,h5,h6 {font-family: 'AmaticSC', sans-serif}
.menu {display: none}
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

<!-- Menu Container -->
<div class="w3-container w3-black w3-padding-64 w3-xxlarge" id="menu">
  <div class="w3-content">
  
    <h1 class="w3-center w3-jumbo" style="margin-bottom:64px">THE MENU</h1>
    <div class="w3-row w3-center w3-border w3-border-dark-grey">
      <a href="javascript:void(0)" onclick="openMenu(event, 'Pizza');" id="myLink">
        <div class="w3-col s4 tablink w3-black w3-padding-large w3-hover-red">Rice</div>
      </a>
      <a href="javascript:void(0)" onclick="openMenu(event, 'Pasta');">
        <div class="w3-col s4 tablink w3-black w3-padding-large w3-hover-red">Soup</div>
      </a>
      <a href="javascript:void(0)" onclick="openMenu(event, 'Starter');">
        <div class="w3-col s4 tablink w3-black w3-padding-large w3-hover-red">Short Eats</div>
      </a>
    </div>
    
        <%
            try {

                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "");
                Statement stm = con.createStatement();
                String que1 = "SELECT * from item where type='Rice'";
                ResultSet res1 = stm.executeQuery(que1);

        %>
        <form action="setorder.jsp" method="POST">
        <div id="Pizza" class="w3-container menu w3-padding-32 w3-white">
                <%                    while (res1.next()) {
                        String name = res1.getString("name");
                        String i_id = res1.getString("i_id");
                        String type = res1.getString("type");
                        String price = res1.getString("price");
                %>
                <h1 style="font-family:JosefinSans"><b><%=name%></b> <span class="w3-right w3-tag w3-dark-grey w3-round">Rs.<%=price%></span></h1>
                <p style="font-family:JosefinSans"><span class="w3-text-grey">Amount <input type="text" name="<%=i_id%>"/></span></p>
      <hr>
                <%}%>
                </div>
<div id="Pasta" class="w3-container menu w3-padding-32 w3-white">
                <%
                    Statement stm2 = con.createStatement();
                    String que2 = "SELECT * from item where type='Soup'";
                    ResultSet res2 = stm2.executeQuery(que2);
                    while (res2.next()) {
                        String name = res2.getString("name");
                        String type = res2.getString("type");
                        String price = res2.getString("price");
                        String i_id = res2.getString("i_id");
                %>
      <h1 style="font-family:JosefinSans"><b><%=name%></b> <span class="w3-right w3-tag w3-dark-grey w3-round">Rs.<%=price%></span></h1>
                <p style="font-family:JosefinSans"><span class="w3-text-grey">Amount<input type="text" name="<%=i_id%>"/></span></p>
      <hr>
    <% }%>
</div>
<div id="Starter" class="w3-container menu w3-padding-32 w3-white">
                <%
                    Statement stm3 = con.createStatement();
                    String que3 = "SELECT * from item where type='Short Eats'";
                    ResultSet res3 = stm3.executeQuery(que3);
                    while (res3.next()) {
                        String name = res3.getString("name");
                        String type = res3.getString("type");
                        String price = res3.getString("price");
                        String i_id = res3.getString("i_id");
                %>
                
                  <h1 style="font-family:JosefinSans"><b><%=name%></b> <span class="w3-right w3-tag w3-dark-grey w3-round">Rs.<%=price%></span></h1>
                <p style="font-family:JosefinSans"><span class="w3-text-grey">Amount <input type="text" name="<%=i_id%>" value=""/></span></p>
        <hr>
        <%}%>
        </div>            
        <p><input type="submit" value="Place Order"  style="display:block;margin:auto;"/></p>
        </form>
            






        <%

            } catch (Exception ex) {
                out.print(ex);

            }


        %>
    <!-- Footer -->
<footer class="w3-center w3-black w3-padding-48 w3-xxlarge">
</footer>


<script>
// Tabbed Menu
function openMenu(evt, menuName) {
  var i, x, tablinks;
  x = document.getElementsByClassName("menu");
  for (i = 0; i < x.length; i++) {
     x[i].style.display = "none";
  }
  tablinks = document.getElementsByClassName("tablink");
  for (i = 0; i < x.length; i++) {
     tablinks[i].className = tablinks[i].className.replace(" w3-red", "");
  }
  document.getElementById(menuName).style.display = "block";
  evt.currentTarget.firstElementChild.className += " w3-red";
}
document.getElementById("myLink").click();
</script>
</body>
</html>
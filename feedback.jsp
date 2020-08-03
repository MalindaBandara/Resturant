<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<title>Thank You!</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="w3.css">
<link rel="stylesheet" href="AmaticSC-Regular.ttf">
<style>
body, html {height: 100%}
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
<body bgcolor="black">
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
  
<div class="w3-container w3-padding-64 w3-blue-grey w3-grayscale-min w3-xlarge">
  <div class="w3-content">
        
        
        <%
            
            String name = request.getParameter("Person");
            String email = request.getParameter("emailaddress");
            String rating = request.getParameter("rating");
            String message = request.getParameter("suggestions");
            String number = request.getParameter("number");
            
            
            
            try {

                
                
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "");
                Statement stm = con.createStatement();
                String que1 = "INSERT INTO feedback (name,number,email,message,rating) VALUES('"+name+"','"+number+"','"+email+"','"+message+"','"+rating+"')";
                int res1 = stm.executeUpdate(que1);
                
                if(res1 > 0){
                out.println("<h1 class='w3-center w3-jumbo' style='margin-bottom:64px'>Thank You for your feedback!");
                out.print("<p style='text-align:center;' class='w3-xxlarge'><a href='index.html'>Go Back</a></p> ");
                }

            }catch(Exception e){
                        
                        out.println("<p>ERROR"+e.getMessage()+"</p>");
                        }


        %></div>
</div>
<!-- Footer -->
<footer class="w3-center w3-black w3-padding-48 w3-xxlarge">
  
</footer>

        
    </body>
</html>

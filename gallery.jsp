<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<title>Gallery</title>
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
      <h1 class="w3-center w3-jumbo" style="margin-bottom:64px;">Our Gallery</h1>
        <table border="0" width="100%">
      <%
                      try {
                           
                    Class.forName("com.mysql.jdbc.Driver");
                    
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant","root","");
                    Statement stmt = con.createStatement();
                    
                        String query="SELECT * FROM image";
                        ResultSet rs=stmt.executeQuery(query);
                        int size = 0;
                        try {
                            rs.last();
                            size = rs.getRow();
                            rs.beforeFirst();
                        }
                        catch(Exception ex) {
                            
                        }
                         out.print("<table>");
                            for(int i=0;i<size/3;i++){
                                out.print("<tr>");
                                for(int j=0;j<3;j++){
                                    rs.next();
                                    out.print("<td width='45%' style='text-align:center'><img src='"+rs.getString("path")+"' width='200' height='200'><h1>"+rs.getString("name")+"</h1></td>");
                                }
                                out.print("</tr>");
                            }  
                            out.print("</table>");
                    }
                 catch (ClassNotFoundException e) {
                    e.printStackTrace();
                }   
      %>
        </table>
        </div>
    </div>
</body>
</html>

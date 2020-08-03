<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
HttpSession existingSession = request.getSession(false);
if (existingSession != null && existingSession.getAttribute("un") != null){
        //already logged in
         String site = new String("panel.jsp");
         response.setStatus(response.SC_MOVED_TEMPORARILY);
         response.setHeader("Location", site); 
}    
    
String driverName = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String dbName = "restaurant";
String userId = "root";
String password = "";
boolean error=false;
try {
Class.forName(driverName);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}

Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>

<!DOCTYPE html>
<html>
<title>Staff Login</title>
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
@font-face {
font-family: "JosefinSans";
src: url("JosefinSans-Regular.ttf");
}
.bgimg {
    background-repeat: no-repeat;
    background-size: cover;
    background-image: url("pizza.jpg");
    min-height: 90%;
}
</style>
<body>
<% 
if((request.getParameter("un") == null)?false:true){
    // process login
    connection = DriverManager.getConnection(connectionUrl + dbName, userId, password);
    String sql = "SELECT * FROM login WHERE un=? AND pwd=SHA(?) LIMIT 1";
    PreparedStatement pstmt= connection.prepareStatement(sql);
    pstmt.setString(1,request.getParameter("un"));
    pstmt.setString(2,request.getParameter("pwd"));
    resultSet = pstmt.executeQuery();
    if(!resultSet.next()){
        //invalid credentials
        error=true;
        
    } else if (session.getAttribute("un") == null || session.getAttribute("un").equals("")){
        //valid login with no session set
        session.setAttribute("un",(String)resultSet.getString("un"));
        out.println("Session set for"+session.getAttribute("un"));
        // New location to be redirected
         String site = new String("panel.jsp");
         response.setStatus(response.SC_MOVED_TEMPORARILY);
         response.setHeader("Location", site); 
    }
    else{
        //seesion exists redirect to home page
        String site = new String("panel.jsp");
         response.setStatus(response.SC_MOVED_TEMPORARILY);
         response.setHeader("Location", site); 
    }
}
else{
    if (session.getAttribute("un") == null || session.getAttribute("un").equals("")){
        //freshly loaded page
    }
    else{
        //already logged redirect
        out.println("Session set for"+session.getAttribute("un"));
    }
}
%>    
<div class="w3-container w3-padding-64 w3-black w3-grayscale-min w3-xlarge">
  <div class="w3-content">
    <h1 class="w3-center w3-jumbo" style="margin-bottom:64px">Staff Login</h1>
    <form action="<%=request.getRequestURI()%>" method="post" style="font-family:JosefinSans">
      <p><input class="w3-input w3-padding-8 w3-border" style="width:40%;display:block;margin:auto;" type="text" name="un" placeholder="Name" required name="Name"></p>
      <p><input class="w3-input w3-padding-8 w3-border" style="width:40%;display:block;margin:auto;" type="password" name="pwd" placeholder="Password" required name="Password"></p>
      <p><button class="w3-button w3-dark-grey w3-block" style="width:40%;display:block;margin:auto;" type="submit">LOGIN</button></p>
      <span class="w3-block" id="error" style="color:red;text-align:center;"><%=(error)?"<h1>Invalid Login!</h1>":"<h1></h1>"%></span>
    </form>
  </div>
</div>
<!-- Footer -->
<footer class="w3-center w3-black w3-padding-48 w3-xxlarge">
    Got here by mistake? <a href="index.html">Go back to our site here</a>
</footer>
</body>
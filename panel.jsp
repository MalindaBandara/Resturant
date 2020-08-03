<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%
HttpSession existingSession = request.getSession(false);
if (existingSession == null|| (existingSession.getAttribute("un")==null)){
         String site = new String("login.jsp");
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
%>
<!DOCTYPE html>
<html>
<title>Staff Panel</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="w3.css">
<style>
body, html {height: 100%;font-family:sans-serif;}
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
    background-image: url("cover.jpg");
    min-height: 90%;
}
</style>
<body bgcolor="black">
<!-- Navbar-->
<div class="w3-top w3-hide-small">
  <div class="w3-bar w3-xlarge w3-black w3-opacity w3-hover-opacity-off" id="myNavbar">
    <a href="logout.jsp" class="w3-bar-item w3-button w3-right">Logout</a>
    <a href="" class="w3-bar-item w3-button">Logged in as &nbsp;<b><u><%=existingSession.getAttribute("un")%></b></u></a>
  </div>
</div>
<div class="w3-container w3-padding-64 w3-dark-grey w3-grayscale-min w3-xlarge">
        <h1 class="w3-center w3-jumbo" style="margin-bottom:64px">Orders</h1>
    <div id="dates" class="w3-content" style="font-family:JosefinSans">
    <%  
        Calendar cal = new GregorianCalendar();
        int i=0;
        String date="";
        String dateFormatter;
        out.print("<p style='text-align:center;'>Select Date : ");
        out.print("<select  style='display:block;margin:auto;' id='sel_count' name='apt_date' onchange='loadToday();'>");
        while(i<4){
            //if( cal.get( Calendar.DAY_OF_WEEK ) == channelDay() ){
                date=cal.getTime().toString();
                SimpleDateFormat format1 = new SimpleDateFormat("YYYY-MM-dd");
                String formatted = format1.format(cal.getTime());
                dateFormatter=date.substring(0, 10)+", "+date.substring(24, 28);
                out.print("<option value='"+formatted+"'>"+dateFormatter+"</option>");
                i++;
            //}
            cal.add(Calendar.DATE,1);
        }
        out.print("</select></p>");    
    %>
    </div>
    <div id="container" class="w3-content">
        
    </div>
</div>
<!-- Footer -->
<footer class="w3-center w3-black w3-padding-48 w3-xxlarge">
  
</footer>
<script>
    loadToday();
    function loadToday() {
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
                document.getElementById("container").innerHTML =this.responseText;
            }
        };
        
        var e = document.getElementById("sel_count");
        var strUser = e.options[e.selectedIndex].value;
  xhttp.open("POST", "getorderbydate.jsp", true);
  xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
  xhttp.send("date="+strUser);
}
</script>    
</body>
</html>

<%-- 
    Document   : order
    Created on : Nov 13, 2017, 7:04:27 AM
    Author     : Nushka
--%>

<%@page import="java.util.Enumeration"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ABC Restaurant management</title>
    </head>
    <body>
        <%
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String contactno  = request.getParameter("contactno");
            String email = request.getParameter("email");
            String date = request.getParameter("date");
            
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "");
                Statement stmt = con.createStatement();
                String query = "INSERT INTO `order` VALUES (NULL,'"+name+"','"+address+"','"+contactno+"','"+email+"','"+date+"')";
                int a = stmt.executeUpdate(query, Statement.RETURN_GENERATED_KEYS);
                ResultSet rs = stmt.getGeneratedKeys(); //get newly added id
                int lastId=0;
                    if (rs.next()){
                        lastId=rs.getInt(1);
                    }
                
                Enumeration keys = session.getAttributeNames();
                    while (keys.hasMoreElements()) //loop through items in sessions
                    {
                      String key = (String)keys.nextElement();
                      out.println(key + ":" + session.getValue(key).toString().trim() + "k<br>");
                      stmt = con.createStatement();
                      query="INSERT INTO `order_has_item` VALUES ("+lastId+","+key+","+session.getValue(key)+")"; 
                      a = stmt.executeUpdate(query);
                    }
                session.setAttribute("o_id",lastId);
                out.print(session.getAttribute("o_id"));
                
            } catch (Exception e) {
               out.println("<p> ERROR: " + e.getMessage() + "</p>");
            }
            response.sendRedirect("bill.jsp");
            %>
    </body>
</html>

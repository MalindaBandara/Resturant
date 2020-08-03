<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.*"%>
<%
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
    ResultSet rs = null;
    connection = DriverManager.getConnection(connectionUrl + dbName, userId, password);
    statement = connection.createStatement();
    String sql = "SELECT o_id,cst_name,cst_ad,cst_no FROM `order` WHERE o_id IN(SELECT o_id FROM order_has_item) AND date='"+request.getParameter("date")+"'";
    rs = statement.executeQuery(sql);
    List<String> o_id=new ArrayList<String>();
    List<String> o_name=new ArrayList<String>();
    List<String> o_ad=new ArrayList<String>();
    List<String> o_no=new ArrayList<String>();
    
    if (!rs.isBeforeFirst() ) {    
       out.print("<table border='1' width='100%' class='w3-table'><tr><td colspan='2' align='center'>There are no orders on this day</td></tr></table>");
       return;
    }
    
        while(rs.next()){
            o_id.add(rs.getString("o_id"));
            o_name.add(rs.getString("cst_name"));
            o_ad.add(rs.getString("cst_ad"));
            o_no.add(rs.getString("cst_no"));
        }
     String[] id=o_id.toArray(new String[0]);
     String[] name=o_name.toArray(new String[0]);
     String[] ad=o_ad.toArray(new String[0]);
     String[] no=o_no.toArray(new String[0]);
     
     for(int i=0;i<id.length;i++){ 
        connection = DriverManager.getConnection(connectionUrl + dbName, userId, password);
        statement = connection.createStatement();    
        String subq="SELECT i.name,ohs.qty FROM item i,order_has_item ohs WHERE ohs.o_id="+id[i]+" AND i.i_id=ohs.i_id";
            out.print("<table border='1' width='100%' class='w3-table'><tr><td style='width:60%;font-family:JosefinSans'>"+name[i]);
            out.print("<br/>Address : "+ad[i]);
            out.print("<br/>Contact : "+no[i]);
            out.print("</td><td><table class='w3-table' style='font-family:JosefinSans'>");
            ResultSet rs2=statement.executeQuery(subq);
                while(rs2.next()){
                    out.print("<tr><td style='width:80'>"+rs2.getString("name")+"</td><td style='width:80'>"+rs2.getString("qty")+"</td></tr>");
                }
            out.print("</table></td></tr></table>");
    }
    %>

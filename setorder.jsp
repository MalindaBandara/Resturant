<%@page import="com.mysql.jdbc.StringUtils"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Map.Entry"%>

<%
for (Entry<String, String[]> entry : request.getParameterMap().entrySet()) {
    String name = entry.getKey();
    String value = entry.getValue()[0];
    if(!"".equals(value.trim())){
        session.setAttribute(name, value);
    }
}
out.print("Order Set.You will soon be redirected..");
response.sendRedirect("order.html");
%>

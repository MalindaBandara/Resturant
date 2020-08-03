<% 
     String site = new String("login.jsp");
     session.invalidate();
     request.getSession(false);
     response.setStatus(response.SC_MOVED_TEMPORARILY);
     response.setHeader("Location", site);     
%>
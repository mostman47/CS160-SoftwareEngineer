<%-- 
    Document   : account2
    Created on : Dec 15, 2013, 3:56:17 PM
    Author     : nam
--%>

<%@page import="Controller.Controller"%>
<%@page import="DataOOD.User"%>
<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        
        if(request.getParameter("buyMore")!=null)
        {
                User user = Controller.getLoginUser();

            user.setPoint(user.getPoint()+100);
            Controller.updateUser(user);
        }
        String strViewPage = "account.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(strViewPage);
        if (dispatcher != null) {
            dispatcher.forward(request, response);
        }
    }
%>

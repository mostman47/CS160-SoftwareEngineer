<%-- 
    Document   : controller
    Created on : Dec 8, 2013, 5:17:44 PM
    Author     : mr.nam
        
        The link between the database and webpage. Is the controller leg of the MVC design pattern.
--%>

<%@page import="Miscellanea.EnumString"%>
<%@page import="Controller.Controller"%>
<%@page import="DataOOD.User"%>
<%
    //check user login
    User u = Controller.getLoginUser();
    String usernameLogin = "N/A";
    if (u != null) {
        usernameLogin = u.getName();
    } else {
        String strViewPage = "index.jsp";
        session.invalidate();
        session = request.getSession();
        RequestDispatcher dispatcher = request.getRequestDispatcher(strViewPage);
        if (dispatcher != null) {
            dispatcher.forward(request, response);
        }
    }

    if (request.getParameter("logout") != null) {
        Controller.logOut(u.getName());
        String strViewPage = "index.jsp";
        session.invalidate();
        session = request.getSession();
        RequestDispatcher dispatcher = request.getRequestDispatcher(strViewPage);
        if (dispatcher != null) {
            dispatcher.forward(request, response);
        }
    }
    String uri = request.getRequestURI();
    String pageName = uri.substring(uri.lastIndexOf("/") + 1);

    if (pageName.equalsIgnoreCase("enterToken.jsp")) {//branded selection
        
    } else if (pageName.equalsIgnoreCase("selectpacket.jsp")) {//normal selection

    }
%>

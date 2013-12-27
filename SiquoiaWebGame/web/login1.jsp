<%-- 
    Document   : login1
    Created on : Dec 4, 2013, 11:28:30 PM
    Author     : mr.nam
        
        Code to check for errors (exception handling) upon signing in on index.jsp
--%>

<%@page import="Controller.Controller"%>
<%
    String strViewPage = "index.jsp";
//initial
    session.setAttribute("error", null);
    //
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        if (request.getParameter("forward") != null) {
            strViewPage = request.getParameter("forward");
            session.invalidate();
            session = request.getSession();
        } else {
            session.setAttribute("username_error", null);
            session.setAttribute("password_error", null);
            session.setAttribute("error", null);
            //
            if (request.getParameter("login") != null) {
                boolean checkInput = true;
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                //check null
                if (username == null || username.isEmpty()) {
                    session.setAttribute("username_error", " Please enter a username.");
                    checkInput = false;
                }
                if (password == null || password.isEmpty()) {
                    session.setAttribute("password_error", " Please enter a password.");
                    checkInput = false;
                }
                //if both not null
                if (checkInput) {
                    {
                        //check user
                        if (!Controller.isLogin(username, password, 11)) {
                            session.setAttribute("error", "Username or password is incorrect!");
                        } else {
                            //session.setAttribute("error", "Username and password are correct!");
                            strViewPage = "account.jsp";
                            session.invalidate();
                            session = request.getSession();
                        }
                    }

                }
            }
        }
    }
%>
<%
    RequestDispatcher dispatcher = request.getRequestDispatcher(strViewPage);
    if (dispatcher != null) {
        dispatcher.forward(request, response);
    }
%>


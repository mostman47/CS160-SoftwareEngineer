<%-- 
    Document   : signup1
    Created on : Dec 5, 2013, 9:57:49 PM
    Author     : mr.nam
	
	Registration page for new users to enter account information and set login credentials.
--%>

<%@page import="Controller.Controller"%>
<%
    String strViewPage = "signup.jsp";

    session.setAttribute("username_error", null);
    session.setAttribute("password_error", null);
    session.setAttribute("re-password_error", null);
    session.setAttribute("email_error", null);
    session.setAttribute("error", null);
    //
    if (request.getParameter("create") != null) {
        boolean checkInput = true;
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String repassword = request.getParameter("re-password");
        String email = request.getParameter("email");
        //check null
        if (username == null || username.isEmpty()) {
            session.setAttribute("username_error", " cannot be blank!");
            checkInput = false;
        }
        if (password == null || password.isEmpty()) {
            session.setAttribute("password_error", " cannot be blank!");
            checkInput = false;
        }
        if (repassword == null || repassword.isEmpty()) {
            session.setAttribute("re-password_error", " cannot be blank!");
            checkInput = false;
        }
        if (email == null || email.isEmpty()) {
            session.setAttribute("email_error", " cannot be blank!");
            checkInput = false;
        }
        if (password != null && !password.isEmpty()
                && repassword != null && !repassword.isEmpty()) // 2 passwords are not the same
        {
            if (!password.equals(repassword)) {
                session.setAttribute("password_error", " re-password is different");
                session.setAttribute("re-password_error", " re-password is different");
                checkInput = false;
            }
        }
        //if both not null
        if (checkInput) {
            {

                if (!Controller.registerUser(username, password)) {
                    session.setAttribute("error", " User is already existed");
                } else {
                    strViewPage = "signup_success.jsp";
                    session.invalidate();
                    session = request.getSession();
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
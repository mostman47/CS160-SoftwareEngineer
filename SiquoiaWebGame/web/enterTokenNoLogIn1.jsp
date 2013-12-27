<%-- 
    Document   : enterTokenNoLogIn1
    Created on : Dec 14, 2013, 7:05:00 PM
    Author     : mr.nam
--%>

<%@page import="DataOOD.Token"%>
<%@page import="Controller.Controller"%>
<%
    String strViewPage = "enterTokenNoLogIn.jsp";
    //initial
    session.setAttribute("error", null);
    //
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        if (session.getAttribute("submit") == null) {//introduction
            String code = (String) request.getParameter("code");
            if (code == null || code.isEmpty()) {
                session.setAttribute("error", "Please enter a valid code.");
            } else {
                if (!Controller.isExistedToken(code)) {//not exist
                    session.setAttribute("error", "This code does not exist.");
                } else if (Controller.isUsedToken(code)) {// already used
                    session.setAttribute("error", "This code has already been used.");
                } else {
                    Token token = Controller.getTokenByCode(code);
                    Controller.updateTokenToUsed(token, 0);//0 because guest
                    strViewPage = "brandedQuizNoLogin.jsp";
                    session.invalidate();
                    session = request.getSession();
                    session.setAttribute("branded_topic", Controller.getTopicByID(token.getTopic_ID()).getDescription());
                    session.setAttribute("numberQuestion", token.getNumberQuestion());

                }
            }
        }

    }

%>
<%    RequestDispatcher dispatcher = request.getRequestDispatcher(strViewPage);
    if (dispatcher != null) {
        dispatcher.forward(request, response);
    }
%>


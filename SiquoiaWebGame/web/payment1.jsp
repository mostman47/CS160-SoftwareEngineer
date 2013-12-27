<%-- 
    Document   : payment1
    Created on : Dec 8, 2013, 8:43:53 PM
    Author     : mr.nam
	
	Payment information for purchasing packets.
--%>

<%@page import="Miscellanea.EnumString"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="Controller.Controller"%>
<%
    
    String strViewPage = "payment.jsp";
    //initial
    session.setAttribute("error", null);
    //
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        if (request.getParameter("next") != null) {
            if (request.getParameter("pay") != null) {
                session.setAttribute("payMethod", (String) request.getParameter("pay"));
            }
            String payMethod = (String) session.getAttribute("payMethod");
            if (payMethod != null && payMethod.equals("point") && request.getParameter("check") != null) {
                String topic = (String) session.getAttribute("topic");
                DateFormat dateFormat = new SimpleDateFormat(EnumString.DATETIME_FORMAT.getValue());
                Date date = new Date();
                if (Controller.purchase(topic, dateFormat.format(date))) {
                    session.invalidate();
                    session = request.getSession();
                    session.setAttribute("topic", topic);
                    strViewPage = "newQuiz.jsp";
                } else {
                    session.setAttribute("error", "You do not have enough points! Please purchase more.");
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
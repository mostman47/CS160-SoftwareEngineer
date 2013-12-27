<%-- 
    Document   : selectpacket1
    Created on : Dec 8, 2013, 6:39:40 PM
    Author     : mr.nam
	
	Users select the quiz packet to purchase. The packet information is sent to the controller, which queries the database.
	Packets are then displayed in newQuiz
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="DataOOD.Topic"%>
<%@page import="Controller.Controller"%>
<%@ include file="controller.jsp" %> 

<%    String name, expand;
    String strViewPage = "selectpacket.jsp";
    session.setAttribute("error", null);
    if ("POST".equalsIgnoreCase(request.getMethod())) {

        if (request.getParameter("topic") != null) {
            name = request.getParameter("topic");
            session.setAttribute("select", name);

        }

        if (request.getParameter("expand") != null) {
            expand = (String) session.getAttribute("select");
            if (expand != null && !expand.isEmpty()) {
                List<Topic> list = Controller.getSubTopicByName(expand);
                if (!list.isEmpty()) {
                    session.setAttribute("entire", expand);
                } else {
                    session.setAttribute("error", expand + " does not have any subtopics");
                }

            }

        }
        if (request.getParameter("back") != null) {
            name = (String) session.getAttribute("entire");
            if (name == null) {
                session.setAttribute("error", "Cannot go further back");

            } else {
                Topic parent = Controller.getTopicParentByName(name);
                if (parent != null) {
                    session.setAttribute("entire", parent.getDescription());
                    session.setAttribute("select", null);
                } else {
                    session.setAttribute("entire", null);
                    session.setAttribute("select", null);
                }
            }

        }
        if (request.getParameter("buy") != null) {
            if (session.getAttribute("select") != null) {
                String topic = (String) session.getAttribute("select");
                session.invalidate();
                session = request.getSession();
                session.setAttribute("topic", topic);
                strViewPage = "payment.jsp";
            }
        }

    }


%>

<%    RequestDispatcher dispatcher = request.getRequestDispatcher(strViewPage);
    if (dispatcher != null) {
        dispatcher.forward(request, response);
    }
%>
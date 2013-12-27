<%-- 
    Document   : brandedQuizNoLogin1
    Created on : Dec 14, 2013, 11:53:23 PM
    Author     : mr.nam
--%>


<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="Miscellanea.EnumString"%>
<%@page import="DataOOD.Quiz"%>
<%@page import="Controller.Controller"%>


<%

    String strViewPage = "brandedQuizNoLogin.jsp";
    //initial
    session.setAttribute("select", null);
    session.setAttribute("error", null);
    //
    if ("POST".equalsIgnoreCase(request.getMethod())) {

        if (session.getAttribute("start") == null) {//introduction
            session.setAttribute("start", "start");
        } else {
            //start the quiz
            if (request.getParameter("answer") != null) {
                if (request.getParameter("next") != null) {
                    session.setAttribute("next", "next");
                    Quiz quiz = (Quiz) session.getAttribute("quiz");
                    String s = (String) request.getParameter("answer");
                    if (quiz.isCurrentCorrect(s)) {
                        session.setAttribute("select", "You answered correctly!");
                        session.setAttribute("userPoint"
                                ,(Integer)session.getAttribute("userPoint")+1);
                    } else {
                        session.setAttribute("select", "You answered incorrectly!");
                    }
                }
            } else {
                session.setAttribute("error", "Please select an answer.");
            }
            //end of quiz
            Quiz quiz = (Quiz) session.getAttribute("quiz");
            if(!quiz.hasNext())
            {
                strViewPage = "brandedQuizNoLoginReport.jsp";
                int point = (Integer)session.getAttribute("userPoint");
                int total = quiz.getTotal();
                String topic = (String) session.getAttribute("branded_topic");
                //
                session.invalidate();
                session = request.getSession();
                
                session.setAttribute("correct", point);
                session.setAttribute("topic", topic);                
                session.setAttribute("total", total);
                
            }
        }
    }

%>
<%    RequestDispatcher dispatcher = request.getRequestDispatcher(strViewPage);
    if (dispatcher != null) {
        dispatcher.forward(request, response);
    }
%>


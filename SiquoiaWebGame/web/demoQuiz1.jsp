<%-- 
    Document   : demoQuiz1
    Created on : Dec 7, 2013, 1:59:10 AM
    Author     : mr.nam
--%>

<%@page import="DataOOD.Quiz"%>
<%

    String strViewPage = "demoQuiz.jsp";
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
                session.setAttribute("error", "Please select an answer");
            }
            //end of quiz
            Quiz quiz = (Quiz) session.getAttribute("quiz");
            if(!quiz.hasNext())
            {
                strViewPage = "demoReport.jsp";
                int point = (Integer)session.getAttribute("userPoint");
                int total = quiz.getTotal();
                session.invalidate();
                session = request.getSession();
                
                session.setAttribute("correct", point);
                session.setAttribute("topic", "Demo");                
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
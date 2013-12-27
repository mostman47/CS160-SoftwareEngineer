<%-- 
    Document   : brandedQuiz1
    Created on : Dec 15, 2013, 2:06:56 PM
    Author     : nam
--%>


<%@page import="DataOOD.QuizHistory"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="Miscellanea.EnumString"%>
<%@page import="DataOOD.Quiz"%>
<%@page import="Controller.Controller"%>


<%

    String strViewPage = "brandedQuiz.jsp";
    //initial
    session.setAttribute("select", null);
    session.setAttribute("error", null);
    //
    if ("POST".equalsIgnoreCase(request.getMethod())) {

        if (session.getAttribute("start") == null) {//introduction
            session.setAttribute("start", "start");
        } else {
            //initial
            Quiz quiz = (Quiz) session.getAttribute("quiz");
            //save and quit the quiz
            if (request.getParameter("save") != null) {
                //save quiz history
                String topicName = (String) session.getAttribute("branded_topic");
                int point = (Integer) session.getAttribute("userPoint");
                Controller.insertBrandedQuizHistory(quiz, topicName, point);
                //
                strViewPage = "account.jsp";
                session.invalidate();
                session = request.getSession();
            }
            //start the quiz
            if (request.getParameter("answer") != null) {
                if (request.getParameter("next") != null) {//next question
                    session.setAttribute("next", "next");
                    String s = (String) request.getParameter("answer");
                    if (quiz.isCurrentCorrect(s)) {
                        session.setAttribute("select", "You answered correctly!");
                        session.setAttribute("userPoint", (Integer) session.getAttribute("userPoint") + 1);
                    } else {
                        session.setAttribute("select", "You answered incorrectly!");
                    }
                }
            } else {
                session.setAttribute("error", "Please select an answer");
            }
            //end of quiz
            if (!quiz.hasNext()) {
                int point = (Integer) session.getAttribute("userPoint");
                String topic = (String) session.getAttribute("branded_topic");
                int total = quiz.getTotal();
                //
                strViewPage = "brandedQuizReport.jsp";
                session.invalidate();
                session = request.getSession();
                session.setAttribute("correct", point);
                session.setAttribute("topicReport", topic);
                session.setAttribute("total", total);
                //
                DateFormat dateFormat = new SimpleDateFormat(EnumString.DATETIME_FORMAT.getValue());
                Date date = new Date();
                //
                Controller.updatePoint(topic, dateFormat.format(date), point);

            }
        }
    }

%>
<%    RequestDispatcher dispatcher = request.getRequestDispatcher(strViewPage);
    if (dispatcher != null) {
        dispatcher.forward(request, response);
    }
%>


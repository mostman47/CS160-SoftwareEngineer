<%-- 
    Document   : brandedQuiz
    Created on : Dec 15, 2013, 1:27:14 PM
    Author     : nam
--%>


<%@page import="Miscellanea.EnumString"%>
<%@page import="DataOOD.Media"%>
<%@page import="DataOOD.Node"%>
<%@page import="DataOOD.Quiz"%>
<%@page import="DataOOD.Question"%>
<%@page import="javax.swing.text.Document"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="Controller.Controller"%>
<%@page import="DataOOD.Topic"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="controller.jsp" %> 

<html xmlns="http://www.w3.org/1999/xhtml"> 
    <%!
        private List<Topic> list;
        private Quiz quiz;

        private Quiz generateQuiz(String topic, int numberQuestion) {
            Quiz quiz = Controller.generateQuizFromTopic(Controller.getTopicByName(topic), numberQuestion);
            return quiz;
        }

    %>
    <head>
        <title>Branded Quiz</title>
        <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
        <link rel="stylesheet" href="css/style.css" type="text/css" media="handheld,all" />
        <%            if (session.getAttribute("branded_topic") == null) {
        %>
        <META HTTP-EQUIV=Refresh CONTENT="0; URL=account.jsp">
            <%}%>
            <script type="text/javascript">
                window.history.forward(1);
                var hook = true;
                window.onbeforeunload = function() {
                    if (hook) {
                        return "\nDid you save the game?\nIf not, your points and progress will be lost!\n"
                    }
                }
                function unhook() {
                    hook = false;
                }
            </script>
    </head>

    <body>

        <div class="navbar navbar-inverse">
            <div class="navbar-inner">
                <div class="container-fluid">
                    <ul class="nav pull-left">
                        <li>
                            <a href="account.jsp">
                                <img class="centre" id="topBar" src="img/SiQuoia logo.jpg" />
                            </a>
                        </li>
                        <li class="divider-vertical"> </li>

                    </ul>
                    <div class="nav-collapse collapse">
                        <ul class="nav pull-center">
                            <li>
                                <h2>Branded Quiz</h2>
                            </li>
                        </ul>
                        <ul class="nav pull-right">
                            <li>Welcome <b> <%=usernameLogin%></b>
                                <form action="controller.jsp" method="post">
                                    <i class="icon-white icon-lock"></i> 
                                    <button type="submit" name="logout">Logout</button>
                                </form>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <form action="brandedQuiz1.jsp" class="loginfield" method="post">
            <div id="sink">
                <div class="well well-small" align="center" style="width: 150px">
                    <img src="img/branded.jpg"/>

                </div>
                <%

                    String topicName = (String) session.getAttribute("branded_topic");
                    if (session.getAttribute("quiz_history") != null) {
                        quiz = (Quiz) session.getAttribute("quiz_history");
                        session.setAttribute("quiz_history",null);
                        session.setAttribute("start", "start");
                        session.setAttribute("userPoint", quiz.getCorrect());
                    } else if (topicName != null
                            && session.getAttribute("quiz") == null) {//generate quiz in beginning
                        int numberQuestion = (Integer) session.getAttribute("numberQuestion");
                        quiz = generateQuiz(topicName, numberQuestion);
                        session.setAttribute("userPoint", 0); //
                    }
                    if (session.getAttribute("start") == null) {
                %>

                <div class="well well-small">
                    <label><b>Instructions</b></label>
                    <ul>
                        <li>Read the question carefully</li>
                        <li>Select an answer and click <b>NEXT</b></li>
                        <li>When the quiz is in progress, you cannot go back</li>
                        <li>Click <b>SAVE & QUIT</b> to save the quiz and exit. 
                            (* Playing the quiz without signing in will not have the <b>SAVE</b> option)</li>
                    </ul>
                </div>
                <%
                } else {
                    if (session.getAttribute("next") != null) {
                        quiz.next();
                        session.setAttribute("next", null);
                    }
                    int count = quiz.getCurrentNumber();
                    int total = quiz.getTotal();
                    Question q = quiz.getCurrentQuestion();
                    String des = q.getQuestion();
                    String a1 = q.getAnswer1();
                    String a2 = q.getAnswer2();
                    String a3 = q.getAnswer3();
                    String a4 = q.getCorrectAnswer();
                    int mediaID = q.getMedia();
                    session.setAttribute("quiz", quiz);
                %>
                <div class="well well-small">
                    <label style="text-align: center">Topic: <b><%=topicName%></b> | Question #<%=count%>/<%=total%></label> 
                </div>
                <%
                    if (mediaID > 0) {
                %>


                <div class="well well-small">
                    <%
                        Media media = Controller.getMediaByID(mediaID);
                        String type = media.getType();
                        String mediaDes = media.getDescription();
                        if (type.equals(EnumString.IMAGE.getValue())) {
                    %>
                    <img src="<%=mediaDes%>" alt="Pulpit rock" width="100%"/>
                    <%
                    } else if (type.equals(EnumString.AUDIO.getValue())) {
                    %>
                    <embed  width="100%" src="<%=mediaDes%>" />
                    <%
                    } else if (type.equals(EnumString.VIDEO.getValue())) {
                    %>
                    <video width="100%" controls="" autoplay="" src="<%=mediaDes%>"></video>

                    <%
                        }
                    %>
                </div>

                <%
                    }
                %>



                <div class="well well-small">
                    <label><b><%=des%></b></label>
                    <hr />
                    <p>
                        <input type="radio" name="answer" id="1" value="<%=a1%>" /><%=a1%><br /><br />
                        <input type="radio" name="answer" id="2" value="<%=a2%>" /><%=a2%><br /><br />
                        <input type="radio" name="answer" id="3" value="<%=a3%>" /><%=a3%><br /><br />
                        <input type="radio" name="answer" id="4" value="<%=a4%>" /><%=a4%><br /><br />
                    </p>
                </div>



                <%
                    }
                %>
                <div class="well well-small" align=center">
                    Total Correct: <%= (session.getAttribute("userPoint") != null
                            ? (Integer) session.getAttribute("userPoint") : 0)%>
                    <br />  
                    <%= (session.getAttribute("select") != null
                            ? (String) session.getAttribute("select") : "")%>
                    <br />
                    <%= (session.getAttribute("error") != null
                            ? "Error: " + (String) session.getAttribute("error") : "")%>
                </div>
                <div align="center">   

                    <button type="submit" class="btn btn-large" value="Next" name="next" onclick="unhook();">Next</button>
                    <button type="submit" class="btn btn-large" value="save" name="save" onclick="unhook();">Save & Quit</button>


                </div>
            </div>

        </form>
        <hr />
        <div>
            <small>© Copyright 2013, SQ06 Sequoia Inc.</small>
        </div>
    </body>


</html>

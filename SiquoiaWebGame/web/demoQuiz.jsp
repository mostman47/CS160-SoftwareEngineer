<%-- 
    Document   : quiz
    Created on : Dec 3, 2013, 10:43:50 AM
    Author     : mr.nam
        
        The demo quiz for guest users to play. Quiz packet is statically stored in the database, not created upon opening.
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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"> 
    <%!
        private List<Topic> list;
        private Quiz quiz;

        private Quiz generateQuiz() {
            Quiz quiz = Controller.generateQuizFromTopic(Controller.getTopicByName("Demo"));
            return quiz;
        }

    %>
    <head>
        <title>Demo Quiz</title>
        <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
        <link rel="stylesheet" href="css/style.css" type="text/css" media="handheld,all" />
        <script type="text/javascript">
            window.history.forward(1);
            
        </script>
    </head>

    <body>

        <div class="navbar navbar-inverse">
            <div class="navbar-inner">
                <div class="container-fluid">
                    <ul class="nav pull-left">
                        <li>
                            <a href="index.jsp">
                                <img class="centre" id="topBar" src="img/SiQuoia logo.jpg" />
                            </a>
                        </li>
                        <li class="divider-vertical"> </li>

                    </ul>
                    <div class="nav-collapse collapse">
                        <ul class="nav pull-center">
                            <li>
                                <h2>Demo Quiz</h2>
                            </li>
                        </ul>
                        <ul class="nav pull-right">
                            <li>
                            </li></ul>
                    </div>
                </div>
            </div>
        </div>
            <form action="demoQuiz1.jsp" class="loginfield" method="post">
                <div id="sink">
                    <%
                        if (session.getAttribute("quiz") == null) {//generate quiz in beginning
                            quiz = generateQuiz();
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
                        int ranking = q.getRanking();
                        session.setAttribute("quiz", quiz);
                    %>
                    <div class="well well-small">
                        <label style="text-align: center">Question #<%=count%>/<%=total%> | <%=ranking%></label> 
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

                        <button type="submit" class="btn btn-large" value="Next" name="next">Next</button>
                    </div>
                </div>

            </form>

<hr />
        <div>
            <small>© Copyright 2013, SQ06 Sequoia Inc.</small>
        </div>

    </body>


</html>
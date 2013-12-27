<%-- 
    Document   : account
    Created on : Dec 8, 2013, 4:34:05 PM
    Author     : mr.nam
        
        Homepage for gamer when logged in as a registered user. Access game functions here.
--%>

<%@page import="DataOOD.Question"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="controller.jsp" %> 
<%@ include file="account1.jsp" %> 

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" media="handheld,all" />
        <%            session.invalidate();
            session = request.getSession();
        %>
    </head>
    <body>
        <div class="navbar navbar-inverse">
            <div class="navbar-inner">
                <div class="container-fluid">
                    <ul class="nav pull-left">
                        <li>
                            <a href="index.jsp">
                                <img class="centre" id="topBar" border="0" src="img/SiQuoia logo.jpg">
                            </a>
                        </li>
                        <li class="divider-vertical"> </li>

                    </ul>
                    <div class="nav-collapse collapse">
                        <ul class="nav pull-center">
                            <li>
                                <h2>Account</h2>
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
        <div id="sink">

            <div class="button" style="left:0;">
                <a href="selectpacket.jsp"><img src="img/button_take_quiz.png" alt="take quiz"
                                                style="width: 100px; height: auto;">Take a Quiz</a>
            </div>

            <div class="button" style="left: 200px">
                <a href="enterToken.jsp"><img src="img/button_quiz_packets.png" alt="quiz pakets"
                                              style="width: 100px; height: auto;">Branded Packet</a>
            </div>

            <div class="button" style="right:0;">
                <a href="#"><img src="img/button_settings.png" alt="settings"
                                 style="width: 100px; height: auto;">User Settings</a>
            </div>
            <br /><br /><br /><br /><br /><br /><br /><br />

            <div class="well well-small" style="">
                <label style="text-align: center"><b>Account Summary</b></label> 
                <hr />
                <div>
                    <form action="account2.jsp" class="loginfield" method="post">
                        <table border="0" style="width: 100%" class="table-striped table-condensed">
                            <tr>
                                <td><b>Points</b></td>
                                <td><%=point%> </td>
                                <td align="middle"><button type="submit" name="buyMore" class="btn btn-mini">Buy More</button>
                                </td>
                            </tr>
                            <tr>
                                <td><b>Amount of purchased Packets</b></td>
                                <td><%=amountPurchasePacket%></td>
                                <td align="middle"><button type="submit" name="" class="btn btn-mini" disabled="">Details</button></td>
                            </tr>
                            <tr>
                                <td><b>Amount of earned Points</b></td>
                                <td><%=amountEarnedPoint%></td>
                                <td align="middle"><button type="submit" name="" class="btn btn-mini" disabled="">Details</button></td>
                            </tr>
                            <tr>
                                <td><b>Amount of used Points</b></td>
                                <td><%=amountUsedPoint%></td>
                                <td align="middle"><button type="submit" name="" class="btn btn-mini" disabled="">Details</button></td>
                            </tr>
                        </table>
                    </form>
                </div>
            </div>
            <div class="well well-small" style="">
                <div align="center"><b>Leader Board</b></div>
                <div>
                    
                </div>
                <hr />

                <div>
                    <%
                        List<Question> top10 = Controller.getTop10Question();
                    %>
                    <div align="center">Top 10 Highest Ranking Question</div>
                    <table border="0" style="width: 100%" class="table-striped table-condensed">
                        <tr>
                            <th>Rank</th>
                            <th>Question</th>

                        </tr>
                        <%
                            for (Question q : top10) {
                                int ranking = q.getRanking();
                                String question = q.getQuestion();
                                if (question.length() > 60) {
                                    question = question.substring(0, 59) + "...";
                                }
                        %>
                        <tr>
                            <td><%=ranking%></td>
                            <td><%=question%></td>

                        </tr>
                        <%}%>
                    </table>
                </div>
            </div>              
        </div>
        <hr />
        <div>
            <small>© Copyright 2013, SQ06 Sequoia Inc.</small>
        </div>
    </body>
</html>

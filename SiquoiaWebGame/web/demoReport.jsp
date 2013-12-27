<%-- 
    Document   : demoReport
    Created on : Dec 8, 2013, 10:23:22 PM
    Author     : mr.nam
        
        Reporting for the demonstration quiz packet, available at the end of the quiz.
--%>

<%@page import="Miscellanea.EnumValue"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Demo Report</title>
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
                                <img class="centre" id="topBar" border="0" src="img/SiQuoia logo.jpg">
                            </a>
                        </li>
                        <li class="divider-vertical"> </li>

                    </ul>
                    <div class="nav-collapse collapse">
                        <ul class="nav pull-center">
                            <li>
                                <h2>Report</h2>
                            </li>
                        </ul>
                        <ul class="nav pull-right">

                        </ul>

                    </div>
                </div>
            </div>
        </div>
        <div id="sink">
            <div class="well well-small">
                <div align="center">
                    <b>Report</b>
                    <hr />
                    <%
                        if (session.getAttribute("topic") != null
                                && session.getAttribute("correct") != null) {
                            String topic = (String) session.getAttribute("topic");
                            int correct = (Integer) session.getAttribute("correct");
                            int total = (Integer) session.getAttribute("total");
                    %>
                    <table border="0" style="width: 100%" class="table-striped table-condensed">
                        <tr>
                            <td><b>Topic</b></td>
                            <td><%=topic%></td>
                        </tr>
                        <tr>
                            <td><b>Total Questions</b></td>
                            <td><%=total%></td>
                        </tr>
                        <tr>
                            <td><b>Correct Answers</b></td>
                            <td><%=correct%></td>
                        </tr>

                    </table>
                    <%}%>
                </div>
            </div>
            <div align="center">
                <a href="demoQuiz.jsp"><button type="submit" class="btn btn-warning" >Play again</button>
                </a>
            </div>
        </div>
        <hr />
        <div>
            <small>© Copyright 2013, SQ06 Sequoia Inc.</small>
        </div>
    </body>
</html>

<%-- 
    Document   : test
    Created on : Dec 8, 2013, 4:34:23 PM
    Author     : mr.nam
	
	Users select the quiz packet to purchase. The packet information is sent to the controller, which queries the database.
	Packets are then displayed in newQuiz
--%>

<%@page import="java.util.List"%>
<%@page import="DataOOD.Topic"%>
<%@page import="DataOOD.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="controller.jsp" %> 

<!DOCTYPE html>
<html>
    <%!        
        private List<Topic> list;
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Buy Packet</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" media="handheld,all" />

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
                                <h2>Buy Packet</h2>
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
        <form action="selectpacket1.jsp" method="post">

            <div id="sink">
                <div class="well well-small" align="center">Select Packet</div>
                <div class="well well-small" align="center">
                    <div class="text" style="background-color: white;height: 200px">
                            <%
                                String entire = (String) session.getAttribute("entire");
                                if (entire == null) {
                                    list = Controller.getSubTopicByID(0);
                                } else {
                                    list = Controller.getSubTopicByName(entire);
                                }
                                for (Topic t : list) {
                                    String nameTopic = t.getDescription();
                                    

                            %>
                            <button type="submit" class="btn btn-block" name="topic" value="<%=nameTopic%>" ><%=nameTopic%></button>
                            <%                    }%>                            
                        </div>
                        <div>
                            Selected: <%= (session.getAttribute("select") != null
                                    ? (String) session.getAttribute("select") : "")%>
                        </div>   
                        <div id="error">
                            <%= (session.getAttribute("error") != null
                                    ? "Error: " + (String) session.getAttribute("error") : "")%>
                        </div>   
                    </p>
                    
                </div>
                    
                <div align="center">
                    <button type="submit" class="btn btn-inverse" name="expand" value="Expand">Expand</button>
                    <button type="submit" class="btn btn-inverse" name="back" value="Back">Back</button>
                    <button type="submit" class="btn btn-inverse" name="buy" value="buy">Buy Quiz Packet</button>
                </div>
            </div>
        </form>
        <hr />
        <div>
            <small>© Copyright 2013, SQ06 Sequoia Inc.</small>
        </div>
    </body>
</html>

<%-- 
    Document   : enterToken
    Created on : Dec 15, 2013, 1:27:01 PM
    Author     : nam
--%>

<%@page import="DataOOD.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="controller.jsp" %> 

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Enter Token</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" media="handheld,all" />
    </head>
    <body>
        <div class="navbar navbar-inverse">
            <div class="navbar-inner">
                <div class="container-fluid">
                    <ul class="nav pull-left">
                        <li>
                            <a href="account.jsp">
                                <img class="centre" id="topBar" border="0" src="img/SiQuoia logo.jpg">
                            </a>
                        </li>
                        <li class="divider-vertical"> </li>

                    </ul>
                    <div class="nav-collapse collapse">
                        <ul class="nav pull-center">
                            <li>
                                <h2>Enter Token</h2>
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
        <form action="enterToken1.jsp" class="loginfield" method="post">
            <div id="sink">
                <div class="well well-small" align="center">
                    <label class="control-label" for="inputEmail">Enter Packet Code</label>
                    <hr />
                    <input type="text" name="code" id="code" placeholder="Enter the 4-digit code">
                    <hr />
                    <div id="error">
                        <%= (session.getAttribute("error") != null
                                ? "Error: " + (String) session.getAttribute("error") : "")%>
                    </div>
                </div>

                <div align="center">
                    <button type="submit" class="btn btn-primary" name="submit">Submit</button>
                </div>
            </div>
        </form>
        <hr />
        <div>
            <small>© Copyright 2013, SQ06 Sequoia Inc.</small>
        </div>
    </body>
</html>

<%-- 
    Document   : signsignup_success
    Created on : Dec 5, 2013, 10:48:30 PM
    Author     : mr.nam
	
	Successful sign in.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="controller.jsp" %> 
<!DOCTYPE html>
<html>
    <head>
        <title>Siquoia Sign in Successfully</title>
        <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
        <link rel="stylesheet" href="css/style.css" type="text/css" media="handheld,all" />
        <META HTTP-EQUIV=Refresh CONTENT="2; URL=account.jsp">
        <style>
            #message {
                margin-top: 16px;
                text-align: center;
                font-size: 32px;
            }
        </style>
    </head>

    <body>
        <div class="navbar navbar-inverse">
            <div class="navbar-inner">
                <div class="container-fluid">
                    <ul class="nav pull-left">
                        <li>
                            <img class="centre" id="topBar" border="0" src="img/SiQuoia logo.jpg">
                        </li>
                        <li class="divider-vertical"> </li>

                    </ul>
                    <div class="nav-collapse collapse">
                        <ul class="nav pull-center">
                            <li>
                                <h2>Successfully</h2>
                            </li>
                        </ul>

                    </div>
                </div>
            </div>
        </div>

        <div>

            <br />
            <br />
            <div id="message">
                <div id="message">Welcome <%=usernameLogin%>

                </div>
            </div>

        </div> <!-- END wallpaper -->
        <hr />
        <div>
            <small>© Copyright 2013, SQ06 Sequoia Inc.</small>
        </div>
    </body>
</html>

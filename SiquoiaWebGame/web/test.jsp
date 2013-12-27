<%-- 
    Document   : test
    Created on : Dec 8, 2013, 4:34:23 PM
    Author     : mr.nam
        
        Test code
--%>

<%@page import="DataOOD.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="controller.jsp" %> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Buypacket</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" media="handheld,all" />
        <script type="text/javascript">
            var hook = true;
            window.onbeforeunload = function() {
                if (hook) {
                    return "\nDid you save the game?\nUnless all of your point and progress will be lost!\n"
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
                            <a href="index.jsp">
                                <img class="centre" id="topBar" border="0" src="img/SiQuoia logo.jpg">
                            </a>
                        </li>
                        <li class="divider-vertical"> </li>

                    </ul>
                    <div class="nav-collapse collapse">
                        <ul class="nav pull-center">
                            <li>
                                <h2>Registration</h2>
                            </li>
                        </ul>
                        <ul class="nav pull-right">
                            <li>Welcome <b> <%--=usernameLogin--%></b>
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
            <div class="well well-small">
                 
            </div>
        </div>
           <hr />
        <div>
            <small>© Copyright 2013, SQ06 Sequoia Inc.</small>
        </div>
    </body>
</html>

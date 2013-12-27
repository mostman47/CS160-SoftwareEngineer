<%-- 
    Document   : index.jsp
    Created on : Dec 6, 2013, 2:30:40 PM
    Author     : mr.nam
	
	The main file and homepage for the SiQuoia application.
	Account credentials are entered and verified (error checking) here, and a successful log in connects to the controler to send information.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Controller.Controller"%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Index</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" media="handheld,all" />
        <link href="css/bootstrap-responsive.css" rel="stylesheet">
        <script src="js/jquery-latest.min.js"   type="text/javascript"></script>
        <script src="js/bootstrap.js"></script>		
        <script src="js/bootstrap-responsive.js"></script>
        <%
            if(Controller.getLoginUser()!=null)
            {
                %>
                <META HTTP-EQUIV=Refresh CONTENT="0; URL=account.jsp">
        <%
            }
        %>
    </head>
    <body>
        
        <div class="navbar navbar-inverse">
            <div class="navbar-inner">
                <div class="container-fluid">
                    <ul class="nav pull-left">
                        <li>
                            <a href="index.jsp">
                            <img class="centre" id="topBar" border="0" src="img/SiQuoia logo.jpg" />
                            </a>
                        </li>
                        <li class="divider-vertical"> </li>

                    </ul>
                    <div class="nav-collapse collapse">
                        <ul class="nav pull-center">
                            <li>
                                <h2>Home</h2>
                            </li>
                        </ul>

                    </div>
                </div>
            </div>
        </div>



            <div id="sink">
        <form class="loginfield" action="login1.jsp" method="post"> 

                <div class="" style="margin: auto 10%;">
                    <label for="username">Username:</label>
                    <label id="error"> <%= (session.getAttribute("username_error") != null
                            ? (String) session.getAttribute("username_error") : "")%>
                    </label>
                    <input class="text" type="text" id="username" name="username" />


                    <label for="password">Password:</label>
                    <label id="error">
                        <%= (session.getAttribute("password_error") != null
                                ? (String) session.getAttribute("password_error") : "")%>
                    </label>
                    <input class="text" type="password" id="password" name="password"/>

                    <label>
                        <input type="checkbox"> Remember me
                    </label>
                    <label id="error">
                        <%= (session.getAttribute("error") != null
                            ? (String) session.getAttribute("error") : "")%>
                    </label>   
                </div>
                <br />
                <div accesskey="" align="center">

                    <button type="submit" name = "login" class="btn btn-large" value="Sign in">Sign In</button>
                    <br /> <br />

                    <button type="submit" name = "forward" class="btn btn-warning" value="signup.jsp">Register</button>
                    <button type="submit" name = "forward" class="btn btn-success" value="demoQuiz.jsp">Guest</button>
                    <button type="submit" name = "forward" class="btn btn-danger" value="enterTokenNoLogIn.jsp">Branded Packet</button>
                    
                </div>
        </form>


                <br />
                <br />
                <br />
                <!--Advertise -->
                <div class="well well-small" align="center">									
                    <div id="myCarousel" class="carousel slide">
                        <ol class="carousel-indicators">
                            <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                            <li data-target="#myCarousel" data-slide-to="1"></li>
                            <li data-target="#myCarousel" data-slide-to="2"></li>
                            <li data-target="#myCarousel" data-slide-to="3"></li>
                            <li data-target="#myCarousel" data-slide-to="4"></li>
                            <li data-target="#myCarousel" data-slide-to="5"></li>
                            <li data-target="#myCarousel" data-slide-to="6"></li>
                        </ol>
                        <!-- Carousel items -->
                        <div class="carousel-inner">
                            <div class="active item"><img class="centre" border="0" src="img/SiQuoia mug.PNG"></div>
                            <div class="item"><img class="centre" border="0" src="img/SiQuoia bag.PNG"></div>
                            <div class="item"><img class="centre" border="0" src="img/SiQuoia sweatshirt.PNG"></div>							
                            <div class="item"><img class="centre" border="0" src="img/SiQuoia T shirt.PNG"></div>
                            <div class="item"><img class="centre" border="0" src="img/SiQuoia water bottle.PNG"></div>
                            <div class="item"><img class="centre" border="0" src="img/SiQuoia iphone 5 case.PNG"></div>
                            <div class="item"><img class="centre" border="0" src="img/SiQuoia travelmug.PNG"></div>							
                        </div>
                        <!-- Carousel nav -->
                        <a class="carousel-control left" href="#myCarousel" data-slide="prev">‹</a>
                        <a class="carousel-control right" href="#myCarousel" data-slide="next">›</a>
                    </div>									
                </div>


            </div> 
                    
        <hr />
        <div>
            <small>© Copyright 2013, SQ06 Sequoia Inc.</small>
        </div>
    </body>
</html>

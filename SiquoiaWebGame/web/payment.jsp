<%-- 
    Document   : payment
    Created on : Dec 8, 2013, 8:30:00 PM
    Author     : mr.nam
	
	Payment information for purchasing packets.
--%>

<%@page import="Miscellanea.EnumValue"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="controller.jsp" %> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Payment</title>
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
                                <h2>Payment</h2>
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
        <form action="payment1.jsp" method="post">
            <div id="sink">
                <div class="well well-small">
                    <% String s = (String) session.getAttribute("topic");
                    %>
                    Your topic selection <b> <%=s%></b>
                </div>
                <div class="well well-small">	
                    Please select your preferred form of payment below: 
                    <hr />
                    <div class="control-group">				
                        <label class="radio">
                            <input type="radio" name="pay" id="optionsRadios1" value="point">
                            Sequoia Points
                        </label>
                        <label class="radio">
                            <input type="radio" name="pay" id="optionsRadios2" value="paypal">
                            PayPal
                        </label>
                        <label class="radio">
                            <input type="radio" name="pay" id="optionsRadios3" value="card">
                            Visa/MasterCard
                        </label>
                        
                    </div>
                    <hr/>
                    <label id="error">
                        <%= (session.getAttribute("error") != null
                            ? (String) session.getAttribute("error") : "")%>
                    </label>
                </div>
                <%
                    if (session.getAttribute("payMethod") != null) {
                        session.setAttribute("agreePay", true);
                        String pay = (String) session.getAttribute("payMethod");
                        if (pay.equals("point")) {
                            int point = u.getPoint();
                            int value = EnumValue.PACKET_PRICE_BY_POINT.getValue();
                            int after = point - 20;
                %>
                <div class="well well-small">
                    <div align="center"><b>Sequoia Points</b></div>
                    <hr />
                    Your Current Points = <b><%=point%></b>
                    <br />
                    Value of Packet = <b><%=value%></b>
                    <br />
                    Your Points After Purchase = <%=point%> - <%=value%> = <b><%=after%></b>
                    <hr />
                    <input type="checkbox" name="check" value="check" > I have read and agree to the <a href="#">Policies</a>
                    <br />
                    (Click next to purchase this packet)
                </div>
                <%
                } else if (pay.equals("paypal")) {
                %>
                <div class="well well-small">
                    <div align="center"><b>PayPal</b></div>
                    <hr />
                    Coming Soon
                </div>
                <%
                } else if (pay.equals("card")) {
                %>
                <div class="well well-small">
                    <div align="center"><b>Visa/MasterCard</b></div>
                    <hr />
                    Coming Soon
                </div>
                <%
                        }

                    }

                %>
                <button type="submit" name="next" class="btn btn-primary">Next</button>
            </div>
        </form>
        <hr />
        <div>
            <small>© Copyright 2013, SQ06 Sequoia Inc.</small>
        </div>
    </body>
</html>

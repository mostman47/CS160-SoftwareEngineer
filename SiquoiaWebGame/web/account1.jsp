<%-- 
    Document   : account1
    Created on : Dec 8, 2013, 6:03:25 PM
    Author     : mr.nam
--%>

<%@page import="DataOOD.User"%>
<%@page import="java.util.List"%>
<%@page import="DataOOD.PointHistory"%>
<%@page import="Controller.Controller"%>

<%
    User user = Controller.getLoginUser();
    List<PointHistory> list = Controller.getPointHistoryByUserID(user.getId());
    int point = user.getPoint();
    int amountPurchasePacket = 0;
    int amountEarnedPoint = 0;
    int amountUsedPoint = 0;

    for (PointHistory p : list) {
        amountEarnedPoint += p.getEarnedPoint();
        amountUsedPoint += p.getUsedPoint();
        if (p.getUsedPoint() > 0) {
            amountPurchasePacket++;
        }
    }
%>


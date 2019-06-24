<%@ page language="java" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
%>

<%@ page errorPage="showError.jsp" %>
   
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>Check DB Connection</title>
</head>
<body>

<font face="Georgia, Arial, Garamond" size = "1">

<% // get all attributes and parameters
String VIN = (String) session.getAttribute( "IVWEB_VIN" );
%>

<H4>Active Parameter Notification List</H4>

<sql:setDataSource dataSource="jdbc/abrstech_obd2db" />

<sql:query var="rs">    
	select * from abrstech_obd2db.car_obd2_notifications 
	where vin = <%="\"" + VIN + "\""%> 				
</sql:query>

<c:forEach var="row" items="${rs.rows}"> 
	 <a href="/ivweb/deleteNotification.jsp?no=${row.seqno}">(-)</a>  
     Parameter Name: &nbsp; ${row.paramname} <br>
     &nbsp; &nbsp; Baseline Value: &nbsp; ${row.baselinevalue} <br> 
     &nbsp; &nbsp; Upper Limit Threshold: &nbsp; ${row.upperlimitvalue} <br>
     &nbsp; &nbsp; Upper Limit Notification Message: &nbsp; ${row.upperlimitmessage} <br>  
     &nbsp; &nbsp; Lower Limit Threshold: &nbsp; ${row.lowerlimitvalue} <br> 
     &nbsp; &nbsp; Lower Limit Notification Message: &nbsp; ${row.lowerlimitmessage} <br><br>
</c:forEach>

</font>

</body>
</html>
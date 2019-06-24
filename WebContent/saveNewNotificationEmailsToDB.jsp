<%@ page language="java" 
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.util.*,com.abrstech.sql.*"
%>

<%@ page errorPage="showError.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>debug</title>
</head>
<body>



<% // get all attributes and parameters

String VIN = (String) session.getAttribute( "IVWEB_VIN" );

String nickname = request.getParameter( "nickname" ).trim();
String notifyemail = request.getParameter( "notifyemail" ).trim();

saveNotificationEmails saveNotify = new saveNotificationEmails();
saveNotify.WriteToDB( VIN, nickname, notifyemail ); 
saveNotify.CloseDB();

%>

 
<jsp:forward page="/activeNotificationAddresses.jsp" />



</body>
</html>
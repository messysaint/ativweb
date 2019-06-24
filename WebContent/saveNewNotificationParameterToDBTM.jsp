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
String OBD2PARAM = (String) session.getAttribute( "IVWEB_OBD2PARAM" );

String baseline = request.getParameter( "baseline" );
String upperlimit = request.getParameter( "upperlimit" );
String lowerlimit = request.getParameter( "lowerlimit" );
String upperlimitmessage = request.getParameter( "upperlimitmessage" );
String lowerlimitmessage = request.getParameter( "lowerlimitmessage" );
String sendtype = request.getParameter( "sendtype" );

saveNewNotificationRecord saveNotify = new saveNewNotificationRecord();
saveNotify.WriteToDB( VIN, OBD2PARAM, baseline, upperlimit, lowerlimit, upperlimitmessage, lowerlimitmessage, sendtype);
saveNotify.CloseDB(); 

%>

 
<jsp:forward page="/notifyRulesTM.jsp" />



</body>
</html>
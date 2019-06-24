<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.*,com.abrstech.obd2.security.*,com.abrstech.obd2.util.*"%>
	
<%@ page isErrorPage="true" %>

<html>
<head>
<title>Some application error occurred ...</title>
</head>
<body>

<h1>...</h1>

<%

String objName;
String message;
Enumeration enumAtt;
Enumeration enumPar;
Cookie[] Cookies;

enumAtt = request.getAttributeNames();
enumPar = request.getParameterNames();
Cookies = request.getCookies();

message = "<br><br>Attributes:<br><br>";
 
while( enumAtt.hasMoreElements() ) {
        objName = (String) enumAtt.nextElement();
        message += objName + " = " + request.getAttribute( objName ) + " <br>";
}

message += "<br><br>Parameters:<br><br>";

while( enumPar.hasMoreElements() ) {
        objName = (String) enumPar.nextElement();
        message += objName + " = " + request.getParameter( objName ) + " <br>";
}

message += "<br><br>Cookies:<br><br>";

for( int i = 0 ; i < Cookies.length ; i++ ) {        
        message += Cookies[i].getName() + " = " + Cookies[i].getValue() + " <br>";
}

// send confirmation email to business owner

String subject1 = "Autotalky Error ...";

String msg = "\n\nError:  " + request.getHeader("referer") + "\n\n" + message ; 

SmtpMailer mailerToBusiness = new SmtpMailer(); 
mailerToBusiness.sendMessageToAddress( "saintmess@yahoo.com", subject1 , msg);

%>
 			
</body>
</html>

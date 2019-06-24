<%@ page language="java" 
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.util.*"
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>debug</title>
</head>
<body>


 
<%! // declare variables
   String objName;
   String message;
   Enumeration enumAtt;
   Enumeration enumPar;
   Cookie[] Cookies;
   
%>
 
<% // get all attributes and parameters
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
%>

<%= message %>

</body>
</html>
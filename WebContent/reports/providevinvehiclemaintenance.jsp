<%@ page language="java" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Provide VIN</title>
</head>
<body>

<font face="Georgia, Arial, Garamond" size = "2">

<%
// validate if user already logged in
int cookieCtr = 0;
Cookie[] enumCookies = request.getCookies();
String cookieName = new String();
for( int i = 0 ; i < enumCookies.length ; i++ ) {
	cookieName = enumCookies[i].getName(); 
    if( cookieName.startsWith( "SESS" )  ) {
    	if( cookieName.length() > 20 ) {
    		if( enumCookies[i].getValue().length() > 20 ) {    			
    			cookieCtr++;
    		}		
    	}
    } 
    
} // end for - end validation if user logged in

String H3_YES = "<h3>Search for Vehicle Data:</h3>";
String H3_NO  = "<h3>Please login to start ...</h3>";

String formBegin = "<form action=\"/ivweb/providevinview.jsp\" method=\"post\">";
String formEnd   = "</form>";
String formInput = "Enter VIN: &nbsp; <input type=\"text\" name=\"vin\" maxlength=\"30\" size=\"30\" />";
String htmlBreak = "<br>";
String htmlSubmit = "<INPUT type=\"submit\" value=\"Search\">";

if( cookieCtr < 1 ) {
	out.println( H3_NO );
} else {
	out.println( H3_YES );
	out.println( formBegin );
	out.println( formInput );
	out.println( htmlBreak );
	out.println( htmlBreak );
	out.println( htmlSubmit );
	out.println( formEnd );
}

%>

</font>

</body>
</html>
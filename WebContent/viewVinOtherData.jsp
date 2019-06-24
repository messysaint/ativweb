<%@ page language="java" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import = "com.abrstech.obd2.security.*"
%>

<%@ page errorPage="showError.jsp" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Provide VIN</title>
</head>
<body>

<font face="Georgia, Arial, Garamond" size = "2">

<%


String H3_YES = "<h3>Search for Vehicle Data:</h3>";

String sessiontimeout = "/ivweb/z_securityquery.jsp";

String formBegin = "<form action=\"/ivweb/providevinview.jsp\" method=\"post\">";
String formEnd   = "</form>";
String formInput = "Enter VIN: &nbsp; <input type=\"text\" name=\"vin\" maxlength=\"30\" size=\"30\" />";
String htmlBreak = "<br>";
String htmlSubmit = "<INPUT type=\"submit\" value=\"Search\">";

checkAuth check = new checkAuth();

String IsHuman = (String) session.getAttribute( "IVWEB_ISHUMAN" );

if( !check.isLoggedIn( IsHuman ) ) {	// if not logged in, ask user to log in
	response.sendRedirect( sessiontimeout );
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
<%--
 % Example for using the free http://captchas.net Webservice
 % Documentation see http://captchas.net/sample/jsp/
 --%>

<%@ page language="java" import="captchas.CaptchasDotNet" %> 

<%@ page errorPage="showError.jsp" %>

<html>
 
<font face="Georgia, Arial, Garamond" size = "2">
  
<%
// Construct the captchas object
// Use same settings as in query.jsp
CaptchasDotNet captchas = new captchas.CaptchasDotNet(
  request.getSession(true),     // Ensure session
  "bmutia",                       // client
  "XhOcgdSNMslCM7LsOI782XE0i0s0z1c6ze4HX61J"                      // secret
  );
// Read the form values
//String message  = request.getParameter("message");
String password = request.getParameter("password");

// Check captcha
String body;
switch (captchas.check(password)) {
  case 's':
    body = "Session seems to be timed out or broken. ";
    body += "Please try again or report error to administrator.";
    break;
  case 'm':
    body = "Every CAPTCHA can only be used once. ";
    body += "The current CAPTCHA has already been used. ";
    body += "Please use back button and reload";
    break;
  case 'w':
    body = "You entered the wrong password. ";
    body += "Please use back button and try again. ";
    break;
  default:
    //body = "Thanks you \"" + message + "\"";
	session.setAttribute( "IVWEB_ISHUMAN", "YES" ); 
	body = "Verified.  Thank you ...";
    break;
}
%>

<%
response.sendRedirect( "/ivweb/autoBusiness.jsp" );
%> 

</font>

</html>
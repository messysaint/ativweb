<%@ page language="java" 
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.util.*,com.abrstech.sql.*, com.abrstech.obd2.security.*"
%>

<%@ page errorPage="showError.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Save New VIN to DB</title>
</head>
<body>

<font face="Georgia, Arial, Garamond" size = "2">
 
<% 

String[] questionSelection = null;
String[] vinSelection = null;

String sessiontimeout = "/ivweb/z_securityquery.jsp";

String notFound  = "<h3>This Vehicle Owner was not found in the database.</h3>";
String message1 = "Display data here and allow user to add information";

checkAuth check = new checkAuth();

String IsHuman = (String) session.getAttribute( "IVWEB_ISHUMAN" );

if( !check.isLoggedIn( IsHuman ) ) {	// if not logged in, ask user to log in
	response.sendRedirect( sessiontimeout );
} else { 
	

	// String country = request.getParameter( "country" );
	String email = request.getParameter( "email" );
	
	
	searchVehicle newSrch = new searchVehicle();
	boolean foundOk = newSrch.isExistingEmail( email );  
	newSrch.CloseDB();
	

	// save to DB
	if( !foundOk ) {
		out.println( notFound + "<br>" );
		
	} else {

		String IVWEB_VIN = newSrch.getVin();
		// String IVWEB_YEAR = newSrch.getYear();
		// String IVWEB_MAKE = newSrch.getMake();
		// String IVWEB_MODEL = newSrch.getModel();
		// String IVWEB_TRIM = newSrch.getTrim();
		String IVWEB_Question = newSrch.getQuestion();
		String IVWEB_Answer = newSrch.getAnswer();
		
		// remove trailing "|"
		IVWEB_VIN  = IVWEB_VIN.substring( 0, IVWEB_VIN.lastIndexOf('|') ); // remove last "|"
		IVWEB_Question = IVWEB_Question.substring( 0, IVWEB_Question.lastIndexOf('|') ); // remove last "|"
		IVWEB_Answer = IVWEB_Answer.substring( 0, IVWEB_Answer.lastIndexOf('|') ); // remove last "|"
		
		
		StringTokenizer vinTokens = new StringTokenizer( IVWEB_VIN, "|" );
		vinSelection = new String[ vinTokens.countTokens() ];
		
		int i = 0;
		while( vinTokens.hasMoreTokens() ) {
			vinSelection[i++] = vinTokens.nextToken().trim();
		}
		
		StringTokenizer questionTokens = new StringTokenizer( IVWEB_Question, "|" );
		questionSelection = new String[ questionTokens.countTokens() ];
		
		i = 0;
		while( questionTokens.hasMoreTokens() ) {
			questionSelection[i++] = questionTokens.nextToken().trim();
		}
		
		// session.setAttribute( "IVWEB_VIN", IVWEB_VIN ); 
		// session.setAttribute( "IVWEB_YEAR", null ); 
		// session.setAttribute( "IVWEB_MAKE", null ); 
		// session.setAttribute( "IVWEB_MODEL", null ); 
		// session.setAttribute( "IVWEB_TRIM", null ); 
		// session.setAttribute( "IVWEB_EMAIL", null );
		session.setAttribute( "IVWEB_LOGIN_SECURITY_EMAIL", email );
		session.setAttribute( "IVWEB_LOGIN_SECURITY_VIN", IVWEB_VIN );
		session.setAttribute( "IVWEB_LOGIN_SECURITY_QUESTION", IVWEB_Question ); 
		session.setAttribute( "IVWEB_LOGIN_SECURITY_ANSWER",  IVWEB_Answer ); 
%>
		

<form name="verifyidentity" action="/ivweb/validateVehicleOwner.jsp" method="post">

<table border="0">

  <tr>
    <td>Question: &nbsp;</td>
    <td>
    <select name="question" size="1">
    <% for( int ii = 0 ; ii < questionSelection.length ; ii++ ) { %>
		<option value="<%=questionSelection[ii] %>" > <%=questionSelection[ii] %> </option>
	<% } %>
	</select>
    </td>
  </tr>
  
  <tr>
    <td>Answer: &nbsp;</td>
    <td><input type="password" name="answer"   maxlength="50" size="50" value=""/> </td>
  </tr>
    
</table> 

<br>
<br>

<INPUT type="submit" value="Submit">

</form>


   
<%
	}
	
}

%>


</font>

</body>
</html>
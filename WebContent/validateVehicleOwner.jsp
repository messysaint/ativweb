<%@ page language="java" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="com.abrstech.sql.*,java.util.*,com.abrstech.obd2.log.*,java.text.Collator" 
%>

<%@ page errorPage="showError.jsp" %>
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>OBDII logs for this VIN</title>

	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />	
	<link type="text/css" href="/ivweb/datepicker/css/south-street/jquery-ui-1.8.22.custom.css" rel="stylesheet" />
	<script type="text/javascript" src="/ivweb/datepicker/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="/ivweb/datepicker/js/jquery-ui-1.8.22.custom.min.js"></script>

	<script type="text/javascript" src="/ivweb/jscript/validateAddMaintenanceForm.js"></script>
	
	<script>
	$(function() {
		$( "#datepicker" ).datepicker({ minDate: -180, maxDate: "+0D" });
	});
	</script>
	
</head>
<body>

<font face="Georgia, Arial, Garamond" size = "2">

<%

	String IVWEB_VIN = new String();

	String question = request.getParameter( "question" ).trim();
	String answer = request.getParameter( "answer" ).trim();
	
	String Xemail = (String) session.getAttribute( "IVWEB_LOGIN_SECURITY_EMAIL" );
	String Xvin   = (String) session.getAttribute( "IVWEB_LOGIN_SECURITY_VIN" );
	String Xquestion = (String) session.getAttribute( "IVWEB_LOGIN_SECURITY_QUESTION" ); 
	String Xanswer = (String) session.getAttribute( "IVWEB_LOGIN_SECURITY_ANSWER" ); 
	
	
	
	StringTokenizer vinTokens = new StringTokenizer( Xvin, "|" );
	StringTokenizer questionTokens = new StringTokenizer( Xquestion, "|" );
	StringTokenizer answerTokens = new StringTokenizer( Xanswer, "|" );
	
	String[] vinSelection = new String[ questionTokens.countTokens() ];
	String[] questionSelection = new String[ questionTokens.countTokens() ];
	String[] answerSelection = new String[ questionTokens.countTokens() ];
	
	// assign values
	int x = 0;
	while( vinTokens.hasMoreTokens() ) {
		vinSelection[x++] = vinTokens.nextToken().trim();
	}

	// assign values
	x = 0;
	while( questionTokens.hasMoreTokens() ) {
		questionSelection[x++] = questionTokens.nextToken().trim();
	}
	
	// assign values
	x = 0;
	while( answerTokens.hasMoreTokens() ) {
		answerSelection[x++] = answerTokens.nextToken().trim();
	}
	
	boolean isAnswerCorrect = false;
	
	for( int i = 0 ; i < vinSelection.length ; i++ ) {
		if( question.equalsIgnoreCase( questionSelection[i] ) ) {
			if( answer.equalsIgnoreCase( answerSelection[i] ) ) {
				IVWEB_VIN = vinSelection[i].trim();
				isAnswerCorrect = true;
				break;			
			}
		}	
	}
	
	// Collator collator = Collator.getInstance();
	
	// int compareEmail = collator.compare( SESSIONEmail, email );
	// int compareAnswer = collator.compare( SESSIONAnswer, answer );
	
    // if ( ( compareEmail == 0 )  &&  ( compareAnswer == 0 ) ) {
    if ( isAnswerCorrect ) {
    	
    	// search for VIN
    	searchVehicle newSrch = new searchVehicle();
		boolean foundOk = newSrch.isExisting( IVWEB_VIN );
		newSrch.CloseDB();
	
		if( foundOk ) {
			session.setAttribute( "IVWEB_VIN",  IVWEB_VIN ); 
			session.setAttribute( "IVWEB_YEAR", newSrch.getYear() ); 
			session.setAttribute( "IVWEB_MAKE", newSrch.getMake() ); 
			session.setAttribute( "IVWEB_MODEL", newSrch.getModel() ); 
			session.setAttribute( "IVWEB_TRIM", newSrch.getTrim() ); 
			session.setAttribute( "IVWEB_EMAIL", Xemail );
			session.setAttribute( "IVWEB_SECURITY_QUESTION",  newSrch.getQuestion() ); 
			session.setAttribute( "IVWEB_SECURITY_ANSWER",  newSrch.getAnswer() );
			session.setAttribute( "IVWEB_ZIPCODE", newSrch.getZipcode() );
			session.setAttribute( "IVWEB_COUNTRY", newSrch.getCountry() );
			
	    	String goToDataDashBoard = "/ivweb/viewVin.jsp";
	    	response.sendRedirect( goToDataDashBoard );
	    	
		} else {
			
			session.setAttribute( "IVWEB_VIN", null ); 
			session.setAttribute( "IVWEB_YEAR", null ); 
			session.setAttribute( "IVWEB_MAKE", null ); 
			session.setAttribute( "IVWEB_MODEL", null ); 
			session.setAttribute( "IVWEB_TRIM", null ); 
			session.setAttribute( "IVWEB_EMAIL", null );
			session.setAttribute( "IVWEB_SECURITY_QUESTION", null ); 
			session.setAttribute( "IVWEB_SECURITY_ANSWER",  null); 
	    	
			String errorMsg = "<H3>Your " + IVWEB_VIN + " does not match out record ...</H3>";
			//String redirectMsg = "<br>Redirecting to Select Vehicle ...";
			
	    	out.println( errorMsg );
	    	//out.println( redirectMsg );
	    	
	    	
	    	response.setHeader("Refresh", "2; URL=/ivweb/addVin.jsp");
		}
    	 
    } else {
    	
    	session.setAttribute( "IVWEB_VIN", null ); 
		session.setAttribute( "IVWEB_YEAR", null ); 
		session.setAttribute( "IVWEB_MAKE", null ); 
		session.setAttribute( "IVWEB_MODEL", null ); 
		session.setAttribute( "IVWEB_TRIM", null ); 
		session.setAttribute( "IVWEB_EMAIL", null );
		session.setAttribute( "IVWEB_SECURITY_QUESTION", null ); 
		session.setAttribute( "IVWEB_SECURITY_ANSWER",  null); 
    	
		String errorMsg = "<H3>Your answer is incorrect ...</H3>";
		//String redirectMsg = "<br>Redirecting to Select Vehicle ...";
		
    	out.println( errorMsg );
    	//out.println( redirectMsg );
    	
    	String retrievePasswd = "<A href=\"/ivweb/retrievePasswordVO.jsp\">Click to Retrieve Password</A>";
    	
    	%> 
    	<br>
    	<table border="0">
 		<tr>    
    		<%=retrievePasswd%>    		
  		</tr>
		</table>
    	<%
    	response.setHeader("Refresh", "10; URL=/ivweb/selectVehicle.jsp");
    	
    	//out.println( SESSIONEmail + " " + email );
    	//out.println( SESSIONAnswer + " " + answer );
    	        
    } // end if
%>






</font>

</body>
</html>
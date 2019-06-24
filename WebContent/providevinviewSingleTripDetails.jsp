<%@ page language="java" 
    import="com.abrstech.obd2.log.FindVin"
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
%>

<%@ page errorPage="showError.jsp" %>
  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>OBDII logs for this VIN</title>
</head>
<body>

<font face="Georgia, Arial, Garamond" size = "2">
<jsp:include page="dashBoard_SubMenu.jsp" />

<%

	String IVWEB_VIN = (String) session.getAttribute( "IVWEB_VIN" ); // retrieve IVWEB_VIN from HTTP Session
	
	String sessiontimeout = "/ivweb/z_securityquery.jsp";
		
	// check for session timed out
	if( IVWEB_VIN == null ) {
		response.sendRedirect( sessiontimeout );
	}

	String htmlbreak = "<br>";
	String nologfilesmsg = "No OBD2 logs found ...<br>";
		
	String htmlFormBegin = "<form action=\"/ivweb/providevinanalyzeSingleTripDetails.jsp\" method=\"post\">";
	String htmlFormEnd = "</form>";
	String htmlSubmitButton = "<INPUT type=\"submit\" value=\"List OBD2 Parameters for Selected Log\">";

	String htmlRadioBoxStart = "<INPUT type=\"radio\"  name=\"group01\" value=\"";
	String htmlRadioBoxMid01 = "\" >";
	String htmlRadioBoxMid01Checked = "\" checked >";
	
			
	boolean firstRadio = true; // 
	
    if ( IVWEB_VIN == null ) {
        
    	out.println( "<H3>Please click \"Search VIN\" again ...</H3>" );
    	
    } else {
    	   	
        FindVin vinlogs = new FindVin( IVWEB_VIN );
        String[] logs = vinlogs.searchLogs();
        
        if ( logs == null ) {
        	out.println( htmlbreak );
        	out.println( nologfilesmsg );
        } else {        	
        	out.println( htmlbreak );
        	out.println( htmlFormBegin );        	
        	out.println( htmlSubmitButton +  htmlbreak + htmlbreak);
        	
        	for( int i = 0 ; i < logs.length ; i++ ) {
        		if( firstRadio ) {
    				firstRadio = false; 
    				// checked="checked"
    				out.println( htmlRadioBoxStart + logs[i] + htmlRadioBoxMid01Checked + logs[i] + htmlbreak );
    			} else {
    				out.println( htmlRadioBoxStart + logs[i] + htmlRadioBoxMid01 + logs[i] + htmlbreak );	
    			}
        	}
        	
        	out.println( htmlFormEnd );
        }
        
    } // end if
%>

</font>

</body>
</html>
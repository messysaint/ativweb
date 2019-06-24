<%@ page language="java" 
    import="com.abrstech.obd2.log.FindVin, com.abrstech.sql.*,com.abrstech.obd2.security.*"
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
%>

<%@ page errorPage="showError.jsp" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>OBDII logs for this VIN</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script>
function showhide(a)
{
    if(a==1)
    document.getElementById("myhiddenform").style.display="none";
    else
    document.getElementById("myhiddenform").style.display="block";
}
</script>

</head>
<body>

<font face="Georgia, Arial, Garamond" size = "2">
<div id="wrapper" style="width:100%; vertical-align:middle; text-align:center">
<br><br><br><br><br><br>
<br><br><br><br><br><br>
<img src="/ivweb/images/waiting_animation.gif" alt="Processing, please wait ..." height="52" width="52">
<br>
<button onclick="showhide(1)">-</button>
<button onclick="showhide(2)">+</button>
</div> 

<br><br><br><br><br><br>
<br><br><br><br><br><br>
<br><br><br><br><br><br>
<br><br><br><br><br><br>
<br><br><br><br><br><br>
<br><br><br><br><br><br>
<br><br><br><br><br><br>
<br><br><br><br><br><br>
<br><br><br><br><br><br>
<br><br><br><br><br><br>
<br><br><br><br><br><br>
<br><br><br><br><br><br>
<%

String sessiontimeout = "/ivweb/z_securityquery.jsp";

checkAuth check = new checkAuth();

String IsHuman = (String) session.getAttribute( "IVWEB_ISHUMAN" );

if( !check.isLoggedIn( IsHuman ) ) {	// if not logged in, ask user to log in
	response.sendRedirect( sessiontimeout );
}


	String IVWEB_VIN = (String) session.getAttribute( "IVWEB_VIN" ); // retrieve IVWEB_VIN from HTTP Session
	
	
	// check for session timed out
	if( IVWEB_VIN == null ) {
		String errorMsg = "<H3>No vehicle has been selected yet ...</H3>";
    	String redirectMsg = "<br>Redirecting to Select Vehicle ...";
    	
    	out.println( errorMsg );
    	
	}  else {

	String htmlbreak = "<br>";
	String htmlNBSP = "&nbsp;";
	String nologfilesmsg = "<H3>No OBD2 logs found ...</H3><br>";
	String htmlFormBegin = "<form id=\"myhiddenform\" name=\"paramNames\" action=\"/ivweb/notifyRulesStep2.jsp\" method=\"post\">";
	//String htmlFormBegin = "<form action=\"/ivweb/providevinanalyzeMultipleTripDetails.jsp\" method=\"post\">";
	String htmlFormEnd = "</form>";
	String htmlSubmitButton = "<INPUT type=\"submit\" value=\"List OBD2 Parameters for Selected Logs\">";
	
	
			
	String htmlCheckBoxStart = "<INPUT type=\"checkbox\" checked=\"yes\" name=\"";
	String htmlCheckBoxNoStart = "<INPUT type=\"checkbox\" name=\"";
	String htmlCheckBoxMid01 = "\" value=\"";
	String htmlCheckBoxMid02 = "\">";


		int LIMIT = 200;
    	int selectTop = 50;
    	
        
        
        searchVehicleLogs vinlogs = new searchVehicleLogs();
        String[] logs = vinlogs.getLogNames( IVWEB_VIN, LIMIT );
        vinlogs.CloseDB();
        
        if ( logs == null ) {
        	out.println( htmlbreak );
        	out.println( nologfilesmsg );
        } else {        	
        	out.println( htmlbreak );
        	out.println( htmlFormBegin );        	
        	out.println( htmlSubmitButton + htmlbreak + htmlbreak );        	
        	for ( int i = 0 ; i < logs.length ; i++ ) {        		
        		if( i < selectTop ) { // select selectTop
        			out.println( htmlCheckBoxStart + logs[i] + htmlCheckBoxMid01 + logs[i] + htmlCheckBoxMid02 + logs[i] + htmlbreak );	
        		} else {
        			break;
        		}
        		
        	}	
        	out.println( htmlFormEnd );
        }
        
    } // end if
%>

<script>
    document.getElementById("myhiddenform").style.display="none";
</script>


<script type="text/javascript">
window.onload = function() {
   document.forms["paramNames"].submit();
}
</script>

</font>

</body>
</html>
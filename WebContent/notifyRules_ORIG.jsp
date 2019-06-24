<%@ page language="java" 
    import="com.abrstech.obd2.log.*,com.abrstech.obd2.util.*,com.abrstech.obd2.security.*"
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
%>

<%@ page errorPage="showError.jsp" %>
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>OBDII logs for this VIN</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<script type="text/javascript">
function selectParamName() {
	
	var val = "";

	for( i = 0; i < document.paramForm.group01.length; i++ ) {
		if( document.paramForm.group01[i].checked == true )
			val = document.paramForm.group01[i].value;
			document.paramForm.selectedParam.value = val;
		}
	//alert( val );

}

function checkParamName() {
	
	var val = document.paramForm.selectedParam.value;

	if (val==null || val=="") { // null or empty
		alert("Please select a parameter.");
		return false;
	}

}
</script>

</head>
<body>

<font face="Georgia, Arial, Garamond" size = "2">

<%
String sessiontimeout = "/ivweb/z_securityquery.jsp";

checkAuth check = new checkAuth();

String IsHuman = (String) session.getAttribute( "IVWEB_ISHUMAN" );

if( !check.isLoggedIn( IsHuman ) ) {	// if not logged in, ask user to log in
	response.sendRedirect( sessiontimeout );
}
	String htmlbreak = "<br>";
	String htmlNBSP = "&nbsp;";
	String nologfilesmsg = "No OBD2 logs found ...<br><br>";
	
	//String htmlSingleTripDetailsLink   = "[&nbsp;&nbsp;<A href=\"/ivweb/providevinviewSingleTripDetails.jsp\">View Single Trip Details</A>&nbsp;&nbsp;]";
	
	//String vin = (String) session.getAttribute( "IVWEB_VIN" ); 
	
	String IVWEB_VIN = (String) session.getAttribute( "IVWEB_VIN" ); // retrieve IVWEB_VIN from HTTP Session
	String SESSIONYear = (String) session.getAttribute( "IVWEB_YEAR" );
	String SESSIONMake = (String) session.getAttribute( "IVWEB_MAKE" );
	String SESSIONModel = (String) session.getAttribute( "IVWEB_MODEL" );
	String SESSIONEmail = (String) session.getAttribute( "IVWEB_EMAIL" );
	String SESSIONAnswer = (String) session.getAttribute( "IVWEB_SECURITY_ANSWER" );
	String SESSIONZipcode = (String) session.getAttribute( "IVWEB_ZIPCODE" );
	
	
    if ( IVWEB_VIN == null ) {
        
    	String errorMsg = "<H3>No vehicle has been selected yet ...</H3>";
    	String redirectMsg = "<br>Redirecting to Select Vehicle ...";
    	
    	out.println( errorMsg );
    	//out.println( redirectMsg );
    	
    	//response.setHeader("Refresh", "2; URL=/ivweb/selectVehicle.jsp");
    	
    } else {
    	
%>
<table width="100%"> 
  <tr>
    <td width="40%">
<%    	

        FindVin vinlogs = new FindVin( IVWEB_VIN );
        String[] logs = vinlogs.searchVIN();
        
        
        if ( logs == null ) {
        	out.println( htmlbreak );
        	out.println( nologfilesmsg );
        	//String backToMyAutoMechanic = "http://autotalky.com/what-is-needed/";
        	//response.sendRedirect( backToMyAutoMechanic );
        } else {        	        	
        	
        	LogReaderCSVData csv = new LogReaderCSVData(); // single instance - store data
        	LogLineValidator validator = new LogLineValidator();
        	
        	csv.readLogFile( logs[0] );

     		String[] headers = csv.getColumnHeaders();
     		String[] data = csv.getRowData();
     		
     		String htmlFormBegin = "<form name=\"paramForm\" action=\"/ivweb/activeNotificationParameterEntryForm.jsp\" onsubmit=\"return checkParamName()\" method=\"post\">";
     		String htmlFormEnd = "</form>";
     		String htmlSubmitButton = "<INPUT type=\"submit\" value=\"Select Parameter to Monitor\">";
     		
			String htmlHiddenText = "<input type=\"hidden\" name=\"selectedParam\" value=\"\">";
     		
     		String htmlRadioBoxStart = "<INPUT type=\"radio\"  name=\"group01\" value=\"";
     		String htmlRadioBoxMid01 = "\" onclick=\"selectParamName()\" >";
     		String htmlRadioBoxMid01Checked = "\" checked  onclick=\"selectParamName()\" >";
     		String htmlRadioBoxMid01Disabled = "\" DISABLED >";

     		boolean firstRadio = true; // 

     		out.println(htmlbreak);
     		out.println(htmlFormBegin);
     		out.println(htmlSubmitButton + htmlbreak + htmlbreak);

     		//out.println( "Using " + logs[0] + htmlbreak );
     		
     		Float total = 0.00F; // data totals used to disable radio button if 0.00F
     		
     		//Arrays.sort( headers, Collections.reverseOrder() );
     		//Arrays.sort( headers );
     		
     		for (int i = 0; i < headers.length; i++) { 			 			
     			
     			if (firstRadio) {
     	 			firstRadio = false;
     	 			// checked="checked"
     	 			if( validator.hasOBD2Values( data[i] ) ) {
     	 				out.println( htmlRadioBoxStart + headers[i] + htmlRadioBoxMid01Checked + headers[i] + htmlbreak );	
     	 			} else {
     	 				//out.println( htmlRadioBoxStart + headers[i] + htmlRadioBoxMid01Disabled + headers[i] + htmlbreak );
     	 			}
     	 			
     	 		} else {
     	 			
     	 			if( validator.hasOBD2Values( data[i] ) ) {
     	 				out.println( htmlRadioBoxStart + headers[i] + htmlRadioBoxMid01 + headers[i] + htmlbreak );	
     	 			} else {
     	 				//out.println( htmlRadioBoxStart + headers[i] + htmlRadioBoxMid01Disabled + headers[i] + htmlbreak );
     	 			}
     	 			
     	 		}

     	 		
     		} 		

     		out.println( htmlHiddenText + htmlbreak);
     		out.println(htmlFormEnd); // end form
        }
        
        
    
%>

    </td>
    <td width="60%" valign="top">
    <table width="100%" >
      <tr>
        <td width="50%">
          <iframe src="/ivweb/activeNotificationAddresses.jsp" frameborder="1" align="middle" width="100%" height="160px"> </iframe>
        </td>
      </tr>
      <tr>
        <td width="50%">
          <iframe src="/ivweb/activeNotificationRules.jsp" frameborder="1" align="middle" width="100%" height="600px"> </iframe>
        </td>
     </tr>
    </table>
      
    </td>
  </tr>
</table>


</font>

<%
    } // end if
%>
</body>
</html>
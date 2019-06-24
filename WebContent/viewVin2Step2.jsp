<%@ page language="java" 
    import="com.abrstech.obd2.log.*,java.util.*,java.io.IOException,java.util.*,java.util.Collections,com.abrstech.sql.*,com.abrstech.obd2.util.*"
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
%>

<%@ page errorPage="showError.jsp" %>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>

<title>Analyze OBDII Data for this VIN</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="/ivweb/reports/awe/mystyle.css" />
<script type="application/javascript" src="/ivweb/reports/awe/awesomechart.js"> </script>

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
	 
	
	String IVWEB_VIN = (String) session.getAttribute( "IVWEB_VIN" ); // retrieve IVWEB_VIN from HTTP Session
		String sessiontimeout = "/ivweb/z_securityquery.jsp";
	// check for session timed out
	if( IVWEB_VIN == null ) {
		response.sendRedirect( sessiontimeout );
	}
	
	String htmlbreak = "<br>";
	Enumeration parameterList = request.getParameterNames();	
	
	Float[] totals = null;
	Float[] averages = null;
	
	int logLines = 0;
	
	ArrayList logDatalist = new ArrayList();
		
	while( parameterList.hasMoreElements() ) {
		logDatalist.add( parameterList.nextElement().toString() ); 
	}
			
	String[] logFileNames = (String[]) logDatalist.toArray( new String[ logDatalist.size() ] ); 
	
	//for( int i = 0 ; i < logFileNames.length ; i++ ) {
	//	out.println( logFileNames[ i ] + htmlbreak);
	//}
	
	
	// pass log file names to search in database
	// search here and return get data string here
	
	searchVehicleLogs searchLogs = new searchVehicleLogs(); // open DB connection
	String[] dataString = searchLogs.getLogData(IVWEB_VIN, logFileNames ); // get data strings
	searchLogs.CloseDB(); // close DB connection
	
	
	
	//LogLineValidator lineVal = new LogLineValidator();
	LogLineValidator lineVal = new LogLineValidator();
	CollateObd2Data cod = new CollateObd2Data();
	

	// process each log file
	for( int i = 0 ; i < dataString.length ; i++ ) {
	
		lineVal.parseDataStringFromDB( dataString[i] );
		cod.addOBD2DataHeader( lineVal.getOBD2HeaderNames(), lineVal.getOBD2AvgData() );
			
	} //  end for
		
		
	// test CollateObd2Data						
	ArrayList al = cod.getHeaderOBD2Data();  
	ArrayList tmp = null;
	Iterator iter = al.iterator();
						
	//String htmlFormBegin = "<form action=\"/ivweb/providevingraphitMultipleTripDetails.jsp\" method=\"post\">";
	String htmlFormBegin = "<form id=\"myhiddenform\" name=\"paramNames\" action=\"/ivweb/dashBoardToggleGraphMain2.jsp\" method=\"post\">";
	
	String htmlFormEnd = "</form>";
	String htmlSubmitButton = "<INPUT type=\"submit\" value=\"View Graph of Selected Data\">";
	
	//String htmlRadioBoxStart = "<INPUT type=\"radio\"  name=\"group01\" value=\"";
	String htmlRadioBoxStart = "<INPUT type=\"checkbox\"  name=\"";
	String htmlRadioBoxValue = "\" value=\"";
	
	String htmlRadioBoxMid01 = "\" >";
	String htmlRadioBoxMid01Checked = "\" checked >";
	String htmlRadioBoxMid01Disabled = "\" DISABLED >";
	
	String displayValue = new String();
	String dataValue = new String();
	
	boolean firstRadio = true; // 
	
	String H3_YES = "<h3>Search for Vehicle Data:</h3>";
	
	String viewOtherData = "[&nbsp; <A href=\"/ivweb/providevinview.jsp\">View Other OBD2 Parameters</A> &nbsp;] "; 
	
	
	// BEGIN Get Notification Parameter Names
	searchNotifications srchNotifyParameters = new searchNotifications();
	ArrayList notifyParams = srchNotifyParameters.getSearchNotifications( IVWEB_VIN );
	srchNotifyParameters.CloseDB();	
	// END  Get Notification Parameter Names
	
	
	
	// display selection to graph
	//out.println( "<h3>VIN: " + IVWEB_VIN + "</h3>" );
	out.println( htmlbreak );
    out.println( htmlFormBegin );        	
    out.println( htmlSubmitButton +  htmlbreak + htmlbreak);
    
	while( iter.hasNext() ) {
		
		Float total = 0.00F;
		
		tmp = (ArrayList) iter.next();
				
		// displayValue = (String) tmp.get( 0 );									
		displayValue = tmp.get( 0 ).toString().trim();
				
		if( notifyParams.contains( displayValue ) ) { // only include parameters in notification rules
			// gather data values
			for( int iii = 1 ; iii != tmp.size() ; iii++ ) {
				dataValue += (Float) tmp.get( iii );
				total     += (Float) tmp.get( iii );
				if( iii < (tmp.size()-1) ) {
					dataValue += " | ";
				}
			}						
			
			out.println( htmlRadioBoxStart + displayValue + htmlRadioBoxValue + dataValue + htmlRadioBoxMid01Checked + displayValue + htmlbreak );			
		}
			
		
		dataValue = ""; // reset
	}	
	out.println( htmlFormEnd );
	
					
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

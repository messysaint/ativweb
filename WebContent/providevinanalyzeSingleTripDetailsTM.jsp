<%@ page language="java"
	import="com.abrstech.obd2.log.*,java.util.*,java.io.IOException,com.abrstech.obd2.util.*,java.util.Arrays,java.util.Collections"
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page errorPage="showError.jsp" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>

<title>Analyze OBDII Data for this VIN</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css"
	href="/ivweb/reports/awe/mystyle.css" />
<script type="application/javascript"
	src="/ivweb/reports/awe/awesomechart.js"> </script>

</head>

<body>

<font face="Georgia, Arial, Garamond" size="2"> 
<jsp:include page="dashBoard_SubMenuTM.jsp" />
<BR>
	
<%
 	
	String IVWEB_VIN = (String) session.getAttribute( "IVWEB_VIN" ); // retrieve IVWEB_VIN from HTTP Session
	
	String sessiontimeout = "/ivweb/z_securityqueryTM.jsp";
	
	// check for session timed out
	if( IVWEB_VIN == null ) {
		response.sendRedirect( sessiontimeout );
	}
	
	String htmlbreak = "<br>";
 	Enumeration parameterList = request.getParameterNames();

 	// LogReaderCSV csv = new LogReaderCSV( true ); // single instance - store data
 	LogReaderCSVData csv = new LogReaderCSVData(); // single instance - store data

 	String[] headers = null;
 	String[] data = null;
	LogLineValidator validator = new LogLineValidator();
	
 	int logLines = 0;

 	String groupName = parameterList.nextElement().toString();
 	//String[] sName =  request.getParameterValues( groupName );  
 	String sName = request.getParameter(groupName);

 	// process each log file

 	try {

 		csv.readLogFile(sName);

 		headers = csv.getColumnHeaders();
 		data = csv.getRowData();
 		logLines = csv.getNumberOfLogLines();

 		// set as session header
 		//session.setAttribute("logLines", logLines);
 		//for (int i = 0; i < headers.length; i++) {
 		//	session.setAttribute(headers[i], data[i]);
 		//}

 		// print groupname / value / displayvalue
 		//out.println("<h3>VIN: " + IVWEB_VIN + "</h3>");
 		out.println("OBD2 Log File: " + sName + htmlbreak);
 		out.println("Log Line count: " + logLines + htmlbreak );

 		//String htmlFormBegin = "<form action=\"/ivweb/providevingraphitSingleTripDetails.jsp\" method=\"post\">";
 		String htmlFormBegin = "<form action=\"/ivweb/dashBoardToggleGraphTM.jsp\" method=\"post\">";
 		
 		String htmlFormEnd = "</form>";
 		String htmlSubmitButton = "<INPUT type=\"submit\" value=\"View Graph of Selected Data\">";

 		//String htmlRadioBoxStart = "<INPUT type=\"radio\"  name=\"group01\" value=\"";
 		String htmlRadioBoxStart = "<INPUT type=\"checkbox\"  name=\"";
 		String htmlRadioBoxValue = "\" value=\"";
 		
 		String htmlRadioBoxMid01 = "\" >";
 		String htmlRadioBoxMid01Checked = "\" checked >";
 		String htmlRadioBoxMid01Disabled = "\" DISABLED >";

 		boolean firstRadio = true; // 

 		out.println(htmlbreak);
 		out.println(htmlFormBegin);
 		out.println(htmlSubmitButton + htmlbreak + htmlbreak);

 		Float total = 0.00F; // data totals used to disable radio button if 0.00F
 		
 		//Arrays.sort( headers, Collections.reverseOrder() );
 		//Arrays.sort( headers );
 		
 		for (int i = 0; i < headers.length; i++) { 			 			
 			
 			if (firstRadio) {
 	 			firstRadio = false;
 	 			// checked="checked"
 	 			if( validator.hasOBD2Values( data[i] ) ) {
 	 				out.println(htmlRadioBoxStart + headers[i] + htmlRadioBoxValue + data[i] + htmlRadioBoxMid01Checked + headers[i] + htmlbreak);	
 	 			} else {
 	 				//out.println(htmlRadioBoxStart + data[i] + htmlRadioBoxMid01Disabled + headers[i] + htmlbreak);
 	 			}
 	 			
 	 		} else {
 	 			
 	 			if( validator.hasOBD2Values( data[i] ) ) {
 	 				out.println(htmlRadioBoxStart + headers[i] + htmlRadioBoxValue  + data[i] + htmlRadioBoxMid01 + headers[i] + htmlbreak);	
 	 			} else {
 	 				//out.println(htmlRadioBoxStart + data[i] + htmlRadioBoxMid01Disabled + headers[i] + htmlbreak);
 	 			}
 	 			
 	 		}

 	 		
 		} 		

 		out.println(htmlFormEnd); // end form

 	} catch (IOException e) {
 		// TODO Auto-generated catch block
 		out.println(e.toString());
 	}
 %>

	</font>


</body>
</html>
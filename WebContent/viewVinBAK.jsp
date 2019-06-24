<%@ page language="java"
	import="com.abrstech.obd2.security.*,com.abrstech.obd2.log.*,com.abrstech.sql.*,java.util.*,java.io.IOException,java.util.*,java.util.Collections,com.abrstech.obd2.util.*"
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


<%


String H3_YES = "<h3>Search for Vehicle Data:</h3>";

String sessiontimeout = "/ivweb/z_securityquery.jsp";

String viewOtherData = "[&nbsp; <A href=\"/ivweb/providevinview.jsp\">View Other OBD2 Parameters</A> &nbsp;] "; 

checkAuth check = new checkAuth();

String IsHuman = (String) session.getAttribute( "IVWEB_ISHUMAN" );

if( !check.isLoggedIn( IsHuman ) ) {	// if not logged in, ask user to log in
	response.sendRedirect( sessiontimeout );
} 

String IVWEB_VIN = (String) session.getAttribute( "IVWEB_VIN" ); // retrieve IVWEB_VIN from HTTP Session
String SESSIONYear = (String) session.getAttribute( "IVWEB_YEAR" );
String SESSIONMake = (String) session.getAttribute( "IVWEB_MAKE" );
String SESSIONModel = (String) session.getAttribute( "IVWEB_MODEL" );
String SESSIONEmail = (String) session.getAttribute( "IVWEB_EMAIL" );
String SESSIONAnswer = (String) session.getAttribute( "IVWEB_SECURITY_ANSWER" );
String SESSIONZipcode = (String) session.getAttribute( "IVWEB_ZIPCODE" );


// check for session timed out
if( IVWEB_VIN == null ) {
	String errorMsg = "<H3>No vehicle has been selected yet ...</H3>";
	String redirectMsg = "<br>Redirecting to Select Vehicle ...";
	
	out.println( errorMsg );
	
} else {
	


%>

	<table border="0">
		<tr>
			<th><%=viewOtherData%></th>
		</tr>
		<tr>
			<th>&nbsp;</th>
		</tr>
	</table>

<%
	//-------------------------------
	//STEP 1:  get Notification Parameter Names
	//

		
		searchNotifications srchNotify = new searchNotifications();
		ArrayList notifyParamNames = srchNotify.getSearchNotifications( IVWEB_VIN );		
		srchNotify.CloseDB();

		
		//PRINT notification parameters
		//for( int i = 0 ; i < notifyParamNames.length ; i++ ) {			
		//	out.println( "<BR>" + notifyParamNames[i] );
		//}
		
		
		if ( notifyParamNames.size() == 0 ) {

			String errorMsg = "<H3>No Notification Rules set yet ...</H3>";
						
			out.println( errorMsg );
			
		} else {

			//-------------------------------
			//STEP 2:  Find log files
			//

			int selectTop = 50;

			searchVehicleLogs vinlogs = new searchVehicleLogs();
			String[] logs = vinlogs.getLogNames(IVWEB_VIN);
			vinlogs.CloseDB(); // close DB connection

			String[] logFileNames = null;

			//pls limit to selectTop
			if (logs.length > selectTop) {
				logFileNames = new String[selectTop];
				for (int i = 0; i < selectTop; i++) {
					logFileNames[i] = logs[i];
				}
			} else {
				logFileNames = logs;
			}

			//PRINT log file name
			//for( int i = 0 ; i < logFileNames.length ; i++ ) {
			//	out.println( "<br>Log Name: " + logFileNames[i]  ); 
			//}

			//-------------------------------
			//STEP 3: Generate Arraylist
			//

			Float[] totals = null;
			Float[] averages = null;

			int logLines = 0;

			// pass log file names to search in database
			// search here and return get data string here

			searchVehicleLogs searchLogs = new searchVehicleLogs(); // open DB connection
			String[] dataString = searchLogs.getLogData(IVWEB_VIN, 	logFileNames); // get data strings

			//PRINT Data String
			//for( int i = 0 ; i < dataString.length ; i++) {
			//	out.println( "<br><br>Data String: " + dataString[i]  );
			//}

			//LogLineValidator lineVal = new LogLineValidator();
			LogLineValidator lineVal = new LogLineValidator();
			CollateObd2Data cod = new CollateObd2Data();

			// process each log file
			for (int i = 0; i < dataString.length; i++) {

				lineVal.parseDataStringFromDB(dataString[i]);
				cod.addOBD2DataHeader(lineVal.getOBD2HeaderNames(),
						lineVal.getOBD2AvgData());

			} //  end for

			// test CollateObd2Data						
			ArrayList al = cod.getHeaderOBD2Data();
			ArrayList tmp = null;
			Iterator iter = al.iterator();
			
			

			String ParamName = new String();
			String dataValue = new String();

			//out.println( "<br><br> Start Iterator ..."  );
			// HTML Form layout
			String htmlbreak = "<br>";
			String htmlFormBegin = "<form action=\"/ivweb/dashBoardToggleGraph.jsp\" method=\"post\">";
			String htmlFormEnd = "</form>";
			String htmlSubmitButton = "<INPUT type=\"submit\" value=\"View Graph of Selected Data\">";
	
			String htmlRadioBoxStart = "<INPUT type=\"checkbox\"  name=\"";
			String htmlRadioBoxValue = "\" value=\"";
	
			String htmlRadioBoxMid01 = "\" >";
			String htmlRadioBoxMid01Checked = "\" checked >";

			out.println( htmlbreak );
			out.println( htmlFormBegin );        	
			out.println( htmlSubmitButton +  htmlbreak + htmlbreak);
			// HTML Form layout
			
			
			int i = 0;
			while (iter.hasNext()) {

				Float total = 0.00F;

				tmp = (ArrayList) iter.next();

				ParamName = (String) tmp.get(0);

				if( notifyParamNames.contains( ParamName ) ) {
					
					// gather data values
					for (int iii = 1; iii != tmp.size(); iii++) {
						//dataValue += (Float) tmp.get(iii);
						dataValue += tmp.get(iii);
						//total += (Float) tmp.get(iii);
						if (iii < (tmp.size() - 1)) {
							dataValue += " | ";
						}
					}
					
					
					
					out.println( htmlRadioBoxStart + ParamName + htmlRadioBoxValue + dataValue + htmlRadioBoxMid01Checked + ParamName + htmlbreak );
					//out.println( htmlRadioBoxStart + ParamName + htmlRadioBoxValue + dataValue + htmlRadioBoxMid01 + ParamName + htmlbreak );
					
					
					
					i++;
					
				} 
				
				
			} // end while
			
			out.println( htmlFormEnd );
				
			//out.println( "<br><br> End Iterator ..."  );	

			
		} // endif
		
		
	}
%>



</body>

</html>
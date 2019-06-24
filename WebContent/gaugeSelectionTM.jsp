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
<jsp:include page="dashBoard_SubMenuTM.jsp" />

<%
	 
	
	String IVWEB_VIN = (String) session.getAttribute( "IVWEB_VIN" ); // retrieve IVWEB_VIN from HTTP Session
	String sessiontimeout = "/ivweb/z_securityqueryTM.jsp";
	// check for session timed out
	if( IVWEB_VIN == null ) {
		response.sendRedirect( sessiontimeout );
	}
	
	//get notify parameters
	searchNotifications srchNotifyParameters = new searchNotifications();
	ArrayList notifyParams = srchNotifyParameters.getSearchNotifications( IVWEB_VIN );
	srchNotifyParameters.CloseDB();	
		
	// -----------------------------------------------------------------------	
	String htmlbreak = "<br>";
	
						
	//String htmlFormBegin = "<form action=\"/ivweb/providevingraphitMultipleTripDetails.jsp\" method=\"post\">";
	String htmlFormBegin = "<form id=\"myhiddenform\" name=\"paramNames\" action=\"/ivweb/saveGaugeSelection.jsp\" method=\"post\">";
	
	String htmlFormEnd = "</form>";
	String htmlSubmitButton = "<INPUT type=\"submit\" value=\"Save Gauge Selections\">";
	
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
	
	//String viewOtherData = "[&nbsp; <A href=\"/ivweb/providevinview.jsp\">View Other OBD2 Parameters</A> &nbsp;] "; 
	
	
	// BEGIN Get Notification Parameter Names
	//searchNotifications srchNotifyParameters = new searchNotifications();
	//ArrayList notifyParams = srchNotifyParameters.getSearchNotifications( IVWEB_VIN );
	//srchNotifyParameters.CloseDB();	
	// END  Get Notification Parameter Names
	
	
	
	// display selection to graph
	//out.println( "<h3>VIN: " + IVWEB_VIN + "</h3>" );
	out.println( htmlbreak );
    //out.println( htmlFormBegin );        	
    //out.println( htmlSubmitButton +  htmlbreak + htmlbreak);

    String option = "<option value=\"" + "None" + "\" >" + "None" + "</option>";
    
    Iterator iterNotify = notifyParams.iterator();
    
    //while( iter.hasNext() ) {
    while( iterNotify.hasNext() ) {
		
		Float total = 0.00F;
		
		//tmp = (ArrayList) iter.next();
				
		//displayValue = (String) tmp.get( 0 );									
		displayValue = (String) iterNotify.next();
					
		// show only params that are set to notify
		//if( notifyParams.contains( displayValue ) ) {
			option += "<option value=\"" + displayValue + "\" >" + displayValue + "</option>";	
		//}
		
		dataValue = ""; // reset
	}	
    
    %>
    
<h2>Select Parameters for your Gauges:</h2>
<br>

<form name="verifyidentity" action="/ivweb/saveGaugeSelectionToDBTM.jsp" method="post">

<table border="0">

  <tr>
    <td>Param01: &nbsp;</td>
    <td>
    <select name="gauge01" size="1">
    <%=option%>
	</select>
    </td>
  </tr>
  
  <tr>
    <td>Param02: &nbsp;</td>
    <td>
    <select name="gauge02" size="1">
    <%=option%>
	</select>
    </td>
  </tr>
  
  <tr>
    <td>Param03: &nbsp;</td>
    <td>
    <select name="gauge03" size="1">
    <%=option%>
	</select>
    </td>
  </tr>
  
  <tr>
    <td>Param04: &nbsp;</td>
    <td>
    <select name="gauge04" size="1">
    <%=option%>
	</select>
    </td>
  </tr>
  
  <tr>
    <td>Param05: &nbsp;</td>
    <td>
    <select name="gauge05" size="1">
    <%=option%>
	</select>
    </td>
  </tr>
  
  <tr>
    <td>Param06: &nbsp;</td>
    <td>
    <select name="gauge06" size="1">
    <%=option%>
	</select>
    </td>
  </tr>
  
</table> 

<br>
<br>

<INPUT type="submit" value="Save Gauge Selections">

</form>

    
</font>
    
</body>
</html>

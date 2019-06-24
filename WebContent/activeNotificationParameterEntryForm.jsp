<%@ page language="java"
	import = "com.abrstech.obd2.log.*,java.util.*,com.abrstech.obd2.security.*,com.abrstech.sql.*,com.abrstech.obd2.util.*" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
%>
    
<%@ page errorPage="showError.jsp" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Provide VIN</title>

<script type="text/javascript">
function validateNotificationParameterForm() {
	
	var baseline = document.addnewnotificationparameter.baseline.value;
	var upperlimit = document.addnewnotificationparameter.upperlimit.value;
	var upperlimitmessage = document.addnewnotificationparameter.upperlimitmessage.value;
	var lowerlimit = document.addnewnotificationparameter.lowerlimit.value;
	var lowerlimitmessage = document.addnewnotificationparameter.lowerlimitmessage.value;
	
	if (baseline==null || baseline=="") { // null or empty
		alert("Please enter baseline value.");
		return false;
	}

	if ( isNaN(baseline) ) { // null or empty
		alert("Please enter baseline value.");
		return false;
	}
	
	if (upperlimit==null || upperlimit=="") { // null or empty
		alert("Please enter upper limit value.");
		return false;
	}
	
	if ( isNaN(upperlimit) ) { // null or empty
		alert("Please enter upper limit value.");
		return false;
	}
	
	if (upperlimitmessage==null || upperlimitmessage=="") { // null or empty
		alert("Please enter upper limit threshold message value.");
		return false;
	}
	
	if (lowerlimit==null || lowerlimit=="") { // null or empty
		alert("Please enter lower limit value.");
		return false;
	}
	
	if ( isNaN(lowerlimit) ) { // null or empty
		alert("Please enter lower limit value.");
		return false;
	}
	
	if (lowerlimitmessage==null || lowerlimitmessage=="") { // null or empty
		alert("Please enter lower limit threshold message value.");
		return false;
	}
	
	return confirm('Do you want to save this record?');
	
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
} else { 
	
%>


<% 
String IVWEB_VIN = (String) session.getAttribute( "IVWEB_VIN" );


if( IVWEB_VIN == null ) {
	response.sendRedirect( sessiontimeout );
} 

String paramName = (String) request.getParameter( "selectedParam" );
session.setAttribute( "IVWEB_OBD2PARAM", paramName ); // create HTTP SESSION header "IVWEB_OBD2PARAM"

int numberOfLogsToConsider = 50;
 
searchVehicleLogs searchLogs = new searchVehicleLogs(); // open DB connection
String[] dataString = searchLogs.getLogDataLatest(IVWEB_VIN, numberOfLogsToConsider ); // get data strings
searchLogs.CloseDB(); // close DB connection

//LogLineValidator lineVal = new LogLineValidator();
LogLineValidator lineVal = new LogLineValidator();
CollateObd2Data cod = new CollateObd2Data();
	

// process each log file
for( int i = 0 ; i < dataString.length ; i++ ) {	
	lineVal.parseDataStringFromDB( dataString[i] );
	cod.addOBD2DataHeader( lineVal.getOBD2HeaderNames(), lineVal.getOBD2AvgData() );
			
} //  end for
	
//test CollateObd2Data						
ArrayList al = cod.getHeaderOBD2Data();  
ArrayList tmp = null;
Iterator iter = al.iterator();
	
String displayValue = new String();
Float dataValue = 0.0F;
Float maxValue = 0.0F;
Float minValue = 0.0F;
Float tempValue = 0.0F;

while( iter.hasNext() ) {

	tmp = (ArrayList) iter.next();
			
	displayValue = (String) tmp.get( 0 );									
			
	if( paramName.equalsIgnoreCase( displayValue ) ) {
		// gather data values
		for( int i = 1 ; i != tmp.size() ; i++ ) {
			tempValue = (Float) tmp.get( i );
			dataValue += tempValue;
			if( i == 1 ) { // make first value the max and min
				maxValue = minValue = tempValue;
			}
			if( tempValue > maxValue ) { // save max 
				maxValue = tempValue;
			}
			if( tempValue < minValue ) { // save min
				minValue = tempValue;
			}
		}	
		dataValue = dataValue / (tmp.size()-1);
		break;
	}
							
	
}	




%>

<form name="addnewnotificationparameter" action="/ivweb/saveNewNotificationParameterToDB.jsp" onsubmit="return validateNotificationParameterForm()" method="post">

<br>

<table border="0">

  <tr>
    <td>Parameter Name: &nbsp; </td>
    <td> <%=paramName%> </td>
  </tr>
  
  <tr>
    <td>Maximum (<%=numberOfLogsToConsider %> trips) Value: &nbsp; </td>
    <td> <%=maxValue%> </td>
  </tr>
  
  <tr>
    <td>Average (<%=numberOfLogsToConsider %> trips) Value: &nbsp; </td>
    <td> <%=dataValue%> </td>
  </tr>
  
  <tr>
    <td>Minimum (<%=numberOfLogsToConsider %> trips) Value: &nbsp; </td>
    <td> <%=minValue%> </td>
  </tr>
  
  <tr>
    <td> &nbsp; </td>
    <td> &nbsp; </td>
  </tr>
  
  <tr>
    <td>Set Baseline Value: &nbsp;</td>
    <td><input type="text" name="baseline"   maxlength="10" size="10" value="<%=dataValue%>"/> </td>
  </tr>
  
  <tr>
    <td>Set Threshold Upper Limit: &nbsp;</td>
    <td><input type="text" name="upperlimit" maxlength="10" size="10" value="<%=maxValue%>"/> </td>
  </tr>

  <tr>
    <td>Upper Limit Threshold Message: &nbsp;</td>
    <td><input type="text" name="upperlimitmessage"   maxlength="200" size="50" value=""/> </td>
  </tr>
  
  <tr>
    <td>Set Threshold Lower Limit: &nbsp;</td>
    <td><input type="text" name="lowerlimit" maxlength="10" size="10" value="<%=minValue%>"/> </td>
  </tr>
  
  <tr>
    <td>Lower Limit Threshold Message: &nbsp;</td>
    <td><input type="text" name="lowerlimitmessage"   maxlength="200" size="50" value=""/> </td>
  </tr>
  
  <tr>
    <td>Send Type: &nbsp;</td>
    <td>
       <select name="sendtype" size="1">
        <option value="individual">Send as individual notification</option>
        <option value="group">Send as part of group notification</option>
       </select>
     </td>
  </tr>

</table> 
    
<br>
<br>

<INPUT type="submit" value="Save this Notification Rule">
</form>

<%
}
%>


</font>

</body>
</html>

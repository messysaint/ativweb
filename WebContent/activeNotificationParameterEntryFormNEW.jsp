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
<jsp:include page="dashBoard_SubMenu.jsp" />

<%


String sessiontimeout = "/ivweb/z_securityquery.jsp";

checkAuth check = new checkAuth();

String IsHuman = (String) session.getAttribute( "IVWEB_ISHUMAN" );

if( !check.isLoggedIn( IsHuman ) ) {	// if not logged in, ask user to log in
	response.sendRedirect( sessiontimeout );
} else { 
	

String IVWEB_VIN = (String) session.getAttribute( "IVWEB_VIN" );

if( IVWEB_VIN == null ) {
	response.sendRedirect( sessiontimeout );
} 

String selectedParam = (String) request.getParameter( "selectedParam" );
StringTokenizer selectedParamTokens = new StringTokenizer( selectedParam, "|" );

String tmp = new String();
String paramName = new String();
String paramValue[] = new String[ selectedParamTokens.countTokens()-1 ];



int i = 0;
while( selectedParamTokens.hasMoreTokens() ) {

	tmp = selectedParamTokens.nextToken().trim();
	if( i == 0) {
		paramName = tmp;		
	} else {
		paramValue[i-1] = tmp;				
	}
	i++;
}

session.setAttribute( "IVWEB_OBD2PARAM", paramName ); // create HTTP SESSION header "IVWEB_OBD2PARAM"

		
// String displayValue = new String();
float tempValue = 0.0F;
float Total = 00.00F;

float dataValue = 0.0F;
float maxValue = 0.0F;
float minValue = 0.0F;

int len = paramValue.length;


String data = new String();

for( int x = 0 ; x < len ; x++ ) {
	
	//data += paramValue[x];
	
	tempValue = new Float( paramValue[x] ).floatValue();
	
	if( x == 0 ) {
		Total = tempValue;
		dataValue = tempValue;
		maxValue = tempValue;
		minValue = tempValue;  // initialize
	} else {
		Total += tempValue;
		if( tempValue < minValue ) {
			minValue = tempValue;
		} else if( tempValue > maxValue ) {
			maxValue = tempValue;
		}
	}	
	
}
dataValue = Total / len;


%>

<form name="addnewnotificationparameter" action="/ivweb/saveNewNotificationParameterToDBNEW.jsp" onsubmit="return validateNotificationParameterForm()" method="post">

<br>

<table border="0">

  <tr>
    <td>Parameter Name: &nbsp; </td>
    <td> <%=paramName%> </td>
  </tr>
  
  <tr>
    <td>Maximum Value: &nbsp; </td>
    <td> <%=maxValue%> </td>
  </tr>
  
  <tr>
    <td>Average Value: &nbsp; </td>
    <td> <%=dataValue%> </td>
  </tr>
  
  <tr>
    <td>Minimum Value: &nbsp; </td>
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

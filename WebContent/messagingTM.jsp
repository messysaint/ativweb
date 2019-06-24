<%@ page language="java" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import = "com.abrstech.obd2.security.*"
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>debug</title>

	<script type="text/javascript" src="/ivweb/jscript/validateMessageForm.js"></script>
</head>
<body>
<font face="Georgia, Arial, Garamond" size = "2">

 
<% // declare variables
   
String sessiontimeout = "/ivweb/z_securityqueryTM.jsp";

//String loginAutoBusiness = "&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp; <A href=\"/ivweb/marketPlaceMoreDetailsTM.jsp\">My Service Locations</A> &nbsp;]";
//String loginAutoOwner = "&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp; <A href=\"/ivweb/marketPlaceVehicleOwner.jsp\">Vehicle Owner</A> &nbsp;]";

checkAuth check = new checkAuth();

String IsHuman = (String) session.getAttribute( "IVWEB_ISHUMAN" );

if( !check.isLoggedIn( IsHuman ) ) {	// if not logged in, ask user to log in
	response.sendRedirect( sessiontimeout );
} 

// get selected vehicle info
String IVWEB_VIN = (String) session.getAttribute( "IVWEB_VIN" ); // retrieve IVWEB_VIN from HTTP Session
Integer IVWEB_SEQNO = (Integer) session.getAttribute( "IVWEB_SEQNO" ); // retrieve IVWEB_VIN from HTTP Session

// get selected business info
String SESSIONBusinessname = (String) session.getAttribute( "IVWEB_BUSINESSNAME" );
String SESSIONBusinessmail = (String) session.getAttribute( "IVWEB_BUSINESSEMAIL" ); 


// check for session timed out
if( IVWEB_SEQNO == null ) {
	String errorMsg = "<H3>No Trusted Mechanic has been selected yet ...</H3>";
	//String redirectMsg = "<br>Redirecting to Select Trusted Mechanic...";
	
	out.println( errorMsg );
	
} else {

	if( IVWEB_VIN == null ) {
		IVWEB_VIN = "No Selected Vehicle";
	}
%>
 


<table border="0">
  	 <tr>
   	    <th><h3>Send Message </h3></th>   	    
   	 </tr>  
</table>
    
	
<form name="messageForm" action="/ivweb/saveNewMessageToDB.jsp" onsubmit="return validateMessageForm()" method="post">

<table border="0">

  <tr>
      <td>From: &nbsp; </td>
      <td><%=SESSIONBusinessname %> &nbsp; </td>
  </tr>
  
  <tr>
      <td>To: &nbsp; </td>
      <td>
		<select name="targetAudience" size="1">
		    <option value="<%=IVWEB_VIN %>" selected="selected"><%=IVWEB_VIN %></option>
		    <option value="trustfleet">Your Trust Fleet Members Only</option>
			<option value="allinservicearea">All Vehicle Owners in your Serviced ZIP Codes</option>						
		</select>
	  </td>
  </tr>
  
  <tr>
      <td>Subject: &nbsp; </td>
      <td> <input type="text" name="subject"   maxlength="40" size="40" value=" "/> </td>
  </tr>

     
  <tr>
    <td> Message: &nbsp; </td>
    <td><textarea name="message-text" rows="10" cols="100"> </textarea>  </td>
  </tr>

  <tr>
      <td> &nbsp; </td>
      <td> &nbsp; </td>
  </tr>
  
  <tr>
      <td> &nbsp; </td>
      
      <td><INPUT type="submit" value="Send Message"></td>
  </tr>

</table>


</form>

</font>

<% 
	}
%>

</body>
</html>
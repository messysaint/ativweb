<%@ page language="java" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="com.abrstech.obd2.log.*,java.text.Collator,com.abrstech.obd2.security.*" 
%>

<%@ page errorPage="showError.jsp" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>OBDII logs for this VIN</title>

	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />	
	<link type="text/css" href="/ivweb/datepicker/css/south-street/jquery-ui-1.8.22.custom.css" rel="stylesheet" />
	<script type="text/javascript" src="/ivweb/datepicker/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="/ivweb/datepicker/js/jquery-ui-1.8.22.custom.min.js"></script>

	<script type="text/javascript" src="/ivweb/jscript/validateAssessmentForm.js"></script>
	
	<script>
	$(function() {
		$( "#datepicker" ).datepicker({ minDate: -180, maxDate: "+0D" });
	});
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
    	
	String htmlVehicleNotesDetailsLink   = "[&nbsp;&nbsp;<A href=\"/ivweb/providevinviewNotesDetails.jsp\">View History</A>&nbsp;&nbsp;]";
	
%>   	
   	       
<table border="0">
  	 <tr>
   	    <th><%=htmlVehicleNotesDetailsLink%></th>
   	 </tr>  
</table>
	
<form name="assessmentForm" action="/ivweb/saveNewOwnerAssessmentToDB.jsp" onsubmit="return validateAssessmentForm()" method="post">

<table border="0">

  <tr>
      <td>Manually Computed Fuel Efficiency (Distance / Amount of Fuel Used):</td>
      <td></td>
  </tr>
  
  <tr>
      <td> &nbsp; &nbsp; &nbsp; &nbsp;Mix City/Highway Driving: &nbsp; <input type="text" name="cityhighwaympg" maxlength="5" size="5" value="0.0"/></td>
      <td> </td>
  </tr>
  
  <tr>
      <td> &nbsp; &nbsp; &nbsp; &nbsp;City Only Driving: &nbsp; <input type="text" name="citympg" maxlength="5" size="5" value="0.0"/></td>
      <td> </td>
  </tr>
  
  <tr>
      <td> &nbsp; &nbsp; &nbsp; &nbsp;Highway Only Driving: &nbsp; <input type="text" name="highwaympg" maxlength="5" size="5" value="0.0"/></td>
      <td> </td>
  </tr>

  <tr>
    <td> &nbsp;</td>
    <td> </td>
  </tr>
  
  <tr>
      <td>1. Rate your car's reliability and dependability? </td>
      <td> </td>
  </tr>

  <tr>
    <td> 
    	&nbsp; [Low]
		<INPUT type="radio"  name="reliable-group" value="1"> 1 &nbsp; 
		<INPUT type="radio"  name="reliable-group" value="2"> 2 &nbsp; 
		<INPUT type="radio"  name="reliable-group" value="3"> 3 &nbsp; 
		<INPUT type="radio"  name="reliable-group" value="4"> 4 &nbsp; 
		<INPUT type="radio"  name="reliable-group" value="5" checked> 5 &nbsp;  
		<INPUT type="radio"  name="reliable-group" value="6"> 6 &nbsp; 
		<INPUT type="radio"  name="reliable-group" value="7"> 7 &nbsp; 
		<INPUT type="radio"  name="reliable-group" value="8"> 8 &nbsp; 
		<INPUT type="radio"  name="reliable-group" value="9"> 9 &nbsp; 
		<INPUT type="radio"  name="reliable-group" value="10"> 10 &nbsp;
		&nbsp; [High]  
    </td>
    <td> </td>
  </tr>
		
  <tr>
    <td> &nbsp;</td>
    <td> </td>
  </tr>

  <tr>
    <td>Kudos:</td>
    <td> </td>
  </tr>

  <tr>
    <td><textarea name="reliability-kudos-text" rows="5" cols="100"> </textarea> </td>
    <td></td>
  </tr>

  <tr>
    <td> &nbsp;</td>
    <td> </td>
  </tr>

  <tr>
    <td>Complaints:</td>
    <td> </td>
  </tr>

  <tr>
    <td><textarea name="reliability-complaints-text" rows="5" cols="100"> </textarea> </td>
    <td> </td>
  </tr>

  <tr>
    <td> &nbsp;</td>
    <td> </td>
  </tr>

  <tr>
      <td>2. Rate your car's driving comfort for both driver and passenger? </td>
      <td> </td>
  </tr>

  <tr>
    <td> 
    	&nbsp; [Low]
		<INPUT type="radio"  name="comfort-group" value="1"> 1 &nbsp; 
		<INPUT type="radio"  name="comfort-group" value="2"> 2 &nbsp; 
		<INPUT type="radio"  name="comfort-group" value="3"> 3 &nbsp; 
		<INPUT type="radio"  name="comfort-group" value="4"> 4 &nbsp; 
		<INPUT type="radio"  name="comfort-group" value="5" checked> 5 &nbsp;  
		<INPUT type="radio"  name="comfort-group" value="6"> 6 &nbsp; 
		<INPUT type="radio"  name="comfort-group" value="7"> 7 &nbsp; 
		<INPUT type="radio"  name="comfort-group" value="8"> 8 &nbsp; 
		<INPUT type="radio"  name="comfort-group" value="9"> 9 &nbsp; 
		<INPUT type="radio"  name="comfort-group" value="10"> 10 &nbsp;
		&nbsp; [High]  
    </td>
    <td> </td>
  </tr>

  <tr>
    <td> &nbsp;</td>
    <td> </td>
  </tr>

  <tr>
    <td>Kudos:</td>
    <td> </td>
  </tr>

  <tr>
    <td><textarea name="comfort-kudos-text" rows="5" cols="100"> </textarea> </td>
    <td> </td>
  </tr>

  <tr>
    <td> &nbsp;</td>
    <td> </td>
  </tr>

  <tr>
    <td>Complaints:</td>
    <td> </td>
  </tr>

  <tr>
    <td><textarea name="comfort-complaints-text" rows="5" cols="100"> </textarea> </td>
    <td> </td>
  </tr>

  <tr>
    <td> &nbsp;</td>
    <td> </td>
  </tr>

  <tr>
      <td>3. Rate how your car performed in your road driving conditions? </td>
      <td> </td>
  </tr>

  <tr>
    <td> 
    	&nbsp; [Low]
		<INPUT type="radio"  name="performance-group" value="1"> 1 &nbsp; 
		<INPUT type="radio"  name="performance-group" value="2"> 2 &nbsp; 
		<INPUT type="radio"  name="performance-group" value="3"> 3 &nbsp; 
		<INPUT type="radio"  name="performance-group" value="4"> 4 &nbsp; 
		<INPUT type="radio"  name="performance-group" value="5" checked> 5 &nbsp;  
		<INPUT type="radio"  name="performance-group" value="6"> 6 &nbsp; 
		<INPUT type="radio"  name="performance-group" value="7"> 7 &nbsp; 
		<INPUT type="radio"  name="performance-group" value="8"> 8 &nbsp; 
		<INPUT type="radio"  name="performance-group" value="9"> 9 &nbsp; 
		<INPUT type="radio"  name="performance-group" value="10"> 10 &nbsp;
		&nbsp; [High]  
    </td>
    <td> </td>
  </tr>

  <tr>
    <td> &nbsp;</td>
    <td> </td>
  </tr>

  <tr>
    <td>Kudos:</td>
    <td> </td>
  </tr>

  <tr>
    <td><textarea name="performance-kudos-text" rows="5" cols="100"> </textarea> </td>
    <td> </td>
  </tr>

  <tr>
    <td> &nbsp;</td>
    <td> </td>
  </tr>
  
  <tr>
    <td>Complaints:</td>
    <td> </td>
  </tr>
  
  <tr>
    <td><textarea name="performance-complaints-text" rows="5" cols="100"> </textarea> </td>
    <td> </td>
  </tr>

  <tr>
    <td> &nbsp;</td>
    <td> </td>
  </tr>
  
  <tr>
      <td>4. Rate how your car looks? </td>
      <td> </td>
  </tr>

  <tr>
    <td> 
    	&nbsp; [Low]
		<INPUT type="radio"  name="looks-group" value="1"> 1 &nbsp; 
		<INPUT type="radio"  name="looks-group" value="2"> 2 &nbsp; 
		<INPUT type="radio"  name="looks-group" value="3"> 3 &nbsp; 
		<INPUT type="radio"  name="looks-group" value="4"> 4 &nbsp; 
		<INPUT type="radio"  name="looks-group" value="5" checked> 5 &nbsp;  
		<INPUT type="radio"  name="looks-group" value="6"> 6 &nbsp; 
		<INPUT type="radio"  name="looks-group" value="7"> 7 &nbsp; 
		<INPUT type="radio"  name="looks-group" value="8"> 8 &nbsp; 
		<INPUT type="radio"  name="looks-group" value="9"> 9 &nbsp; 
		<INPUT type="radio"  name="looks-group" value="10"> 10 &nbsp;
		&nbsp; [High]  
    </td>
    <td> </td>
  </tr>

  <tr>
    <td> &nbsp;</td>
    <td> </td>
  </tr>
  
  <tr>
    <td>Kudos:</td>
    <td> </td>
  </tr>
 
  <tr>
    <td><textarea name="looks-kudos-text" rows="5" cols="100"> </textarea> </td>
    <td> </td>
  </tr>

  <tr>
    <td> &nbsp;</td>
    <td> </td>
  </tr>
  
  <tr>
    <td>Complaints:</td>
    <td> </td>
  </tr>

  <tr>
    <td><textarea name="looks-complaints-text" rows="5" cols="100"> </textarea> </td>
    <td> </td>
  </tr>

  <tr>
    <td> &nbsp;</td>
    <td> </td>
  </tr>
  
  <tr>
      <td>5. Rate how much you value your car? </td>
      <td> </td>
  </tr>

  <tr>
    <td> 
    	&nbsp; [Low]
		<INPUT type="radio"  name="value-group" value="1"> 1 &nbsp; 
		<INPUT type="radio"  name="value-group" value="2"> 2 &nbsp; 
		<INPUT type="radio"  name="value-group" value="3"> 3 &nbsp; 
		<INPUT type="radio"  name="value-group" value="4"> 4 &nbsp; 
		<INPUT type="radio"  name="value-group" value="5" checked> 5 &nbsp;  
		<INPUT type="radio"  name="value-group" value="6"> 6 &nbsp; 
		<INPUT type="radio"  name="value-group" value="7"> 7 &nbsp; 
		<INPUT type="radio"  name="value-group" value="8"> 8 &nbsp; 
		<INPUT type="radio"  name="value-group" value="9"> 9 &nbsp; 
		<INPUT type="radio"  name="value-group" value="10"> 10 &nbsp;
		&nbsp; [High]  
    </td>
    <td> </td>
  </tr>

  <tr>
    <td> &nbsp;</td>
    <td> </td>
  </tr>
  
  <tr>
    <td>Kudos:</td>
    <td> </td>
  </tr>
 
  <tr>
    <td><textarea name="value-kudos-text" rows="5" cols="100"> </textarea> </td>
    <td> </td>
  </tr>

  <tr>
    <td> &nbsp;</td>
    <td> </td>
  </tr>
  
  <tr>
    <td>Complaints:</td>
    <td> </td>
  </tr>
 
  <tr>
    <td><textarea name="value-complaints-text" rows="5" cols="100"> </textarea> </td>
    <td> </td>
  </tr>
 
  <tr>
    <td> &nbsp;</td>
    <td> </td>
  </tr>
   
  <tr>
      <td>6. Rate your car for overall grade? </td>
      <td> </td>
  </tr>
 
  <tr>
    <td> 
    	&nbsp; [Low]
		<INPUT type="radio"  name="overall-group" value="1"> 1 &nbsp; 
		<INPUT type="radio"  name="overall-group" value="2"> 2 &nbsp; 
		<INPUT type="radio"  name="overall-group" value="3"> 3 &nbsp; 
		<INPUT type="radio"  name="overall-group" value="4"> 4 &nbsp; 
		<INPUT type="radio"  name="overall-group" value="5" checked> 5 &nbsp;  
		<INPUT type="radio"  name="overall-group" value="6"> 6 &nbsp; 
		<INPUT type="radio"  name="overall-group" value="7"> 7 &nbsp; 
		<INPUT type="radio"  name="overall-group" value="8"> 8 &nbsp; 
		<INPUT type="radio"  name="overall-group" value="9"> 9 &nbsp; 
		<INPUT type="radio"  name="overall-group" value="10"> 10 &nbsp;
		&nbsp; [High]  
    </td>
    <td> </td>
  </tr>
 
 
  <tr>
    <td> &nbsp;</td>
    <td> </td>
  </tr>
   
  <tr>
    <td>Other notes and observations:</td>
    <td> </td>
  </tr>
 
  <tr>
    <td><textarea name="other-notes-text" rows="5" cols="100"> </textarea> </td>
    <td> </td>
  </tr>

  <tr>
      <td> &nbsp; </td>
      <td> &nbsp;</td>
  </tr>

  <tr>
      <td> <INPUT type="submit" value="Submit"> </td>
      <td> </td>
  </tr> 

</table>


</form>
<%   	
    } // endif
%>






</font>

</body>
</html>
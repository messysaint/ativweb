<%@ page language="java" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="com.abrstech.obd2.log.*,java.text.Collator" 
%>

<%@ page errorPage="showError.jsp" %>
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>Modify business form</title>

	<script type="text/javascript" src="/ivweb/jscript/validateModifyBusinessForm.js"></script>
	
	
</head>
<body>

<font face="Georgia, Arial, Garamond" size = "2">

<%

	Integer IVWEB_SEQNO = (Integer) session.getAttribute( "IVWEB_SEQNO" ); // retrieve IVWEB_VIN from HTTP Session

	String sessiontimeout = "/ivweb/z_securityqueryTM.jsp";
	
	// check for session timed out
	if( IVWEB_SEQNO == null ) {
		response.sendRedirect( sessiontimeout );
	}
	
	String htmlbreak = "<br>";

	String errorMsg = "<H3>Your information does not match out record ...</H3>";
	
	String answer = request.getParameter( "answer" ).trim().toLowerCase();
	
	Integer SESSIONSeqno = IVWEB_SEQNO;
	String SESSIONCountry = (String) session.getAttribute( "IVWEB_COUNTRY" );
	String SESSIONCitytown = (String) session.getAttribute( "IVWEB_CITYTOWN" );
	String SESSIONState = (String) session.getAttribute( "IVWEB_STATE" );
	String SESSIONZipcode = (String) session.getAttribute( "IVWEB_ZIPCODE" );
	String SESSIONEmail = (String) session.getAttribute( "IVWEB_EMAIL" );
	String SESSIONBusinessname = (String) session.getAttribute( "IVWEB_BUSINESSNAME" );
	String SESSIONBusinessdescription = (String) session.getAttribute( "IVWEB_BUSINESSDESCRIPTION" );
	String SESSIONWebsite = (String) session.getAttribute( "IVWEB_WEBSITE" );
	String SESSIONPhone = (String) session.getAttribute( "IVWEB_PHONE" );
	String SESSIONReminderquestion = (String) session.getAttribute( "IVWEB_REMINDERQUESTION" );
	String SESSIONReminderanswer = (String) session.getAttribute( "IVWEB_REMINDERANSWER" );
	String SESSIONServicedzipcodes = (String) session.getAttribute( "IVWEB_SERVICEDZIPCODES" );
	
	
	SESSIONReminderanswer = SESSIONReminderanswer.trim().toLowerCase();
	
	Collator collator = Collator.getInstance();
	

	int compareAnswer = collator.compare( SESSIONReminderanswer, answer );
	
    if ( compareAnswer == 0 ) {
    	
    	out.println( "<h3>Country: " + SESSIONCountry + "</h3>" );	
    	  		
%>
       
	
<form name="modifybusiness" action="/ivweb/saveBusinessUpdatesToDB.jsp" onsubmit="return validateModifyBusinessForm()" method="post">

<table border="0">

  <tr>
    <td>Person/Business Name: &nbsp;</td>
    <td><input type="text" name="businessname"   maxlength="200" size="50" value="<%=SESSIONBusinessname %>"/> </td>
  </tr>
  
  <tr>
    <td>City/Town: &nbsp;</td>
    <td><input type="text" name="citytown" maxlength="50" size="50" value="<%=SESSIONCitytown %>"/></td>
  </tr>
  
  <tr>
    <td>State: &nbsp;</td>
    <td><input type="text" name="state" maxlength="20" size="20" value="<%=SESSIONState %>"/></td>
  </tr>
  
  <tr>
    <td>ZIP Code: &nbsp;</td>
    <td><input type="text" name="zipcode"   maxlength="5" size="5" value="<%=SESSIONZipcode%>"/> </td>
  </tr>

  <tr>
    <td>Serviced ZIP Code/s: &nbsp;</td>
    <td><input type="text" name="servicedzipcodes"   maxlength="70" size="50" value="<%=SESSIONServicedzipcodes%>"/> </td>
  </tr>
  
  <tr>
    <td>Email: &nbsp;</td>
    <td><input type="text" name="email" maxlength="30" size="30" value="<%=SESSIONEmail%>"/> </td>
  </tr>

  <tr>
    <td>Re-Enter Email: &nbsp;</td>
    <td><input type="text" name="reemail" maxlength="30" size="30" value="<%=SESSIONEmail%>"/> </td>
  </tr>
  
  <tr>
    <td>Business Description: &nbsp;</td>
    <td><textarea name="businessdescription-text" rows="5" cols="50"><%=SESSIONBusinessdescription%></textarea>  </td>
  </tr>
  
  <tr>
    <td>Phone: &nbsp;</td>
    <td><input type="text" name="phone" maxlength="15" size="15" value="<%=SESSIONPhone%>"/> </td>
  </tr>
  
  <tr>
    <td>Website: &nbsp;</td>
    <td><input type="text" name="website" maxlength="200" size="50" value="<%=SESSIONWebsite%>"/> </td>
  </tr>
  
  
</table> 
    
<br>
<br>

<INPUT type="submit" value="Save Updates">
</form>

<%   	
    } else {
    	
    	out.println( errorMsg );
    	//out.println( SESSIONEmail + " " + email );
    	//out.println( SESSIONAnswer + " " + answer );
    	        
    } // end if
%>






</font>

</body>
</html>
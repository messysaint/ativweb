<%@ page language="java" 
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.util.*,com.abrstech.sql.*, com.abrstech.obd2.security.*"
%>

<%@ page errorPage="showError.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Save New VIN to DB</title>
</head>
<body>

<font face="Georgia, Arial, Garamond" size = "2">
 
<% 

String sessiontimeout = "/ivweb/z_securityqueryTM.jsp";

String notFound  = "<h3>This business entity was not found in the database.</h3>";
String message1 = "Display data here and allow user to add information";

checkAuth check = new checkAuth();

String IsHuman = (String) session.getAttribute( "IVWEB_ISHUMAN" );

if( !check.isLoggedIn( IsHuman ) ) {	// if not logged in, ask user to log in
	response.sendRedirect( sessiontimeout );
} else { 
	

	String country = request.getParameter( "country" );
	String email = request.getParameter( "email" );
	
	
	searchBusiness newSrch = new searchBusiness();
	boolean foundOk = newSrch.isExisting( country, email );  
	newSrch.CloseDB();
	
	int seqno = newSrch.getSeqno();
	String businessname = newSrch.getBusinessname();
	String businessdescription = newSrch.getBusinessdescription();
	String website = newSrch.getWebsite();
	String phone = newSrch.getPhone();
	String reminderquestion = newSrch.getReminderquestion();
	String reminderanswer = newSrch.getReminderanswer();
	String servicedzipcodes = newSrch.getServicedzipcodes();
	String citytown = newSrch.getCitytown();
	String state = newSrch.getState();
	String zipcode = newSrch.getZipcode();
	
	// save to DB
	if( !foundOk ) {
		out.println( notFound + "<br>" );
		
	} else {
		out.println( "<h3>Country: " + country + "</h3>" );	
		
		session.setAttribute( "IVWEB_SEQNO", seqno );
		session.setAttribute( "IVWEB_COUNTRY", country ); 
		session.setAttribute( "IVWEB_CITYTOWN", citytown ); 
		session.setAttribute( "IVWEB_STATE", state );
		session.setAttribute( "IVWEB_ZIPCODE", zipcode ); 
		session.setAttribute( "IVWEB_EMAIL", email ); 
		session.setAttribute( "IVWEB_BUSINESSNAME", businessname ); 
		session.setAttribute( "IVWEB_BUSINESSDESCRIPTION", businessdescription );
		session.setAttribute( "IVWEB_WEBSITE", website ); 
		session.setAttribute( "IVWEB_PHONE",  phone); 
		session.setAttribute( "IVWEB_REMINDERQUESTION",  reminderquestion);
		session.setAttribute( "IVWEB_REMINDERANSWER",  reminderanswer);
		session.setAttribute( "IVWEB_SERVICEDZIPCODES",  servicedzipcodes);
%>
		

<form name="verifyidentity" action="/ivweb/showModifyBusinessForm.jsp" method="post">

<table border="0">

  <tr>
    <td>Question: &nbsp;</td>
    <td><%=(String) session.getAttribute( "IVWEB_REMINDERQUESTION" ) %>?</td>
  </tr>
  
  <tr>
    <td>Answer: &nbsp;</td>
    <td><input type="password" name="answer"   maxlength="50" size="50" value=""/> </td>
  </tr>
    
</table> 

<br>
<br>

<INPUT type="submit" value="Submit">

</form>


   
<%
	}
	
}

%>


</font>

</body>
</html>
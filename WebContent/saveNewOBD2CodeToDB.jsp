<%@ page language="java" 
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.util.*,com.abrstech.sql.*,com.abrstech.obd2.security.*,com.abrstech.obd2.util.*"
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
String notSaved  = "<h3>This VIN was not save to DB.  It might be already existing.</h3>";
String message1 = "<h3>This vehicle info has been saved.</h3>";

checkAuth check = new checkAuth();

String IsHuman = (String) session.getAttribute( "IVWEB_ISHUMAN" );

if( !check.isLoggedIn( IsHuman ) ) {	// if not logged in, ask user to log in
	response.sendRedirect( sessiontimeout );
} else { 
	

	String obd2code = (String) session.getAttribute( "SESSION_obd2code" );
	String description = request.getParameter( "description" );
	
	boolean saveOk = false;
	
	obd2code = obd2code.trim();
	description = description.trim();
	
	if( (obd2code.length() == 0)  || (description.length() == 0) ) {
		saveOk = false;
	} else {
		saveNewOBD2Code newOBD2Code = new saveNewOBD2Code();  
		saveOk = newOBD2Code.WriteToDB( obd2code, description );
		newOBD2Code.CloseDB();	
	}
	
	String listall = "/ivweb/showOBD2ListAllTM.jsp";
	response.sendRedirect( listall );
	
}

%>


</font>

</body>
</html>